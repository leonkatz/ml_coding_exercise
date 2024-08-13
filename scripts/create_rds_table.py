import psycopg2
from psycopg2 import sql

def create_table(db_conn, table_name):
    """Create a table in the PostgreSQL database"""
    create_table_query = sql.SQL("""
        CREATE TABLE IF NOT EXISTS {table} (
            id INT PRIMARY KEY,
            name VARCHAR(100),
            age INT,
            email VARCHAR(100)
        );
    """).format(table=sql.Identifier(table_name))

    cursor = db_conn.cursor()

    try:
        cursor.execute(create_table_query)
        db_conn.commit()
        print(f"Table '{table_name}' created successfully.")
    except Exception as e:
        print(f"Error creating table: {e}")
        db_conn.rollback()
    finally:
        cursor.close()

if __name__ == "__main__":
    db_conn = psycopg2.connect(
        host="ml-rds.cfqouu80ew20.us-west-1.rds.amazonaws.com:5432",
        database="mlopsdb",
        user="ml_user",
        password="{password_secret}"
    )

    # Specify the table name you want to create
    table_name = "my_users"

    # Create the table
    create_table(db_conn, table_name)

    # Close the DB connection
    db_conn.close()
