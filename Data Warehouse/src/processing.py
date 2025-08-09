import mysql.connector
from datetime import datetime, date
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class MotoGPDataWarehouse:
    def __init__(self):
        self.source_connection = None
        self.target_connection = None
        self.batch_date = date.today()
        
    def connect_databases(self):
        """Connect to both source and target databases"""
        try:
            self.source_connection = mysql.connector.connect(
                host='localhost',
                database='motogp',
                user='root',
                password='alvin123'
            )
            
            self.target_connection = mysql.connector.connect(
                host='localhost',
                database='motogp_wh',
                user='root',
                password='alvin123'
            )
            
            logger.info("Successfully connected to both databases")
            return True
            
        except mysql.connector.Error as error:
            logger.error(f"Database connection failed: {error}")
            return False
    
    def clear_existing_data(self):
        """Clear existing data for today's batch to prevent redundancy"""
        try:
            cursor = self.target_connection.cursor()
            
            cursor.execute("DELETE FROM fact_kemenangan_pembalap WHERE batch_date = %s", (self.batch_date,))
            deleted_rows = cursor.rowcount
            
            if deleted_rows > 0:
                logger.info(f"Cleared {deleted_rows} existing records for batch date: {self.batch_date}")
            
            self.target_connection.commit()
            logger.info("Data cleanup completed - no redundancy")
            
        except mysql.connector.Error as error:
            logger.error(f"Error clearing data: {error}")
            self.target_connection.rollback()
    
    def populate_dim_status_pembalap(self):
        """Populate dimension table for rider status (only if empty)"""
        try:
            cursor = self.target_connection.cursor()
            
            cursor.execute("SELECT COUNT(*) FROM dim_status_pembalap")
            count = cursor.fetchone()[0]
            
            if count > 0:
                logger.info(f"dim_status_pembalap already populated: {count} records")
                return
            
            status_data = [
                (1, 1, 'Active Champion'),
                (1, 0, 'Retired Champion'),
                (0, 1, 'Active Non-Champion'),
                (0, 0, 'Retired Non-Champion')
            ]
            
            cursor.executemany("""
                INSERT INTO dim_status_pembalap (is_champion, is_active, status_description) 
                VALUES (%s, %s, %s)
            """, status_data)
            
            self.target_connection.commit()
            logger.info(f"Populated dim_status_pembalap: {cursor.rowcount} records")
            
        except mysql.connector.Error as error:
            logger.error(f"Error populating dim_status_pembalap: {error}")
            self.target_connection.rollback()
    
    def populate_dim_waktu(self):
        """Populate time dimension from race data"""
        try:
            source_cursor = self.source_connection.cursor()
            target_cursor = self.target_connection.cursor()
            
            source_cursor.execute("SELECT DISTINCT tahun FROM balapan ORDER BY tahun")
            years = source_cursor.fetchall()
            
            waktu_data = []
            for (year,) in years:
                decade = f"{(year // 10) * 10}s"
                
                if 1949 <= year <= 1969:
                    era = 'Early Era'
                elif 1970 <= year <= 1989:
                    era = 'Golden Era'
                elif 1990 <= year <= 2001:
                    era = 'Modern Era'
                elif 2002 <= year <= 2011:
                    era = 'Four-Stroke Era'
                else:
                    era = 'Electronic Era'
                
                waktu_data.append((year, decade, era))
            
            target_cursor.executemany("""
                INSERT INTO dim_waktu (tahun, dekade, era) 
                VALUES (%s, %s, %s)
            """, waktu_data)
            
            self.target_connection.commit()
            logger.info(f"Populated dim_waktu: {target_cursor.rowcount} records")
            
        except mysql.connector.Error as error:
            logger.error(f"Error populating dim_waktu: {error}")
            self.target_connection.rollback()
    
    def populate_dim_negara(self):
        """Populate country dimension"""
        try:
            source_cursor = self.source_connection.cursor()
            target_cursor = self.target_connection.cursor()
            
            source_cursor.execute("SELECT id_negara, nama_negara FROM negara")
            countries = source_cursor.fetchall()
            
            target_cursor.executemany("""
                INSERT INTO dim_negara (id_negara_original, nama_negara) 
                VALUES (%s, %s)
            """, countries)
            
            self.target_connection.commit()
            logger.info(f"Populated dim_negara: {target_cursor.rowcount} records")
            
        except mysql.connector.Error as error:
            logger.error(f"Error populating dim_negara: {error}")
            self.target_connection.rollback()
    
    def populate_dim_pembalap(self):
        """Populate rider dimension"""
        try:
            source_cursor = self.source_connection.cursor()
            target_cursor = self.target_connection.cursor()
            
            source_cursor.execute("SELECT id_pembalap, nama FROM pembalap")
            riders = source_cursor.fetchall()
            
            target_cursor.executemany("""
                INSERT INTO dim_pembalap (id_pembalap_original, nama) 
                VALUES (%s, %s)
            """, riders)
            
            self.target_connection.commit()
            logger.info(f"Populated dim_pembalap: {target_cursor.rowcount} records")
            
        except mysql.connector.Error as error:
            logger.error(f"Error populating dim_pembalap: {error}")
            self.target_connection.rollback()
    
    def populate_fact_kemenangan_pembalap(self):
        """Populate fact table with rider wins data"""
        try:
            source_cursor = self.source_connection.cursor()
            target_cursor = self.target_connection.cursor()
            
            source_cursor.execute("""
                SELECT 
                    p.id_pembalap,
                    p.nama,
                    p.jumlah_kemenangan,
                    p.is_champion,
                    p.is_active,
                    p.id_negara,
                    MIN(b.tahun) as first_win_year,
                    MAX(b.tahun) as last_win_year,
                    COUNT(b.id_balapan) as total_races_won
                FROM pembalap p
                LEFT JOIN balapan b ON p.id_pembalap = b.id_pembalap_pemenang
                GROUP BY p.id_pembalap, p.nama, p.jumlah_kemenangan, 
                         p.is_champion, p.is_active, p.id_negara
            """)
            
            riders_data = source_cursor.fetchall()
            
            for rider_data in riders_data:
                (rider_id, nama, total_wins, is_champion, is_active, 
                 negara_id, first_win_year, last_win_year, races_won) = rider_data
                
                if total_wins > 0 and first_win_year and last_win_year:
                    career_span = last_win_year - first_win_year + 1
                    win_rate = round((total_wins * 100.0 / career_span), 2)
                else:
                    win_rate = 0.00
                
                time_year = last_win_year if last_win_year else datetime.now().year
                
                target_cursor.execute("""
                    INSERT INTO fact_kemenangan_pembalap (
                        pembalap_key,
                        negara_key,
                        waktu_key,
                        status_key,
                        total_kemenangan,
                        kemenangan_pertama_tahun,
                        kemenangan_terakhir_tahun,
                        jumlah_balapan_diikuti,
                        win_rate,
                        batch_date
                    )
                    SELECT 
                        dp.pembalap_key,
                        dn.negara_key,
                        dw.waktu_key,
                        ds.status_key,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s,
                        %s
                    FROM dim_pembalap dp
                    JOIN dim_negara dn ON dn.id_negara_original = %s
                    JOIN dim_waktu dw ON dw.tahun = %s
                    JOIN dim_status_pembalap ds ON ds.is_champion = %s AND ds.is_active = %s
                    WHERE dp.id_pembalap_original = %s
                """, (
                    total_wins, first_win_year, last_win_year, races_won, win_rate, self.batch_date,
                    negara_id, time_year, is_champion, is_active, rider_id
                ))
            
            self.target_connection.commit()
            logger.info(f"Populated fact_kemenangan_pembalap: {len(riders_data)} records")
            
        except mysql.connector.Error as error:
            logger.error(f"Error populating fact table: {error}")
            self.target_connection.rollback()
    
    def validate_data_quality(self):
        """Validate data quality in the warehouse"""
        try:
            cursor = self.target_connection.cursor()
            
            checks = {
                'dim_negara': "SELECT COUNT(*) FROM dim_negara",
                'dim_pembalap': "SELECT COUNT(*) FROM dim_pembalap", 
                'dim_waktu': "SELECT COUNT(*) FROM dim_waktu",
                'dim_status_pembalap': "SELECT COUNT(*) FROM dim_status_pembalap",
                'fact_kemenangan_pembalap': f"SELECT COUNT(*) FROM fact_kemenangan_pembalap WHERE batch_date = '{self.batch_date}'"
            }
            
            logger.info("\nData Quality Validation:")
            logger.info("=" * 50)
            
            for table, query in checks.items():
                cursor.execute(query)
                count = cursor.fetchone()[0]
                logger.info(f"{table:25} : {count:>6} records")
            
            cursor.execute("""
                SELECT 
                    SUM(f.total_kemenangan) as total_wins_in_warehouse,
                    (SELECT SUM(jumlah_kemenangan) FROM motogp.pembalap) as total_wins_in_source
                FROM fact_kemenangan_pembalap f
                WHERE f.batch_date = %s
            """, (self.batch_date,))
            
            wh_total, source_total = cursor.fetchone()
            
            logger.info("=" * 50)
            logger.info(f"{'Source Total Wins':25} : {source_total:>6}")
            logger.info(f"{'Warehouse Total Wins':25} : {wh_total:>6}")
            logger.info(f"{'Data Integrity':25} : {'PASS' if wh_total == source_total else 'FAIL'}")
            
        except mysql.connector.Error as error:
            logger.error(f"Error validating data: {error}")
    
    def run_etl_process(self):
        """Run the complete ETL process"""
        logger.info("Starting MotoGP Data Warehouse ETL Process")
        logger.info(f"Batch Date: {self.batch_date}")
        
        if not self.connect_databases():
            return False
        
        try:
            logger.info("\nStep 1: Clearing existing data...")
            self.clear_existing_data()
            
            logger.info("\nStep 2: Populating dimension tables...")
            self.populate_dim_status_pembalap()
            self.populate_dim_waktu()
            self.populate_dim_negara()
            self.populate_dim_pembalap()
            
            logger.info("\nStep 3: Populating fact table...")
            self.populate_fact_kemenangan_pembalap()
            
            logger.info("\nStep 4: Data quality validation...")
            self.validate_data_quality()
            
            logger.info("\nETL Process completed successfully!")
            return True
            
        except Exception as error:
            logger.error(f"ETL process failed: {error}")
            return False
        
        finally:
            if self.source_connection:
                self.source_connection.close()
            if self.target_connection:
                self.target_connection.close()
            logger.info("Database connections closed")

def main():
    """Main function to run the ETL process"""
    etl = MotoGPDataWarehouse()
    success = etl.run_etl_process()
    
    if success:
        print("\nData Warehouse successfully populated!")
        print(f"You can now query the motogp_wh database for analytics")
    else:
        print("\nETL process failed. Check the logs for details.")

if __name__ == "__main__":
    main()