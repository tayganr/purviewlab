# Module 02A - Register & Scan (ADLS Gen2)

[< Previous Module](../modules/module01.md) - **[Home](../README.md)** - [Next Module >](../modules/module02b.md)

## :loudspeaker: Introduction

To populate Microsoft Purview with assets for data discovery and understanding, you must register sources that exist across our data estate so that we can leverage the out of the box scanning capabilities. Scanning enables Microsoft Purview to extract technical metadata such as the fully qualified name, schema, data types, and apply classifications by parsing a sample of the underlying data.

In this module, you'll walk through how to register and scan data sources. You'll create a new collection for your first data source, upload data and configure scanning. By the end of this module you'll have technical metadata, such as schema information, stored in Purview. You can use this to start linking to business terms, allowing your team members to easier find data.

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/free/) with an active subscription.
* An Azure Data Lake Storage Gen2 account (see [module 00](../modules/module00.md)).
* A Microsoft Purview account (see [module 01](../modules/module01.md)).

## :hammer: Tools

* [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) (Download and Install)

## :dart: Objectives

* Create a collection.
* Register and scan an Azure Data Lake Storage Gen2 account using the Microsoft Purview managed identity.

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [Grant the Microsoft Purview Managed Identity Access](#1-grant-the-microsoft-purview-managed-identity-access) | Azure Administrator |
| 2 | [Upload Data to Azure Data Lake Storage Gen2 Account](#2-upload-data-to-azure-data-lake-storage-gen2-account) | Azure Administrator |
| 3 | [Create a Collection](#3-create-a-collection) | Collection Administrator |
| 4 | [Register a Source (ADLS Gen2)](#4-register-a-source-adls-gen2) | Data Source Administrator |
| 5 | [Scan a Source with the Microsoft Purview Managed Identity](#5-scan-a-source-with-the-microsoft-purview-managed-identity) | Data Source Administrator |
| 6 | [View Assets](#6-view-assets) | Data Reader |

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## 1. Grant the Microsoft Purview Managed Identity Access

> :bulb: **Did you know?**
>
> To scan a source, Microsoft Purview requires a set of **credentials**. For Azure Data Lake Storage Gen2, Microsoft Purview supports the following [authentication methods](https://docs.microsoft.com/azure/purview/register-scan-adls-gen2?tabs=MI#prerequisites-for-scan).
>
> * System-assigned Managed Identity (recommended)
> * User-assigned Managed Identity
> * Service Principal
> * Account Key
>
> In this module we will walk through how to grant the Microsoft Purview system-assigned managed identity the necessary access to successfully configure and run a scan.

1. Navigate to your Azure Data Lake Storage Gen2 account (e.g. `pvlab{randomId}adls`) and select **Access Control (IAM)** from the left navigation menu.

    ![Microsoft Purview](../images/module02/02.01-storage-access.png)

2. Click **Add role assignment**.

    ![Microsoft Purview](../images/module02/02.02-storage-addrole.png)

3. Filter the list of roles by searching for `Storage Blob Data Reader`, click the row to select the role, and then click **Next**.

    ![Access Control Role](../images/module02/02.03-access-role.png)

4. Under **Assign access to**, select **Managed identity**, click **+ Select members**, select **Microsoft Purview account** from the **Managed Identity** drop-down menu, select the managed identity for your Microsoft Purview account (e.g. `pvlab-{randomId}-pv`), click **Select**. Finally, click **Review + assign**.

    ![Access Control Members](../images/module02/02.05-access-members.png)

5. Click **Review + assign** once more to perform the role assignment.

    ![Access Control Assign](../images/module02/02.06-access-assign.png)

6. To confirm the role has been assigned, navigate to the **Role assignments** tab and filter the **Scope** to `This resource`. You should be able to see that the Microsoft Purview managed identity has been granted the **Storage Blob Data Reader** role.

    ![Role Assignment](../images/module02/02.11-role-assignment.png)

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## 2. Upload Data to Azure Data Lake Storage Gen2 Account

Before proceeding with the following steps, you will need to:

* Download and install [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/).
* Open Azure Storage Explorer.
* Sign in to Azure via **View > Account Management > Add an account...**.

1. Download a copy of the **[Bing Coronavirus Query Set](https://github.com/tayganr/purviewlab/raw/main/assets/BingCoronavirusQuerySet.zip)** to your local machine. Note: This data set was originally sourced from [Microsoft Research Open Data](https://msropendata.com/datasets/c5031874-835c-48ed-8b6d-31de2dad0654).

2. Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking the file and selecting **Extract All...**.

    ![Extract zip file](../images/module02/02.07-explorer-unzip.png)

3. Click **Extract**.

    ![Extract](../images/module02/02.08-explorer-extract.png)

4. Open Azure Storage Explorer, click on the Toggle Explorer icon, expand the Azure Subscription to find your Azure Storage Account. Right-click on Blob Containers and select **Create Blob Container**. Name the container `raw`.

    ![Create Blob Container](../images/module02/02.12-explorer-container.png)

5. With the container name selected, click on the **Upload** button and select **Upload Folder...**.

    ![Upload Folder](../images/module02/02.13-explorer-upload.png)

6. Click on the **ellipsis** to select a folder.

    ![Browse](../images/module02/02.14-explorer-browse.png)

7. Navigate to the extracted **BingCoronavirusQuerySet** folder (e.g. Downloads\BingCoronavirusQuerySet) and click **Select Folder**.

    ![Folder](../images/module02/02.15-explorer-folder.png)

8. Click **Upload**.

    ![Upload](../images/module02/02.16-explorer-data.png)

9. Monitor the **Activities** until the transfer is complete.

    ![Transfer Complete](../images/module02/02.17-explorer-transfer.png)

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## 3. Create a Collection

> :bulb: **Did you know?**
>
> [Collections](https://docs.microsoft.com/azure/purview/how-to-create-and-manage-collections) in Microsoft Purview can be used to organize data sources, scans, and assets in a hierarchical model based on how your organization plans to use Microsoft Purview. The collection hierarchy also forms the security boundary for your metadata to ensure users don't have access to data they don't need (e.g. sensitive metadata). 
>
> For more information, check out [Collection Architectures and Best Practices](https://docs.microsoft.com/azure/purview/concept-best-practices-collections).

1. Open the **Microsoft Purview Governance Portal**, navigate to **Data Map** > **Collections**, and click  **Add a collection**.

    ![New Collection](../images/module02/02.18-sources-collection.png)

2. Provide the collection a **Name** (e.g. `Contoso`) and click **Create**.

    ![New Collection](../images/module02/02.76-collection-create.png)

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## 4. Register a Source (ADLS Gen2)

1. Open the Microsoft Purview Governance Portal, navigate to **Data Map** > **Sources**, and click on **Register**.

    ![Register](../images/module02/02.20-sources-register.png)

2. Search for `Data Lake`, select **Azure Data Lake Storage Gen2**, and click **Continue**.

    ![Sources](../images/module02/02.21-sources-adls.png)

3. Select the **Azure subscription**, **Storage account name**, **Collection**, and click **Register**.

    > :bulb: **Did you know?**
    >
    > At this point, we have simply registered a data source. Assets are not written to the catalog until after a scan has finished running.

    ![Source Properties](../images/module02/02.22-sources-properties.png)

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## 5. Scan a Source with the Microsoft Purview Managed Identity

1. Open the Microsoft Purview Governance Portal, navigate to **Data Map** > **Sources**, and within the Azure Data Lake Storage Gen2 tile, click the **New Scan** button.

    ![New Scan](../images/module02/02.23-scan-new.png)

2. Click **Test connection** to ensure the Microsoft Purview managed identity has the appropriate level of access to read the Azure Data Lake Storage Gen2 account. If successful, click **Continue**.

    ![Test Connection](../images/module02/02.24-scan-test.png)

3. Expand the hierarchy to see which assets will be within the scans scope, and click **Continue**.

    ![Scan Scope](../images/module02/02.25-scan-scope.png)

4. Select the system default scan rule set and click **Continue**.

    > :bulb: **Did you know?**
    >
    > [Scan Rule Sets](https://docs.microsoft.com/azure/purview/create-a-scan-rule-set) determine which **File Types** and **Classification Rules** are in scope. If you want to include a custom file type or custom classification rule as part of a scan, a custom scan rule set will need to be created.

    ![Scan rule set](../images/module02/02.26-scan-ruleset.png)

5. Select **Once** and click **Continue**.

    ![Scan Trigger](../images/module02/02.27-scan-trigger.png)

6. Click **Save and Run**.

    ![Run Scan](../images/module02/02.28-scan-run.png)

7. To monitor the progress of the scan run, click **View Details**.

    ![View Details](../images/module02/02.29-sources-details.png)

8. Click **Refresh** to periodically update the status of the scan. Note: It will take approximately 5 to 10 minutes to complete.

    ![Monitor Scan](../images/module02/02.30-sources-refresh.png)

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## 6. View Assets

1. Navigate to the **Microsoft Purview Governance Portal** > **Data catalog**, and perform a wildcard search by typing the asterisk character (`*`) into the search box and hitting the Enter key to submit the query.

    ![ALT](../images/module02/02.80-wildcard-search.png)

2. You should be able to see a list of assets within the search results, which is a result of the scan.

    ![ALT](../images/module02/02.72-search-wildcard.png)

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## :mortar_board: Knowledge Check

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

<div align="right"><a href="#module-02a---register--scan-adls-gen2">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to create a collection, register a source, and trigger a scan.

[Continue >](../modules/module02b.md)
