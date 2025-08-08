"""
Database Configuration File
Modify these settings according to your MySQL setup
"""

# Database connection configuration
DATABASE_CONFIG = {
    'host': 'localhost',
    'user': 'root',           # Change to your MySQL username
    'password': '',           # Change to your MySQL password
    'database': 'boardgame_db',
    'charset': 'utf8mb4',
    'collation': 'utf8mb4_unicode_ci',
    'autocommit': False
}

# For production, consider using environment variables:
# import os
# DATABASE_CONFIG = {
#     'host': os.getenv('DB_HOST', 'localhost'),
#     'user': os.getenv('DB_USER', 'root'),
#     'password': os.getenv('DB_PASSWORD', ''),
#     'database': os.getenv('DB_NAME', 'boardgame_db'),
#     'charset': 'utf8mb4',
#     'collation': 'utf8mb4_unicode_ci',
#     'autocommit': False
# }
