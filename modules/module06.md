# Module 06 - Lineage

[< Previous Module](../modules/module05.md) - **[Home](../README.md)** - [Next Module>](../modules/module07.md)

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).
* An Azure Data Lake Storage Gen2 Account (see [module 02](../modules/module02.md)).

## :loudspeaker: Introduction

One of the platform features of Azure Purview is the ability to show the lineage between datasets created by data processes. Systems like Data Factory, Data Share, and Power BI capture the lineage of data as it moves. Custom lineage reporting is also supported via Atlas hooks and REST API.

Lineage in Purview includes datasets and processes.

* **Dataset**: A dataset (structured or unstructured) provided as an input to a process. For example, a SQL Table, Azure blob, and files (such as .csv and .xml), are all considered datasets. In the lineage section of Purview, datasets are represented by rectangular boxes.

* **Process**: An activity or transformation performed on a dataset is called a process. For example, ADF Copy activity, Data Share snapshot and so on. In the lineage section of Purview, processes are represented by round-edged boxes.

This module steps through what is required for connecting an Azure Data Factory account with an Azure Purview account to track data lineage.

## :dart: Objectives

* Connect an Azure Data Factory account with an Azure Purview account.
* Trigger a Data Factory pipeline to run so that the lineage metadata can be pushed into Purview.

## Table of Contents

1. [Create an Azure Data Factory Account](#1-create-an-azure-data-factory-account)
2. [Create an Azure Data Factory Connection in Azure Purview](#2-create-an-azure-data-factory-connection-in-azure-purview)
3. [Copy Data using Azure Data Factory](#3-copy-data-using-azure-data-factory)
4. [View Lineage in Azure Purview](#4-view-lineage-in-azure-purview)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 1. Create an Azure Data Factory Account

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account and from the **Home** screen, click **Create a resource**.

    ![Create a Resource](../images/module01/01.01-create-resource.png)  

2. Search the Marketplace for "Data Factory" and click **Create**.
    
    ![Azure Marketplace](../images/module06/06.01-marketplace-create.png)

3. Provide the necessary inputs on the **Basics** tab and then navigate to **Git configuration**.  

    > Note: The table below provides example values for illustrative purposes only, ensure to specify values that make sense for your deployment.

    | Parameter  | Example Value |
    | --- | --- |
    | Subscription | `BuildEnv` |
    | Resource group | `resourcegroup-1` |
    | Region | `East US 2` |
    | Name | `adf-team01` |

    ![Azure Data Factory Basics](../images/module06/06.02-create-basics.png)

4. Select **Configure Git later** and click **Review + create**.

    ![Azure Data Factory Basics](../images/module06/06.03-create-git.png)

5. Once validation has passed, click **Create**.

    ![](../images/module06/06.04-create-adf.png)

6. Wait until the deployment is complete, then return to Purview Studio.

    ![Deployment Complete](../images/module06/06.05-adf-deployment.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 2. Create an Azure Data Factory Connection in Azure Purview

1. Open Purview Studio, navigate to **Management Center** > **Data Factory** and click **New**.

    > :warning: If you are unable to view/add Data Factory connections, you may need to assign one of the following roles: 
    > * Contributor
    > * Owner
    > * Reader
    > * User Access Administrator

    ![](../images/module06/06.06-purview-management.png)

2. Select your Azure Data Factory from the drop-down menu and click **OK**.

    ![](../images/module06/06.07-purview-adf.png)

3. Once finished, you should see the Data Factory in a **connected** state.

    ![](../images/module06/06.08-adf-connected.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 3. Copy Data using Azure Data Factory

1. Within the Azure Portal, navigate to your Azure Data Factory resource and click **Author & Monitor**.

    ![](../images/module06/06.09-adf-author.png)

2. Click **Copy data**.
    ![](../images/module06/06.10-adf-copywizard.png)

3. Rename the task the **copyPipeline** and click **Next**.

    ![](../images/module06/06.11-adf-pipelinename.png)

4. Click **Create new connection**.
    
    ![](../images/module06/06.12-adf-sourceconn.png)

5. Filter the list of sources by clicking **Azure**, select **Azure Data Lake Storage Gen2** and click **Continue**.
    
    ![](../images/module06/06.13-adf-adlsgen2.png)

6. Select your **Azure subscription** and **Storage account**, click **Test connection** and then click **Create**.

    ![](../images/module06/06.14-adf-linkedservice.png)

7. Click **Next**.

    ![](../images/module06/06.15-adf-sourceselect.png)

8. Click **Browse**.

    ![](../images/module06/06.16-adf-browse.png)

9. Navigate to `raw/BingCoronavirusQuerySet/2020/` and click **Choose**.
    
    ![](../images/module06/06.17-adf-choose.png)

10. Confirm your folder path selection and click **Next**.

    ![](../images/module06/06.18-adf-input.png)

11. Preview the sample data and click **Next**.
    
    ![](../images/module06/06.19-adf-preview.png)

12. Select the same **AzureDataLakeStorage1** connection for the destination and click **Next**.

    ![](../images/module06/06.20-adf-destination.png)

13. Click **Browse**.

    ![](../images/module06/06.21-adf-browseoutput.png)

14. Navigate to `raw/` and click **Choose**.

    ![](../images/module06/06.22-adf-chooseoutput.png)

15. Confirm your folder path selection, set the **file name** to `2020_merged.parquet`, set the **copy behavior** to **Merge files**, and click **Next**.

    ![](../images/module06/06.23-adf-merge.png)

16. Set the **file format** to **Parquet format** and click **Next**.

    ![](../images/module06/06.24-adf-format.png)

17. Leave the default settings and click **Next**.

    ![](../images/module06/06.25-adf-settings.png)

18. Review the summary and proceed by clicking **Next**.

    ![](../images/module06/06.26-adf-summary.png)

19. Once the deployment is complete, click **Finish**.

    ![](../images/module06/06.27-adf-finish.png)

20. Navigate to the **Monitoring** screen to confirm the pipeline has run **successfully**.

    ![](../images/module06/06.28-adf-monitor.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 4. View Lineage in Azure Purview

1. Open Purview Studio, from the Home screen click **Browse**.

    ![](../images/module06/06.29-purview-browse.png)

2. Select **Azure Data Factory**.

    ![](../images/module06/06.30-browse-adf.png)

3. Select the **Azure Data Factory account instance**.

    ![](../images/module06/06.31-browse-instance.png)

4. Select the **copyPipeline** and click to open the **Copy Activity**.
    
    ![](../images/module06/06.32-browse-pipeline.png)

5. Navigate to the **Lineage** tab.

    ![](../images/module06/06.33-browse-asset.png)

6. You can see the lineage information has been automatically pushed from Azure Data Factory to Purview. On the left are the two sets of files with common schema that are in the source folder. The copy activity sits in the center, and the ouput file sits on the right.

    ![](../images/module06/06.34-browse-lineage.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to integrate Azure Purview with Azure Data Factory and how relationships between assets and ETL activities can be automatically created at run time, allowing us to visually represent data lineage and trace upstream and downstream dependencies.
