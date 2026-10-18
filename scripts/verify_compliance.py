import boto3
from botocore.exceptions import ClientError

def verify_bucket_encryption(bucket_name: str) -> bool:
    s3_client = boto3.client("s3", region_name="ap-southeast-2")
    try:
        response = s3_client.get_bucket_encryption(Bucket=bucket_name)
        rules = response.get("ServerSideEncryptionConfiguration", {}).get("Rules", [])
        print(f"[PASS] Encryption verified for {bucket_name}: {rules}")
        return True
    except ClientError as err:
        print(f"[FAIL] Could not verify encryption for {bucket_name}: {err}")
        return False

if __name__ == "__main__":
    verify_bucket_encryption("sec-audit-logs-prod-1026")
