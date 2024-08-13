import boto3
import pandas as pd
import psycopg2
import os

def download_from_s3(bucket_name, file_name, download_path):
    """Download a file from an S3 bucket"""
    s3_client = boto3.client('s3')

    try:
        s3_client.download_file(bucket_name, file_name, download_path)
    except Exception as e:
        print(f"Error downloading file: {e}")
        return False
    return True

def process_csv(file_path):
    """Process the CSV file (example: change all names to uppercase)"""
    data = pd.read_csv(file_path)
    data['name'] = data['name'].str.upper()  # Example transformation
    return data

def upload_to_rds(data, db_conn, table_name):
    """Upload processed data to RDS PostgreSQL"""
    cursor = db_conn.cursor()

    for _, row in data.iterrows():
        cursor.execute(f"INSERT INTO {table_name} (id, name, age, email) VALUES (%s, %s, %s, %s)",
                       (row['id'], row['name'], row['age'], row['email']))

    db_conn.commit()
    cursor.close()

if __name__ == "__main__":
    bucket_name = "leon-katz-hadrian-ml-data-bucket"
    file_name = "sample_data.csv"
    download_path = "/tmp/sample_data.csv"  # Temporary download location
    password_secret = os.getenv('db_password')

    # Download CSV file from S3
    if download_from_s3(bucket_name, file_name, download_path):
        print(f"'{file_name}' downloaded successfully from bucket '{bucket_name}'")

        # Process the CSV file
        processed_data = process_csv(download_path)
        print("Data processed successfully.")

        # Connect to RDS PostgreSQL
        db_conn = psycopg2.connect(
            host="ml-rds.cfqouu80ew20.us-west-1.rds.amazonaws.com:5432",
            database="mlopsdb",
            user="ml_user",
            password="{password_secret}"
        )

        # Upload data to RDS
        upload_to_rds(processed_data, db_conn, "my_users")
        print("Data uploaded to RDS successfully.")

        # Close the DB connection
        db_conn.close()

    else:
        print("File download failed.")
