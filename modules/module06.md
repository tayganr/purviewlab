# Module 06 - Lineage

[< Previous Module](../modules/module05.md) - **[Home](../README.md)** - [Next Module>](../modules/module07.md)

## :thinking: Prerequisites

* An Azure account with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).
* An Azure Data Lake Storage Gen2 Account (see [module 02](../modules/module02.md)).

## :loudspeaker: Introduction

One of the platform features of Azure Purview is the ability to show the lineage between datasets created by data processes. Systems like Data Factory, Data Share, and Power BI capture the lineage of data as it moves. Custom lineage reporting is also supported via Atlas hooks and REST API.

Lineage in Purview includes datasets and processes. Datasets are also referred to as nodes while processes can be also called edges:

* Dataset (Node): A dataset (structured or unstructured) provided as an input to a process. For example, a SQL Table, Azure blob, and files (such as .csv and .xml), are all considered datasets. In the lineage section of Purview, datasets are represented by rectangular boxes.

* Process (Edge): An activity or transformation performed on a dataset is called a process. For example, ADF Copy activity, Data Share snapshot and so on. In the lineage section of Purview, processes are represented by round-edged boxes.

This document explains the steps required for connecting an Azure Data Factory account with an Azure Purview account to track data lineage.

## Table of Contents

1. [Azure Purview Access Control (Purview Data Source Administrator)](#1-azure-purview-access-control-purview-data-source-administrator)
2. [Create an Azure Data Factory Account](#2-create-an-azure-data-factory-account)
3. [Create an Azure Data Factory Connection in Azure Purview](#3-create-an-azure-data-factory-connection-in-azure-purview)
4. [Copy Data using Azure Data Factory](#4-copy-data-using-azure-data-factory)
5. [View Lineage in Azure Purview](#5-view-lineage-in-azure-purview)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 1. Azure Purview Access Control (Purview Data Source Administrator)

Multiple Azure Data Factories can connect to a single Azure Purview Data Catalog to push lineage information. The current limit allows you to connect up ten Data Factory accounts at a time from the Purview management center. 

>:warning: In order to view External connections, you need to be assigned any one of the following Azure Purview roles: 
>* Contributor
>* Owner
>* Reader
>* User Access Administrator


To view existing Data Factory accounts connected to your Purview Data Catalog, do the following:

1. Select Management Center on the left navigation pane.
2. Under External connections, select Data Factory connection.
3. The Data Factory connection list appears.

![image](https://user-images.githubusercontent.com/27697035/112839336-fc28ef00-9095-11eb-8d49-d0bc63270f03.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 2. Create an Azure Data Factory Account

1. From the Azure Portal, click **Create a Resource**
2. Click on the Analytics Category or search for Data Factory
3. Choose **Create** from the Marketplace tile.

![image](https://user-images.githubusercontent.com/27697035/112855239-89743f80-90a6-11eb-8049-b349837d4b30.png)

4. In the Create Data Factory Dialog, assign the appropriate subscription and resource group.
5. The region will default to the same as the selected Resource Group.
6. Give the Data Factory a unique name.

![image](https://user-images.githubusercontent.com/27697035/112855517-c809fa00-90a6-11eb-818c-ed10f14062a0.png)

7. Under the Git Configuration tab, select **Configure Git Later**.

![image](https://user-images.githubusercontent.com/27697035/112856137-639b6a80-90a7-11eb-9317-43de2dfd5b19.png)

8. Click **Review + Create**
9. When the validation is passed, click **Create** to deploy the new Data Factory.


<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 3. Create an Azure Data Factory Connection in Azure Purview

>:warning: In order to add new External connections, you need to be assigned any one of the following Azure Purview roles: 
>* Owner
>* User Access Administrator
>
>You must also have *Owner* or *Contributor* rights to the Data Factory instance you wish to add.

Follow the steps to add the newly created Data Factory account to your Puview Data Catlog.
1. Select Management Center on the left navigation pane.
2. Under External connections, select Data Factory connection.
3. On the Data Factory connection page, select **New**.
4. From the New Data Factory Connections dialog, choose the appropriate Azure Subscription and Data Factory.

![image](https://user-images.githubusercontent.com/27697035/112858305-a3635180-90a9-11eb-8310-5dc7e2b24aa5.png)

5. Click **OK**

![image](https://user-images.githubusercontent.com/27697035/112858423-c1c94d00-90a9-11eb-8302-eca921c36825.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 4. Copy Data using Azure Data Factory

1. From the Azure Portal, navigate to your Azure Data Factory Instance.
2. In the Overview panel, click **Author & Monitor**

![image](https://user-images.githubusercontent.com/27697035/112965566-487d3900-9141-11eb-9883-14e833f39e65.png)

3. In the Azure Data Factory Home panel, click **Copy Data**

![image](https://user-images.githubusercontent.com/27697035/112966013-b6c1fb80-9141-11eb-86a8-d81bd16add1e.png)

4. Give the new copy task a distinctive name or accept the default value.

![image](https://user-images.githubusercontent.com/27697035/112978003-ab290180-914e-11eb-9f54-fcd346c550e6.png)

5. Click **Next** at the bottom of the dialog, then click **Create New Connection** in The *Source Data Store* panel.

![image](https://user-images.githubusercontent.com/27697035/112978311-14a91000-914f-11eb-83b7-9713df457ebd.png)

6. Choose **Azure Data Lake Storage Gen2** from the the *New Linked Service* menu, then click **Continue** at the bottom of the screen.

![image](https://user-images.githubusercontent.com/27697035/112979770-efb59c80-9150-11eb-8045-5fc299408e71.png)

7. Enter a descriptive name for the linked service connection or use the default value.
8. Choose the appropriate Azure Subscription.
9. Choose the storage account you created in Module 2.
10. Click **Test Connection** and look for the *Connection Successful* tick box.
11. Click **Create**.

![image](https://user-images.githubusercontent.com/27697035/113295743-7c4a9100-92f0-11eb-8745-9ef698962f59.png)

12. Make sure the new linked service you've created is highlighted in blue. It should be the only one, unless you've created other linked services. Click **Next**.
13. From the Dataset panel, click the **Browse** button to the right of the File or Folder field and navigate to the 2020 subfolder in your data lake store.

![image](https://user-images.githubusercontent.com/27697035/113297402-781f7300-92f2-11eb-9b34-cc483fc87efb.png)

14. Click **Choose**, then **Next**.

![image](https://user-images.githubusercontent.com/27697035/113297634-c2085900-92f2-11eb-9b9e-efe92360a9ca.png)

15. In the Dataset panel, make sure the data preview looks sensible, then click **Next*.

![image](https://user-images.githubusercontent.com/27697035/113297955-2fb48500-92f3-11eb-991f-bfad2ee5b27d.png)

16. In the Destination panel, choose the same linked service you used for the Source definition and click **Next**.

![image](https://user-images.githubusercontent.com/27697035/113298228-81f5a600-92f3-11eb-9843-8dc9c07104cd.png)

17. Browse to the _raw_ folder level, then click **Choose**.

![image](https://user-images.githubusercontent.com/27697035/113308980-9db27980-92fe-11eb-8fc1-79cb52c4f776.png)

18. In the next screen, add File name, and choose _Merge files_ from the **Copy behaviour** drop-down menu. Finally, click **Next**.

![image](https://user-images.githubusercontent.com/27697035/113309622-3cd77100-92ff-11eb-8b6b-7f4fc8033da6.png)

19. In the File format settings panel, choose _Parquet format_ from the **File format** drop-down menu. Click **Next**.

![image](https://user-images.githubusercontent.com/27697035/113309949-98a1fa00-92ff-11eb-8126-f18debde7441.png)

20. Use all the default settings in the next screen and click **Next**.
21. Review the pipeline summary in the last screen and click **Next**.
22. The pipeline will begin to run. When you see the *Deployment complete* message, click **Finish**.

![image](https://user-images.githubusercontent.com/27697035/113310495-35649780-9300-11eb-8e42-a01ad4aae7e8.png)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 5. View Lineage in Azure Purview

1. Do A
2. Do B
3. Do C

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to intergrate Azure Purview with Azure Data Factory and how relationships between assets and ETL activities can be automatically created at run time, allowing us to visually represent data lineage and trace upstream and downstream dependencies.
