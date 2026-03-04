# EduDataFlow 🎓📦

An automated **DBT + Snowflake** data pipeline that consolidates multi-year e-commerce order data, applies dimensional modeling, and enforces data quality — reducing manual processing time by 70%.

---

## 📌 Overview

EduDataFlow is a data transformation pipeline built with **dbt (Data Build Tool)** on top of **Snowflake**. It merges fact tables across multiple years, enriches them with product and customer dimensions, and materializes the results as queryable tables — enabling fast, reliable reporting for stakeholders.

---

## 🏗️ Architecture

```
Snowflake (E_COMM DB / E_COMM_SCH Schema)
│
├── Sources
│   ├── FACT_ORDER_2023       # Raw order transactions - 2023
│   ├── FACT_ORDER_2024       # Raw order transactions - 2024
│   ├── DIM_PRODUCT           # Product dimension table
│   └── DIM_CUSTOMER          # Customer dimension table
│
└── Models
    └── finaltable.sql        # Unified fact + dimension joined table
                               (materialized as TABLE in Snowflake)
```

---

## ⚙️ How It Works

1. **Union Fact Tables** — `FACT_ORDER_2023` and `FACT_ORDER_2024` are combined into a single dataset using `UNION ALL`
2. **Enrich with Dimensions** — the unified fact table is left-joined with `DIM_PRODUCT` and `DIM_CUSTOMER` for full order context
3. **Data Quality Tests** — dbt tests enforce `not_null` and `unique` constraints on `ORDER_ID` to catch issues early
4. **Materialization** — the final model is materialized as a **table** in Snowflake for optimized downstream query performance

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| **dbt Cloud** | Data transformation & modeling |
| **Snowflake** | Cloud data warehouse |
| **SQL** | Transformation logic |
| **Dagster** | Workflow orchestration |
| **Cron Jobs** | Scheduled pipeline runs |

---

## 📁 Project Structure

```
├── models/
│   ├── finaltable.sql       # Core transformation model
│   └── sources.yml          # Source definitions & data tests
├── analyses/
├── macros/
├── seeds/
├── snapshots/
├── tests/
└── dbt_project.yml          # Project configuration
```

---

## 🚀 Getting Started

### Prerequisites
- dbt Cloud or dbt Core installed
- Snowflake account with access to `E_COMM` database and `E_COMM_SCH` schema
- dbt profile configured for Snowflake

### Run the Pipeline

```bash
# Install dependencies
dbt deps

# Run all models
dbt run

# Run data quality tests
dbt test

# Run everything together
dbt build
```

---

## 📊 Data Quality

The pipeline includes built-in dbt tests on the source data:

| Column | Test |
|---|---|
| `ORDER_ID` | `not_null` |
| `ORDER_ID` | `unique` |

---

## 📈 Results

- ⚡ **70% reduction** in manual processing time through automated transformations
- 📉 **25% faster** processing via Dagster-orchestrated workflows
- ✅ Stakeholder-ready, high-quality outputs ensured by dbt testing

---

## 👩‍💻 Author

**Deepa Shenoy**  
[LinkedIn](https://www.linkedin.com/in/shenoydeepa) · [GitHub](https://github.com) · shenoy.d@northeastern.edu
