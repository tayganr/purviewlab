# Module 02B - Register & Scan (Azure SQL DB)

[< Previous Module](../modules/module02a.md) - **[Home](../README.md)** - [Next Module >](../modules/module03.md)

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).

## :loudspeaker: Introduction

To populate Azure Purview with assets for data discovery and understanding, we must register sources that exist across our data estate so that we can leverage the out of the box scanning capabilities. Scanning enables Azure Purview to extract technical metadata such as the fully qualified name, schema, data types, and apply classifications by parsing a sample of the underlying data. In this module, we will walk through how to register and scan data sources.

## :dart: Objectives

* Register and scan an Azure SQL Database using SQL authentication credentials stored in Azure Key Vault.

## Table of Contents

1. [Create an Azure SQL Database](#1-create-an-azure-sql-database)
1. [Create an Azure Key Vault](#2-create-an-azure-key-vault)
1. [Add Credentials to Azure Purview](#3-add-credentials-to-azure-purview)
1. [Register a Source (Azure SQL DB)](#4-register-a-source-azure-sql-db)
1. [Scan a Source with Azure Key Vault Credentials](#5-scan-a-source-with-azure-key-vault-credentials)
1. [View Assets](#6-view-assets)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 1. Create an Azure SQL Database

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account and from the **Home** screen, click **Create a resource**.

    ![Azure Purview](../images/module01/01.01-create-resource.png)  

2.  Search for `Azure SQL` and click **Create**.

    ![](../images/module02/02.31-create-sql.png)

3. Select **Single database** and click **Create**.

    ![](../images/module02/02.32-singledb-create.png)

4. Under the **Basics** tab, select a **Resource group** (e.g. `resourcegroup-1`), provide a **Database name** (e.g. `sqldb-team01`) and under **Server** click **Create new**.
 
    ![](../images/module02/02.33-sqlsvr-create.png)

5. Provide the necessary inputs and click **OK**.

    > Note: The table below provides example values for illustrative purposes only, ensure to specify values that make sense for your deployment.

    | Property  | Example Value |
    | --- | --- |
    | Server name | `sqlsvr-team01` |
    | Server admin login | `team01` |
    | Password | `<your-sql-admin-password>` |
    | Confirm password | `<your-sql-admin-password>` |
    | Location | `East US 2` |

    > Note: The **admin login** and **password** will be required later in the module. Make note of these two values.

    ![](../images/module02/02.34-sqlsvr-new.png)

6. Click **Configure database**.

    ![](../images/module02/02.35-sqldb-configure.png)

7. Select **Serverless** and click **Apply**.

    ![](../images/module02/02.36-sqldb-serverless.png)

8. Navigate to the **Additional settings** tab, select **Sample**, click **Review + create**.

    ![Additional Settings](../images/module02/02.37-sqldb-sample.png)

9. Click **Create**.

    ![](../images/module02/02.38-sqldb-create.png)

10. Once the deployment is complete, click **Go to resource**.

    ![](../images/module02/02.39-sqldb-complete.png)

11. Navigate to the **Server**.

    ![](../images/module02/02.40-sqldb-server.png)

12. Click **Firewalls and virtual networks**, set **Allow Azure services and resources to access this server** to **Yes**, click **Save**.

    ![](../images/module02/02.41-sqlsvr-firewall.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 2. Create an Azure Key Vault

1. From the **Home** screen of the Azure Portal, click **Create a resource**.

    ![Azure Purview](../images/module01/01.01-create-resource.png)  

2. Search for `Key Vault` and click **Create**.

    ![](../images/module02/02.45-create-vault.png)

3. Under the **Basics** tab, select a **Resource group** (e.g. `resourcegroup-1`), provide a **Key vault name** (e.g. `vault-team01`), select a Region (e.g. `East US 2`). 

    ![](../images/module02/02.46-vault-basics.png)

9. Click **Review + create**.

10. Click **Create**.

    ![](../images/module02/02.53-vault-create.png)

11. Once your deployment is complete, click **Go to resource**.

    ![](../images/module02/02.54-vault-goto.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 3. Grant Access to Azure Purview using Key Vault Access Policy 

1. Navigate to your **Azure Key Vault** resource and click **Access policies**
    
    ![](../images/module02/02.73-keyvault-policies.png)

2. Click **Add Access Policy**.

    ![](../images/module02/02.74-keyvault-addpolicy.png)

3. Under **Select principal**, click **None selected**.

    ![](../images/module02/02.48-policy-select.png)

4. Search for the name of your Azure Purview account (e.g. `purview-team01`), select the item, click **Select**.

    ![](../images/module02/02.49-policy-principal.png)

5. Under **Secret permissions**, select **Get** and **List**.

    ![](../images/module02/02.50-secret-permissions.png)

6. Review your selections and click **Add**.

    ![](../images/module02/02.51-policy-add.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 4. Generate a Secret

1. Navigate to **Secrets** and click **Generate/Import**.

    ![](../images/module02/02.55-vault-secrets.png)

2. Under **Name** type `sql-secret`. Under **Value** provide the same password that was specified for the SQL Server admin account created earlier in step 7.5. Click **Create**.

    ![](../images/module02/02.56-vault-sqlsecret.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 5. Add Credentials to Azure Purview

1. To make the secret accessible to Azure Purview, we must establish a connection to Azure Key Vault. Open **Purview Studio**, navigate to **Management Center** > **Credentials**, click **Manage Key Vault connections**.

    ![](../images/module02/02.57-management-vault.png)

2. Click **New**.

    ![](../images/module02/02.58-vault-new.png)

3. Use the drop-down menus to select the appropriate **Subscription** and **Key Vault name**. Click **Create**.

    ![](../images/module02/02.59-vault-create.png)

4. Since we have already granted the Purview managed identity access to our Azure Key Vault, click **Confirm**.

    ![](../images/module02/02.60-vault-access.png)

5. Click **Close**.

    ![](../images/module02/02.61-vault-close.png)

6. Under **Credentials** click **New**.

    ![](../images/module02/02.62-credentials-new.png)

7. Provide the necessary details and click **Create**.

    * Overwrite the **Name** to `credential-SQL`
    * Set the **Authentication method** to `SQL authentication`
    * Set the **User name** to the SQL Server admin login specified earlier (e.g. `team01`)
    * Select the **Key Vault connection**
    * Set the **Secret name** to `sql-secret`

    ![](../images/module02/02.63-credentials-create.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 6. Register a Source (Azure SQL DB)

1. Open Purview Studio, navigate to **Sources** and click **Register**.

    ![](../images/module02/02.42-sources-register.png)

2. Navigate to the **Azure** tab, select **Azure SQL Database**, click **Continue**.

    ![](../images/module02/02.43-register-sqldb.png)

3. Select the **Azure subscritpion**, **Server name**, and **Collection**. Click **Register**.

    ![](../images/module02/02.44-register-azuresql.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 7. Scan a Source with Azure Key Vault Credentials

1. Open Purview Studio, navigate to **Sources**, and within the Azure SQL Database source tile, click the **New Scan** button.

    ![](../images/module02/02.64-sources-scansql.png)

2. Select the **Database** and **Credential** from the drop-down menus. Click **Test connection**. Click **Continue**.

    ![](../images/module02/02.65-sqlscan-credentials.png)

3. Click **Continue**.

    ![](../images/module02/02.66-sqlscan-scope.png)

4. Click **Continue**.

    ![](../images/module02/02.67-sqlscan-scanruleset.png)

5. Set the trigger to **Once**, click **Continue**.

    ![](../images/module02/02.68-sqlscan-schedule.png)

6. Click **Save and Run**.

    ![](../images/module02/02.69-sqlscan-run.png)

7. To monitor the progress of the scan, click **View Details**.

    ![](../images/module02/02.70-sqlscan-details.png)

8. Click **Refresh** to periodically update the status of the scan. Note: It will take approximately 5 minutes to complete.

    ![](../images/module02/02.71-sqlscan-refresh.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## 8. View Assets

1. To view the assets that have materialised as an outcome of running the scans, perform a wildcard search by typing the asterisk character (`*`) into the search bar and hitting the Enter key to submit the query and return the search results.

    ![](../images/module02/02.72-search-wildcard.png)

<div align="right"><a href="#module-02b---register--scan-azure-sql-db">↥ back to top</a></div>

## :mortar_board: Knowledge Check

[http://aka.ms/purviewlab/q02](http://aka.ms/purviewlab/q02)

1. What type of object can help organize data sources into logical groups?

    A ) Buckets    
    B ) Collections  
    C ) Groups  

2. At which point does Azure Purview begin to populate the data map with assets?

    A ) After an Azure Purview account is created  
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
