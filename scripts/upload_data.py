import boto3
import os

def upload_data_to_s3(bucket_name, file_name, object_name=None):
    session = boto3.Session(profile_name='default')
    s3_client = session.client('s3')

    try:
        response = s3_client.upload_file(file_name, bucket_name, object_name or file_name)
        print(response)
    except Exception as e:
        print(f"Error uploading file: {e}")
        return False
    return True

if __name__ == "__main__":
    bucket_name = "leon-katz-hadrian-ml-data-bucket"
    file_name = "sample_data.csv"
    object_name = "sample_data.csv"
    # Upload the CSV file to S3
    if upload_data_to_s3(bucket_name, file_name, object_name):
        print(f"'{file_name}' uploaded successfully to bucket '{bucket_name}'")
    else:
        print("File upload failed.")
