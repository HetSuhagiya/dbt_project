
## Development Log

### 20/11/2026 | Initial Setup & Staging Models

#### 1. Environment Setup
- Connected dbt to Google BigQuery and configured the relevant project and dataset.
- Uploaded the Olist e-commerce dataset into BigQuery.
- Connected dbt to a new GitHub repository for version control.

#### 2. Project Initialisation
- Initialised the dbt project, generating the default directory structure, including `models/`, `seeds/`, and other configuration files.
- Created a separate `staging` branch in GitHub to develop and test changes before merging them into `main`.
- Executed `dbt run` to build the two default example models.
- Confirmed that both models ran successfully, validating the connection between dbt and BigQuery.

#### 3. Source Configuration
- Created a `staging/` directory inside `models/` to organise the staging layer.
- Added `_sources.yml` to declare the raw Olist tables stored in BigQuery.
- Configured source references to allow staging models to access raw tables using dbt's `source()` function.

#### 4. Staging Model Development
- Created SQL staging models for the relevant Olist source tables.
- Standardised column names and converted fields to appropriate data types using SQL transformations.
- Used dbt's `source()` function to reference the declared BigQuery source tables.

#### 5. Data Quality Testing
- Added data quality tests in the staging YAML configuration.
- Configured `unique` and `not_null` tests for key identifiers in the customers, products, and sellers models.
- Added a `relationships` test to validate that order IDs in the order items model exist in the orders model.

#### 6. Issues Encountered
**Issue: Tests executed before models existed in BigQuery.**

- Encountered an issue where dbt attempted to test models that had not yet been materialised in BigQuery.
- Identified the model build order as the cause.

**Next Step:**
- Build the staging models before running the configured tests.
- Use `dbt build` to execute models and their associated tests in dependency order.
- Validate the staging layer before proceeding to intermediate transformations.
