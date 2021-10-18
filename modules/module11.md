# Module 11 - Self-Hosted Integration Runtime

[< Previous Module](../modules/module10.md) - **[Home](../README.md)** - [Next Module >](../modules/module12.md)

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* A SQL Virtual Machine (see [module 00](../modules/module00.md)).
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).

## :loudspeaker: Introduction

To populate Azure Purview with assets from your on-premise data sources, we must make use a self-hosted integrastion runtime agent to create that gateway for data discovery and exploration. In this module, we will walk through how to install a self-hosted integration runtime, register the on-premise SQL server and scan the data source.

## :dart: Objectives

* Connect to on premise data source using a self-hosted integration runtime.

## Table of Contents

1. [Connect to SQL Virtual Machine](#1-connect-to-sql-virtual-machine)
2. [Install Self-Hosted Integration Runtime](#2-install-self-hosted-integration-runtime)
3. [Authenticate to Azure Purview](#3-authenticate-to-azure-purview)

<div align="right"><a href="#module-11---self-hosted-integration-runtime">↥ back to top</a></div>

## 1. Connect to SQL Virtual Machine

To invoke the install the self-hosted integration runtime, we must first log into our SQL virtual machine. For this example, we'll be using the RDP connection to complete this step. If you would like to use **Bastion** to connect, follow the [instructions here](https://docs.microsoft.com/en-gb/azure/bastion/quickstart-host-portal#createvmset) to get this set-up. 

> :book: **Note** once the environment set-up is complete, your VM should already be in 'running' state. If this is not the case, you will need to 'start' your VM. 

1. Navigate to your Virtual Machine resource in the [Azure portal](https://portal.azure.com/). In the **Overview** section (left blade), click on '**Connect**' and '**RDP**' from the drop-down menu.

    ![](../images/module11/shir-install-13.png)

2. In the next page, click '**Download RDP File**'. Once the file has downloaded, click '**Open**'.
    ![](../images/module11/shir-install-14.png)
    ![](../images/module11/shir-install-15.png)

3. You will need to access the SQL username and password generated when deploying the lab environment from [module 00](../modules/module00.md). To find these details, navigate to the resource group in the [Azure portal](https://portal.azure.com/). Under '**Settings > Deployments**', click on '**SQLVMDeployment**'.

    ![](../images/module11/shir-install-19b.png)
    ![](../images/module11/shir-install-19.png)

4. Navigate to the '**Outputs**' blade within the SQLVMDeployment area to find your SQL Admin username and password. 

    ![](../images/module11/shir-install-20.png)

5. In the Remote Desktop Connection pop-up window, click '**Connect**'.

    ![](../images/module11/shir-install-16.png)
    
6. Here you need to log into the virtual machine using the credentials supplied in the '**Outputs**' blade in the deployment area of the resource group you created in [module 00](../modules/module00.md). You'll need to select the '**More Choices**' option and/or '**Use a different account**' options in the log in window. 

    > :book: **Note** You'll need to log in using the format **username** = _vm name\sqladmin username_ and **password** = _sql password_

    ![](../images/module11/shir-install-17.png)
    ![](../images/module11/shir-install-18.png)

7. You'll see a warning message, click **Yes** to continue. 

    ![](../images/module11/shir-install-21.png)

<div align="right"><a href="#module-11---self-hosted-integration-runtime">↥ back to top</a></div>

## 2. Install Self-Hosted Integration Runtime

> :bulb: **Did you know?**
>
> The **integration runtime** (IR) is the compute infrastructure that Azure Services use to provide data-integration capabilities across different network environments. 

1. In the virtual machine, open the browser and navigate to the [integration runtime download page](https://www.microsoft.com/en-us/download/confirmation.aspx?id=39717). If the download doesn't start automatically, download the latest version of the integraion runtime from the list presented. Click '**Run**' when the download begins. 

    ![](../images/module11/shir-install-22.png)
    ![](../images/module11/shir-install-23.png)

2. Follow the instruction on screen to complete the installation process and click finish to proceed to the next step. 

    ![](../images/module11/shir-install-1.png)
    ![](../images/module11/shir-install-2.png)
    ![](../images/module11/shir-install-3.png)
    ![](../images/module11/shir-install-4.png)
    ![](../images/module11/shir-install-5.png)
    ![](../images/module11/shir-install-6.png)

3. If the integration runtime manager doesn't open automatically, navigate to the **Start Menu** and click '**Microsoft Integration Runtime**'. Once the IR Manager window opens, we can move on to the next step to [authenticate to Azure Purview](#3-authenticate-to-azure-purview).

    ![](../images/module11/shir-install-7.png)

<div align="right"><a href="#module-11---self-hosted-integration-runtime">↥ back to top</a></div>

## 3. Authenticate to Azure Purview

1. Within the Azure Purview Studio, navigate to the **Data Map** in the left blade, click **Integration Runtime** and click **+ New**.

    ![](../images/module11/shir-install-9.png)

2. Ensure the **Self-Hosted** option is selected, then click **Continue**.

    ![](../images/module11/shir-install-10.png)

3. Give your integration runtime a name _(mandatory)_ and a description _(optional)_, then click **Create**.

    ![](../images/module11/shir-install-11.png)

4. Copy one of the **keys** to your clipboard then open your virtual machine window and paste this key into the **integration runtime manager window**. Click **Register** when the button becomes active and then **Finish** in the next screen. 

    ![](../images/module11/shir-install-12.png)
    ![](../images/module11/shir-install-8.png)
    ![](../images/module11/shir-install-8b.png)

5. Once successfully registered, you should see a  green tick :heavy_check_mark: within the **integration runtime manager window** and the **Azure Purview Studio integration runtime manager area**.

    ![](../images/module11/shir-install-24.png)
    ![](../images/module11/shir-install-25.png)

<div align="right"><a href="#module-11---self-hosted-integration-runtime">↥ back to top</a></div>

## :mortar_board: Knowledge Check

[http://aka.ms/purviewlab/q10](http://aka.ms/purviewlab/q10)

1. The Azure Purview API is largely based on which open source project?

    A ) Apache Maven  
    B ) Apache Spark  
    C ) Apache Atlas

2. The Azure Purview API only works with Python.

    A ) True  
    B ) False  

3. The Azure Purview API can be used to create custom lineage between data processes and data assets.

    A ) True  
    B ) False  

<div align="right"><a href="#module-11---self-hosted-integration-runtime">↥ back to top</a></div>

## :tada: Summary

In this module, you learned how to install the self-hosted integration runtime to your virtual machine network and get it connected up to Azure Purview. If you'd like 
get started with the Azure Purview REST API. To learn more about the Azure Purview REST API, check out the [Swagger documentation](https://github.com/Azure/Purview-Samples/raw/master/rest-api/PurviewCatalogAPISwagger.zip).