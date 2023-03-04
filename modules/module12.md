# Module 12 - Managed private endpoints

[< Previous Module](../modules/module11.md) - **[Home](../README.md)** - [Next Module >](../modules/module13.md)

## :loudspeaker: Introduction

An integration runtime (IR) is compute infrastructure that Microsoft Purview uses to power data scan across different network environments. These integration runtimes come in different flavors. One of them is using managed private endpoints, which Microsoft recently added. With this new set of features you can better manage and secure your data scanning within Purview. As a result your metadata traffic is distributed via Azure Private Link, which eliminated any exposure to the internet. This protects you from any data exfiltration risks.

In this lab you'll learn how to make use a managed private endpoints. You'll learn how to configure them.

## :thinking: Prerequisites

- An [Azure account](https://azure.microsoft.com/free/) with an active subscription.
- A SQL Virtual Machine (see [module 00](../modules/module00.md)).
- A Microsoft Purview account (see [module 01](../modules/module01.md)).

## :dart: Objectives

- Scan a storage account via a private endpoint using an Azure Managed Integration Runtime (IR) within a Microsoft Purview Managed Virtual Network.

## Table of Contents

1. [Resource group creation](#1-resource-group-creation)
2. [Storage account creation](#2-storage-account-creation)
3. [Microsoft Purview creation](#3-microsoft-purview-creation)
4. [Authentication for a scan](#4-authenticate-for-a-scan)
5. [Managed Virtual Network Integration Runtime](#5-managed-virtual-network-integration-runtime)
6. [Private endpoint for Azure Blob Storage](#6-private-endpoint-for-azure-blob-storage)
7. [Configure source and scanning](#7-configure-source-and-scanning)

<div align="right"><a href="#module-12---managed-private-endpoints">↥ back to top</a></div>

## 1. Resource group creation

1. In this lab you will start from scratch by first creating a new resource group. In this tutorial you use Canada Central as the region location because these new features aren’t available on all regions yet. Please consult [this link](https://docs.microsoft.com/azure/purview/catalog-managed-vnet) for more information.

   ![](../images/module12/Step01.png)

## 2. Storage account creation

1. Next you will setup a storage account for demonstration. This is the resource that will be scanned during our demo. Select create new resource, choose Storage Account, select the resource group you just created, provide a unique name, and hit next.

   ![](../images/module12/Step02.png)

2. For the Storage Account we will ensure that hierarchical namespaces are selected. Click next to jump over to the Networking tab.

   ![](../images/module12/Step03.png)

3. For the networking we select Private endpoint as the connectivity method. Don’t create any private endpoints at this stage. This comes later.

   ![](../images/module12/Step04.png)

4. After this step you can hit review + create, finalize and wait for the storage account to be created. You can validate the security by creating and opening a container within the storage account. When the account is configured correctly, you should see that access is not permitted in the screen below.

   ![](../images/module12/Step07.png)

## 3. Microsoft Purview creation

1. After you created your storage account we can move to creating a Microsoft Purview account. Select create new resource, select Purview, and provide your account details. Remember to use the same region as for the resource group and storage account. You can press review + create.

   ![](../images/module12/Step05.png)

**Note;** we don’t deploy purview here using a private endpoint. You can consider this when you entirely want to lock-down any access to Microsoft Purview. For example when you allow only client to call to Microsoft Purview that originate from within the private network. In this demo I don’t want to overcomplicate things.

2. After the resources have been deployed successfully your resource group should look like this:

   ![](../images/module12/Step06.png)

## 4. Authentication for a scan

1. Next we need to give permissions to the storage account so Microsoft Purview is able to scan. Open the storage account, click on IAM, assign a new role. Set the role to Storage Blob Data Reader and select the managed identity from the newly created Purview account.

   ![](../images/module12/Step08.png)

At this stage we’re all set and can continue by opening Microsoft Purview.

## 5. Managed Virtual Network Integration Runtime

With the newly released features Microsoft Purview now provides three options for scanning sources:

- **Microsoft Purview default’s integration runtime**: this option is useful when connecting to data stores and computes services with public accessible endpoints.
- **Self-hosted integration runtimes (SHIR)**: this option particularly useful for VM-based data sources or applications that either sit in a private network (VNET) or other networks, such as on-premises.
- **Managed Virtual Network Integration Runtime**: this new option supports connecting to data stores using private link service in private network environment. This ensures that data scanning process is completely isolated and secure, while also being fully managed.

1. For this demonstration we will use the Managed Virtual Network Integration Runtime. Use your Microsoft the Microsoft Purview Governance Portal Portal and navigate to your data map on the left. Select integration runtime and choose Azure.

   ![](../images/module12/Step09.png)

2. Give your new integration runtime a new, description and ensure that interactive authoring is enabled.

   ![](../images/module12/Step10.png)

3. After deployment you must wait for the approval notifications. When ready, click on the blue links and navigate to the newly created resources.

   ![](../images/module12/Step11.png)

4. For the newly created resources you must approve the Private Endpoint connections. Click on each of them and change the status to Approve.

   ![](../images/module12/Step13.png)

5. Next, hover back to Microsoft Purview and look up your newly created private endpoints. You can find this option on the left (settings).

   ![](../images/module12/Step14.png)

## 6. Private endpoint for Azure Blob Storage

1. The next step is creating a private endpoint for the newly created storage account. When you are still in the managed private endpoints section, click on new. Select Azure Data Lake Storage Gen2 and continue.

   ![](../images/module12/Step15.png)

2. Lookup the storage account name under your subscription and click Create.

   ![](../images/module12/Step16.png)

3. The same approval process kicks in. Navigate to your storage account, go to networking, private endpoint connections, and you will see a newly requested item is created. Repeat the same steps by approving the endpoint.

   ![](../images/module12/Step17.png)

4. Go back to Microsoft Purview and wait for all managed private endpoints to be approved.

   ![](../images/module12/Step18.png)

## 7. Configure source and scanning

1. Next you need to add your newly created source and setup the scanning. Go to the data map and collection overview. Add a new source and click on Azure Data Lake Storage Gen2.

   ![](../images/module12/Step19.png)

2. Next, register your source. You will see the public endpoint listed here, but this configuration will be overwritten once we start scanning. Hit register and finish.

   ![](../images/module12/Step20.png)

3. Next you configure scanning for your newly created source. It’s important to select the IntegrationRuntime (Managed Virtual Network) from the list. Add your source to a collection, and hit continue.

   ![](../images/module12/Step21.png)

4. Finally, you must test your connection and hit continue. Complete the scanning by selecting a schedule.

   ![](../images/module12/Step22.png)

If everything goes well you’ll notice new metadata will be added to Purview. This all will be very secure, because all metadata is transferred using private endpoints.

> :bulb: **Did you know?**
>
> By using managed private endpoints, you do not have to manage your own VNETs. Microsoft takes care of managing this. [More information](https://docs.microsoft.com/azure/purview/catalog-managed-vnet).

<div align="right"><a href="#module-12---managed-private-endpoints">↥ back to top</a></div>

## :mortar_board: Knowledge Check

1. By using managed private endpoints you're protected from any data exfiltration risks.

   A) True  
   B) False

<div align="right"><a href="#module-12---managed-private-endpoints">↥ back to top</a></div>

## :tada: Summary

In this module, you learned how to install managed private endpoints. If you'd like continue with this module to complete further tasks, please feel free to complete the tutorial links below:

- [Use a Managed VNet with your Microsoft Purview account](https://learn.microsoft.com/en-us/azure/purview/catalog-managed-vnet)

[Continue >](../modules/module13.md)
