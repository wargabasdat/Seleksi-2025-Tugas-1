import psycopg2

# Koneksi ke database data_storing (OLTP)
conn_storing = psycopg2.connect(
    host="localhost",  
    dbname="top100_laptop_screen", 
    user="postgres",     
    password="Matthew487214"  
)
cur_storing = conn_storing.cursor()

# Koneksi ke database warehouse (OLAP)
conn_warehouse = psycopg2.connect(
    host="localhost",  
    dbname="data_warehouse_laptop",  
    user="postgres",         
    password="Matthew487214" 
)
cur_warehouse = conn_warehouse.cursor()


# Load dim_laptop 
cur_storing.execute('''
    SELECT l.laptop_id, l.laptop_name, MIN(lc.price) as min_price
    FROM laptop l
    JOIN laptop_configuration lc ON l.laptop_id = lc.laptop_id
    GROUP BY l.laptop_id, l.laptop_name
''')
dim_laptop_data = cur_storing.fetchall()
cur_warehouse.executemany(
    "INSERT INTO dim_laptop (laptop_id, laptop_name, start_price) VALUES (%s, %s, %s)",
    dim_laptop_data
)

# Load dim_cpu 
cur_storing.execute('''
    SELECT c.cpu_id, c.cpu_name, MIN(cp.cpu_performance_ranking) as cpu_rank
    FROM cpu c
    LEFT JOIN cpu_performance cp ON c.cpu_id = cp.cpu_id
    GROUP BY c.cpu_id, c.cpu_name
''')
dim_cpu_data = cur_storing.fetchall()
cur_warehouse.executemany(
    "INSERT INTO dim_cpu (cpu_id, cpu_name, cpu_rank) VALUES (%s, %s, %s)",
    dim_cpu_data
)

# Load dim_gpu 
cur_storing.execute('''
    SELECT g.gpu_id, g.gpu_name, MIN(gp.gpu_performance_ranking) as gpu_rank
    FROM gpu g
    LEFT JOIN gpu_performance gp ON g.gpu_id = gp.gpu_id
    GROUP BY g.gpu_id, g.gpu_name
''')
dim_gpu_data = cur_storing.fetchall()
cur_warehouse.executemany(
    "INSERT INTO dim_gpu (gpu_id, gpu_name, gpu_rank) VALUES (%s, %s, %s)",
    dim_gpu_data
)

# Load dim_config 
cur_storing.execute("SELECT config_id, ram, storage, os FROM laptop_configuration")
dim_config_data = cur_storing.fetchall()
cur_warehouse.executemany(
    "INSERT INTO dim_config (config_id, ram_size, storage_size, operating_system) VALUES (%s, %s, %s, %s)",
    dim_config_data
)

# Load fact_laptop_performance 
cur_storing.execute('''
    SELECT
        l.laptop_id,
        c.cpu_id,
        g.gpu_id,
        lc.config_id,
        ls.color_score,
        ls.max_brightness_score AS brightness_score,
        ls.contrast_score,
        ls.dci_p3_score,
        ls.eye_safety_score,
        cp.cpu_benchmark_score,
        (COALESCE(cp.cpu_performance_percentage,0) + COALESCE(gp.gpu_performance_percentage,0))/2 AS total_score,
        l.rank AS laptop_ranking
    FROM Laptop l
    JOIN Laptop_Configuration lc ON l.laptop_id = lc.laptop_id
    JOIN CPU c ON lc.cpu_id = c.cpu_id
    JOIN GPU g ON lc.gpu_id = g.gpu_id
    LEFT JOIN Laptop_Score ls ON l.laptop_id = ls.laptop_id
    LEFT JOIN CPU_Performance cp ON c.cpu_id = cp.cpu_id
    LEFT JOIN GPU_Performance gp ON g.gpu_id = gp.gpu_id
''')
fact_data = cur_storing.fetchall()
cur_warehouse.executemany(
    """
    INSERT INTO fact_laptop_performance (
        laptop_id, cpu_id, gpu_id, config_id,
        color_score, brightness_score, contrast_score, dci_p3_score, eye_safety_score,
        cpu_benchmark_score, total_score, laptop_ranking
    ) VALUES (
        %s, %s, %s, %s, %s,
        %s, %s, %s, %s, %s, %s,
        %s
    )
    ON CONFLICT (laptop_id, cpu_id, gpu_id, config_id) DO NOTHING
    """,
    fact_data
)

# Commit dan tutup koneksi
conn_warehouse.commit()
cur_storing.close()
cur_warehouse.close()
conn_storing.close()
conn_warehouse.close()
