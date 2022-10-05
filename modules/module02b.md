# Module 02B - Register & Scan (Azure SQL DB)

[< Previous Module](../modules/module02a.md) - **[Home](../README.md)** - [Next Module >](../modules/module03.md)

## :loudspeaker: Introduction

To populate Microsoft Purview with assets for data discovery and understanding, we must register sources that exist across our data estate so that we can leverage the out of the box scanning capabilities. Scanning enables Microsoft Purview to extract technical metadata such as the fully qualified name, schema, data types, and apply classifications by parsing a sample of the underlying data.

In this module, you'll walk through how to register and scan data sources. You'll create a new collection for your first data source, upload data and configure scanning. By the end of this module you'll have technical metadata, such as schema information, stored in Purview. You can use this to start linking to business terms, allowing your team members to find data more easily.

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/free/) with an active subscription.
* An Azure SQL Database (see [module 00](../modules/module00.md)).
* A Microsoft Purview account (see [module 01](../modules/module01.md)).

## :dart: Objectives

* Register and scan an Azure SQL Database using SQL authentication credentials stored in Azure Key Vault.

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [Key Vault Access Policy #1 (Grant Yourself Access)](#1-key-vault-access-policy-1-grant-yourself-access) | Azure Administrator |
| 2 | [Key Vault Access Policy #2 (Grant Microsoft Purview Access)](#2-key-vault-access-policy-2-grant-microsoft-purview-access) | Azure Administrator |
| 3 | [Generate a Secret](#3-generate-a-secret) | Azure Administrator |
| 4 | [Add Credentials to Microsoft Purview](#4-add-credentials-to-microsoft-purview) | Microsoft Purview Administrator |
| 5 | [Register a Source (Azure SQL DB)](#5-register-a-source-azure-sql-db) | Data Source Administrator |
| 6 | [Scan a Source with Azure Key Vault Credentials](#6-scan-a-source-with-azure-key-vault-credentials) | Data Source Administrator |
| 7 | [View Assets](#7-view-assets) | Data Reader |

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 1. Key Vault Access Policy #1 (Grant Yourself Access)

> :bulb: **Did you know?**
>
> **Azure Key Vault** is a cloud service that provides a secure store for secrets. Azure Key Vault can be used to securely store keys, passwords, certificates, and other secrets. For more information, check out [About Azure Key Vault](https://docs.microsoft.com/azure/key-vault/general/overview).

Before we can add secrets (such as passwords) to Azure Key Vault, we need to set up an [Access Policy](https://docs.microsoft.com/azure/key-vault/general/assign-access-policy?tabs=azure-portal). The access policy being created in this particular step, ensures that our account has sufficient permissions to create a secret, which will later be used by Microsoft Purview to perform a scan.

1. Navigate to your **Azure Key Vault** resource and click **Access policies**.

    ![Access Policies](../images/module02/02.84-keyvault-policies.png)

1. Click **➕ Create**.

    ![Add Access Policy](../images/module02/02.85-keyvault-addpolicy.png)

1. Under **Secret permissions**, click **Select all**. Then, click **Next**.

    ![Secret Permissions](../images/module02/02.86-secret-permissions.png)

1. Search for your **account name**, select your account name from the search results, then click **Next**.

    ![Search Principal](../images/module02/02.87-principal-select.png)

1. Skip the **Application (optional)** page by clicking **Next** again.

1. Review your selections then click **Create**.

    ![Review Access Policy](../images/module02/02.88-review-permissions.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 2. Key Vault Access Policy #2 (Grant Microsoft Purview Access)

In this next step, we are creating a second access policy which will provide Microsoft Purview the necessary access to retrieve secrets from the Key Vault.

1. Navigate to your **Azure Key Vault** resource and click **Access policies**.

    ![Access Policies](../images/module02/02.84-keyvault-policies.png)

1. Click **➕ Create**.

    ![Add Access Policy](../images/module02/02.85-keyvault-addpolicy.png)

1. Under **Secret permissions**, select **Get** and **List**. Then, click **Next**.

    ![Secret Permissions](../images/module02/02.89-secret-permissions.png)

1. Search for the name of your Microsoft Purview account (e.g. `pvlab-{randomID}-pv`), select the item, then click **Next**.

    ![Search Principal](../images/module02/02.90-principal-select.png)

1. Skip the **Application (optional)** page by clicking **Next** again.

1. Review your selections then click **Create**.

    ![Review Access Policy](../images/module02/02.88-review-permissions.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 3. Generate a Secret

In order to securely store our Azure SQL Database password, we need to generate a secret.

1. Navigate to **Secrets** and click **Generate/Import**.

    ![Generate Secret](../images/module02/02.55-vault-secrets.png)

2. **Copy** and **paste** the values below into the matching fields and then click **Create**.

    **Name**

    ```text
    sql-secret
    ```

    **Value**

    ```text
    sqlPassword!
    ```

    ![Create Secret](../images/module02/02.56-vault-sqlsecret.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 4. Add Credentials to Microsoft Purview

To make the secret accessible to Microsoft Purview, we must first establish a connection to Azure Key Vault.

1. Open the **Microsoft Purview Governance Portal**, navigate to **Management Center** > **Credentials**, click **Manage Key Vault connections**.

    ![Manage Key Vault Connections](../images/module02/02.57-management-vault.png)

2. Click **New**.

    ![New Key Vault Connection](../images/module02/02.58-vault-new.png)

3. **Copy** and **paste** the value below to set the name of your **Key Vault connection**, and then use the drop-down menu items to select the appropriate **Subscription** and **Key Vault name**, then click **Create**.

    **Name**

    ```text
    myKeyVault
    ```

    ![Create Key Vault Connection](../images/module02/02.59-vault-create.png)

4. Since we have already granted the Microsoft Purview managed identity access to our Azure Key Vault, click **Confirm**.

    ![ALT](../images/module02/02.60-vault-access.png)

5. Click **Close**.

    ![ALT](../images/module02/02.61-vault-close.png)

6. Under **Credentials** click **New**.

    ![ALT](../images/module02/02.62-credentials-new.png)

7. Using the drop-down menu items, set the **Authentication method** to `SQL authentication` and the **Key Vault connection** to `myKeyVault`. Once the drop-down menu items are set, **Copy** and **paste** the values below into the matching fields, and then click **Create**.

    **Name**

    ```text
    credential-SQL
    ```

    **User name**

    ```text
    sqladmin
    ```

    **Secret name**

    ```text
    sql-secret
    ```

    ![ALT](../images/module02/02.63-credentials-create.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 5. Register a Source (Azure SQL DB)

1. Open the **Microsoft Purview Governance Portal**, navigate to **Data map** > **Sources**, and click **Register**.

    ![ALT](../images/module02/02.42-sources-register.png)

2. Search for `SQL Database`, select **Azure SQL Database**, and click **Continue**.

    ![ALT](../images/module02/02.43-register-sqldb.png)

3. Select the **Azure subscritpion**, **Server name**, and **Collection**. Click **Register**.

    ![ALT](../images/module02/02.44-register-azuresql.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 6. Scan a Source with Azure Key Vault Credentials

1. Open the **Microsoft Purview Governance Portal**, navigate to **Data map** > **Sources**, and within the Azure SQL Database tile, click the **New Scan** button.

    ![ALT](../images/module02/02.64-sources-scansql.png)

2. Select your **Database** (e.g. `pvlab-{randomID}-sqldb`), set the **Credential** to `credential-SQL`, turn **Lineage extraction** to `Off`, and click **Test connection**. Once the connection test is successful, click **Continue**.

    > Note: If the "Test connection" appears to be hanging, click Cancel and re-try.

    ![ALT](../images/module02/02.65-sqlscan-credentials.png)

3. Click **Continue**.

    ![ALT](../images/module02/02.66-sqlscan-scope.png)

4. Click **Continue**.

    ![ALT](../images/module02/02.67-sqlscan-scanruleset.png)

5. Set the trigger to **Once**, click **Continue**.

    ![ALT](../images/module02/02.68-sqlscan-schedule.png)

6. Click **Save and Run**.

    ![ALT](../images/module02/02.69-sqlscan-run.png)

7. To monitor the progress of the scan, click **View Details**.

    ![ALT](../images/module02/02.70-sqlscan-details.png)

8. Click **Refresh** to periodically update the status of the scan. Note: It will take approximately 5 to 10 minutes to complete.

    ![ALT](../images/module02/02.71-sqlscan-refresh.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 7. View Assets

1. To view the assets that have materialised as an outcome of running the scans, perform a wildcard search by typing the asterisk character (`*`) into the search bar and hitting the Enter key to submit the query and return the search results.

    ![ALT](../images/module02/02.83-search-wildcard2.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## :mortar_board: Knowledge Check

> Note: This is the same knowledge check referenced in Module 2A. If you have already completed the knowledge check from the previous module, please skip this step.

[https://aka.ms/purviewlab/q02](https://aka.ms/purviewlab/q02)

1. What type of object can help organize data sources into logical groups?

    A ) Buckets  
    B ) Collections  
    C ) Groups  

2. At which point does Microsoft Purview begin to populate the data map with assets?

    A ) After a Microsoft Purview account is created  
    B ) After a Data Source has been registered  
    C ) After a Data Source has been scanned

3. Which of the following attributes is **not** automatically assigned to an asset as a result of the system-built scanning functionality?

    A ) Technical Metadata (e.g. Fully Qualified Name, Path, Schema, etc)  
    B ) Glossary Terms (e.g. column `Sales Tax` is tagged with the `Sales Tax` glossary term)  
    C ) Classifications (e.g. column `ccnum` is tagged with the `Credit Card Number` classification)  

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to create a collection, register a source, and trigger a scan.

[Continue >](../modules/module03.md)
