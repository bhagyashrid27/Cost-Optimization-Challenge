# 🔄 Azure Billing Record Archival Automation

This project automates the archival of older billing records (older than 3 months) from **Azure Cosmos DB** to **Azure Blob Storage**, using a simple **Bash + Python** approach with **Azure CLI**.

---

## 📌 Problem Statement

Over time, Cosmos DB costs increase due to growing read-heavy data, especially with infrequently accessed records. This solution:
- Reduces Cosmos DB storage costs
- Retains cold data in Blob Storage
- Maintains API availability and consistency

---

## 📁 Folder Structure

Cost-Optimization-Challenge/
│
├── archive.sh # Bash script to automate the task
├── archive_records.py # Python script to extract and archive data
├── config.env # Environment variables
└── README.md # This file
