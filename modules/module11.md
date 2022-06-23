# Module 11 - Securely scan sources using Self-Hosted Integration Runtimes

[< Previous Module](../modules/module10.md) - **[Home](../README.md)** - [Next Module >](../modules/module12.md)

## :loudspeaker: Introduction

Microsoft Purview comes with a managed infrastructure component called AutoResolveIntegrationRuntime. This component is required when scanning sources and most useful when connecting to data stores and computes services with public accessible endpoints. However some of your sources might be VM-based or can be applications that either sit in a private network (VNET) or other networks, such as on-premises. For these kind of scenarios a Self-Hosted Integration Runtime (SHIR) is recommended.

In this lab you learn how to setup a more complex scenario of using a SHIR and private virtual network. First, you'll deploy a virtual network and storage account, then you will deploy and use private endpoints to route all traffic securely, without using any public accessible endpoints. Lastly, you configure the SHIR, Azure Key Vault and configure everything in Microsoft Purview.

## :thinking: Prerequisites

- An [Azure account](https://azure.microsoft.com/free/) with an active subscription.
- A Microsoft Purview account (see [module 01](../modules/module01.md)).

## :dart: Objectives

- Connect to on premise data source using a self-hosted integration runtime.

## Table of Contents

1. [Virtual network creation](#1-virtual-network-creation)
2. [Storage account creation](#2-storage-account-creation)
3. [Private endpoint creation](#3-private-endpoint-creation)
4. [Self-hosted integration runtime installation](#4-self-hosted-integration-runtime-installation)
5. [Key vault creation](#5-key-vault-creation)
6. [Key Vault configuration within Microsoft Purview](#6-key-vault-configuration-within-purview)
7. [Summary](#7-summary)

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 1. Virtual network creation

1. For deploying your Self-Hosted Integration Runtime you first need to create a new virtual network. This is needed for the virtual machine and private endpoint to be created. Open the Azure Portal, search for Virtual Network and click Create. First you need to give your new network a name. I’m using the same resource group that is used for Microsoft Purview.

   ![ALT](../images/module11/pic01.png)

2. Next you need to define your address spaces. If the proposed 10.0.0.0 is what you like, you can continue and hit next.

   ![ALT](../images/module11/pic02.png)

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 2. Storage account creation

1. Next we will setup a storage account for demonstration. This is the resource that will be scanned during this demo. Select create new resource, choose Storage Account, select the resource group you just created, provide a unique name, and hit next.

   ![ALT](../images/module11/pic03.png)

2. For the Storage Account we will ensure that hierarchical namespaces are selected. Click next to jump over to the Networking tab.

   ![ALT](../images/module11/pic04.png)

3. For networking, select Private endpoint as the connectivity method. Don’t create any private endpoints at this stage. This comes later.

   ![ALT](../images/module11/pic05.png)

4. After this step you can hit review + create, finalize and wait for the storage account to be created.

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 3. Private endpoint creation

Your next step is creating a private endpoint: a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to your storage account. It also means all network traffic is routed internally, which is useful to mitigate network exfiltration risks.

1. For creating a new private endpoint, go to your storage account. Click on networking on the left side. Go to private endpoints and click on the + icon.

   ![ALT](../images/module11/pic06.png)

2. Start with the basics by providing a name. This will be name of your network interface created in the virtual network.

   ![ALT](../images/module11/pic07.png)

3. Next, you need to select which resource type you want to expose. For this demo we will use blob.

   ![ALT](../images/module11/pic08.png)

4. The last configuration is selecting which virtual network the private endpoint must be deployed within. You should use the virtual network which you created in the previous steps. For the Private IP configuration you can select to dynamically allocate IP addresses.

   ![ALT](../images/module11/pic09.png)

5. When returning to the network overview settings, there is one additional step: allowing network traffic from your subnet. Go back to the firewall and virtual networks settings within your Storage Account. Add an existing virtual network, select your subnet from the list, and click Add.

   ![ALT](../images/module11/pic27-networkadd.png)

6. The virtual network should be added to the list. Don’t forget to hit the ‘save’ button!

   ![ALT](../images/module11/pic28-networkadd.png)

7. After this configuration you’re set. Let’s continue and setup your virtual machine.

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 4. Self-hosted integration runtime installation

A self-hosted integration runtime is a software component that scans for metadata. You can install on many different types of (virtual) machines. You can download it from the following location: [https://www.microsoft.com/download/details.aspx?id=39717](https://www.microsoft.com/download/details.aspx?id=39717)

For this demo you will be using Windows 10. Open the Azure Portal again to search for virtual machines.

1. Create new and select Windows 10 Pro as the image version. Remember to enter a username and password. Click next to examine the network settings. The newly created virtual network using the 10.0.0.0 space should be selected here.

   ![ALT](../images/module11/pic10.png)

2. After the virtual machine has been created, download the RDP file for easily taking over remote control.

   ![ALT](../images/module11/pic11.png)

3. After downloading your RDP file, open it and enter your username and password from the previous section. If everything goes well, you should be connected and see the virtual machine’s desktop. To validate that your private endpoint works correctly, open CMD and type:

   ```text
   nslookup storageaccountname.blob.core.windows.net
   ```

4. If everything works correctly, the privatelink.blob.core.windows.net should show up in the list. This means is that your default access location has become an alias for an internal address. Although you use a public name, network is routed internally via the virtual network.

   ![ALT](../images/module11/pic12.png)

5. When everything is working, you must download the self-hosted integration runtime package. The installation is straight forward. Just hit next and wait for the service to show up. While waiting, you should open Microsoft Purview. Open the data map and go to integration runtimes. Hit + new and select the self-hosted from the panel and continue.

   ![ALT](../images/module11/pic13.png)

6. After completing the wizard, you see a link where you can download the latest version of the runtime. You also find two keys. Copy the first one to your clipboard.

   ![ALT](../images/module11/pic14.png)

7. Next, go back to your virtual machine. Copy paste the link into the manager and hit ‘register’. Wait a minute or so, the integration runtime should show up in the list very soon!

   ![ALT](../images/module11/pic15.png)

8. If everything works well your self-hosted integration runtime should be running within Purview. Congrats that you made it this far!

   ![ALT](../images/module11/pic16.png)

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 5. Key vault creation

For securely accessing your storage account you will store your storage account key in a Key Vault. A key vault is a central place for managing your keys, secrets, credentials and certifications. This avoids keys get lost or changing these is a cumbersome task.

1. For creating a Key Vault go back to your Azure Portal. Search for Key Vault, hit create, provide a name and hit create.

   ![ALT](../images/module11/pic17.png)

2. After deployment you need to ensure that Microsoft Purview has read access to the Key Vault. Open Key Vault, go to Access configuration, and hit Go to access policies.

   ![ALT](../images/module11/pic19.png)

3. Because the Account Key is just a secret we will only provide access for Get and List, see below. Click next when ready.

   ![ALT](../images/module11/pic20.png)

4. For providing access you need to use the system-managed identity of Microsoft Purview. This identity has the same name as your Purview instance name. Find it, select it and hit Next.

   ![ALT](../images/module11/pic21.png)

5. Next you need to ensure two things: 1) purview’s managed identity has access to read from the storage account 2) the storage account key has been stored in the Key Vault. Go back to your storage account. Navigate to IAM and give your Purview Managed Identity the role: Storage Blob Data Reader. Detailed instructions can be found [here](https://docs.microsoft.com/azure/purview/register-scan-adls-gen2).

   ![ALT](../images/module11/pic22.png)

6. Next, go to Access keys within the storage account section. Show the keys using the button at the top. Select Key1 and copy the secret to your clipboard. Head back to your Key Vault.

   ![ALT](../images/module11/pic18.png)

7. Within your Key Vault, select Secrets and choose Generate/Import. The dialog below should pop up. Enter a name for your secret and copy/paste the Storage Account Key value from your clipboard. Hit Create to store your newly created secret.

   ![ALT](../images/module11/pic23.png)

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 6. Key Vault configuration within Microsoft Purview

Now the Storage Account Key has been stored in the Key Vault it is time to move back to Microsoft Purview for your final configuration. Go to your settings panel on the right and select Credentials.

1. Click on Manage Key Vault connections, provide a new name and select your newly created key vault from the list. Hit create for saving.

   ![ALT](../images/module11/pic24.png)

2. Next, you need to store a new credential. Click on + New, enter a new name, select Account Key from the list of authentication options. Finally, you need to enter a secret name. It is important that this name exactly matches the name of your secret in the Key Vault! Hit create to finalize.

   ![ALT](../images/module11/pic25.png)

3. Now you can move to Sources. Register a new source, select Azure Data Lake Storage Gen2 and select your storage account from the list.

   ![ALT](../images/module11/pic26.png)

4. Next you need to start scanning your source. Click new scan and select your Self-Hosted Integration Runtime from the list. Before you continue ensure everything works by testing your connection.

   ![ALT](../images/module11/pic29.png)

5. If everything works you should be able to select your folders and start scanning!

   ![ALT](../images/module11/pic30.png)

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## 7. Summary

This has been a long read, but also demonstrates how you can use your own integration runtime to securely scan sources. With some additional overhead all data and metadata traffic remains secure within your own virtual network. There’s no risk for any data exfiltration!

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

> :bulb: **Did you know?**
>
> The Purview Integration Runtime can also be used to scan and ingest metadata assets from Azure cloud services that are hidden behind private endpoints, such as Azure Data Lake, Azure SQL Database, Azure Cosmos DB [and more](https://docs.microsoft.com/azure/purview/catalog-private-link#support-matrix-for-scanning-data-sources-through-ingestion-private-endpoint).

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## :mortar_board: Knowledge Check

[https://aka.ms/purviewlab/q11](https://aka.ms/purviewlab/q11)

1. What is an Self-Hosted Integration Runtime used for?

   A) It's used for copying data from or to an on-premises data store or networks with access control  
   B) It's used for copying data between cloud based data stores or networks with public endpoints  
   C) It's used for copying data between managed environments

2. Self-Hosted Integration Runtime can be shared across multiple services when installed on one machine/VM.

   A) True  
   B) False

3. Which Azure services can be scanned and have metadata assets ingested from using the self-hosted integration runtime?

   A) Azure Blob Storage  
   B) Azure SQL Database  
   C) Azure Synapse Analytics  
   D) All of these  
   E) None of these

<div align="right"><a href="#module-11---securely-scan-sources-using-self-hosted-integration-runtimes">↥ back to top</a></div>

## :tada: Summary

In this module, you learned how to install the self-hosted integration runtime to your virtual machine network and get it connected up to Microsoft Purview. If you'd like continue with this module to complete further tasks, please feel free to complete the tutorial links below:

- [Setting up authentication for a scan](https://docs.microsoft.com/azure/purview/register-scan-on-premises-sql-server#setting-up-authentication-for-a-scan)
- [Register SQL Server on VM as a data source in Purview](https://docs.microsoft.com/azure/purview/register-scan-on-premises-sql-server#register-a-sql-server-data-source)
- Upload same data to the SQL Server on the VM
  - [World Wide Importers dataset](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers)
  - [Contoso BI dataset](https://www.microsoft.com/download/details.aspx?id=18279)
- [Trigger a scan of the on-premise data source](https://docs.microsoft.com/azure/purview/register-scan-on-premises-sql-server#creating-and-running-a-scan)

[Continue >](../modules/module12.md)
