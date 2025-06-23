#!/bin/bash

set -e
source ./config.env

echo "🔍 Identifying records older than $CUTOFF_DATE..."

# Query Cosmos DB and extract old records using Python script
python3 archive_records.py "$COSMOS_DB_URI" "$COSMOS_DB_KEY" "$COSMOS_DB_NAME" "$COSMOS_CONTAINER_NAME" "$CUTOFF_DATE"

ARCHIVE_FILE="archived_records_$(date +%Y%m%d%H%M%S).json"

# Upload archived records to Blob Storage
echo "⬆️ Uploading archived data to Azure Blob Storage..."
az storage blob upload \
    --account-name "$STORAGE_ACCOUNT_NAME" \
    --container-name "$STORAGE_CONTAINER_NAME" \
    --name "$ARCHIVE_FOLDER/$ARCHIVE_FILE" \
    --file "./$ARCHIVE_FILE" \
    --auth-mode login

echo "✅ Uploaded as $ARCHIVE_FILE"

# Cleanup
rm "$ARCHIVE_FILE"
