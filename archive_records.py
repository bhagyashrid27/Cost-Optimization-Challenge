import sys
import json
import datetime
import requests

from azure.cosmos import CosmosClient, PartitionKey

uri = sys.argv[1]
key = sys.argv[2]
db_name = sys.argv[3]
container_name = sys.argv[4]
cutoff_date_str = sys.argv[5]

cutoff_date = datetime.datetime.strptime(cutoff_date_str, "%Y-%m-%d")

client = CosmosClient(uri, credential=key)
db = client.get_database_client(db_name)
container = db.get_container_client(container_name)

query = f"SELECT * FROM c WHERE c.createdAt < '{cutoff_date.isoformat()}'"
items = list(container.query_items(query=query, enable_cross_partition_query=True))

filename = f"archived_records_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.json"
with open(filename, 'w') as f:
    json.dump(items, f, indent=2)

# Optionally delete records from Cosmos DB
for item in items:
    container.delete_item(item=item, partition_key=item['partitionKey'])

print(f"Archived {len(items)} records to {filename}")
