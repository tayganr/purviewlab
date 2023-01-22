# Module 16 - Data Sharing

[< Previous Module](../modules/module15.md) - **[Home](../README.md)** - [Next Module >](../modules/module17.md)

## :loudspeaker: Introduction

Organizations are increasingly looking for ways to enable seamless and secure data sharing. Whether that be to send and receive data to external organizations or for inter-departmental use cases. However, doing so in a way where organizations are able to maintain control and visibility can be a challenge. Even today, data continues to be shared using File Transfer Protocols (FTPs), Application Programming Interfaces (APIs), USB devices, and email attachments. These methods are traditionally not secure, challenging to govern, and generally inefficient.

With Microsoft Purview Data Sharing:

* Data providers can now share data in-place from Azure Data Lake Storage Gen2 and Azure Storage accounts, both within and across orgnaizations. Share data directly without data duplication and centrally manage your sharing activities from within Microsoft Purview.
* Data consumers can now have near real-time access to shared data. With storage data access and transactions charged to the data consumers based on what they use, at no additional cost to the data provider.

## :thinking: Prerequisites

* A Microsoft Purview account (see [module 01](../modules/module01.md)).

## :dart: Objectives

* Register a storage account to send and receive data.
* Share data with a recipient by creating a sent share.
* Accept and configure a received share to access shared data.

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [Enable the AllowDataSharing preview feature](#1-enable-the-allowdatasharing-preview-feature) | Azure Administrator |
| 2 | [Create a Storage Account](#2-create-a-storage-account) | Azure Administrator |
| 3 | [Populate the Storage Account](#3-populate-the-storage-account) | Data Producer |
| 4 | [Provide access to the Storage Account](#4-provide-access-to-the-storage-account) | Azure Administrator |
| 5 | [Register the Storage Account](#5-register-the-storage-account) | Data Source Administrator|
| 6 | [Create a Sent Share](#6-create-a-sent-share) | Data Share Contributor |
| 7 | [Accept a Received Share](#7-accept-a-received-share) | Data Share Contributor |
| 8 | [Access and Download Shared Data](#8-access-and-download-shared-data) | Data Share Contributor |

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 1. Enable the AllowDataSharing preview feature

Your Azure subscription **MUST** be registered for the Microsoft.Storage **AllowDataSharing** preview feature **BEFORE** you can create a storage account to share and receive data.

1. Open the Azure portal, type `Subscriptions` in the search bar and click **Subscriptions**.

    ![ALT](/images/module16/16.01.png)

2. Select your Azure subscription.

    ![ALT](/images/module16/16.02.png)

3. Scroll down on the left side menu and click **Preview features**, filter the results by searching for `AllowDataSharing`, select the **AllowDataSharing** feature and click **Register**. Periodically click **Refresh** to confirm that the feature is **Registered**. Note: This can take 15 minutes to 1 hour to complete.

    ![ALT](/images/module16/16.03.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 2. Create a Storage Account

Microsoft Purview Data Sharing supports sharing of files and folders in-place from Azure Data Lake Storage Gen2 and Blob Storage accounts.

> **Note**
>
> * Source and target storage accounts must be created **AFTER** the **AllowDataSharing** preview registration step is complete.
> * Both the source and target storage accounts **must be in the same Azure region** as each other.
> * The storage account needs to be **registered to a collection**.

1. From the Azure portal, open the portal menu and click **Create a resource**.

    ![ALT](/images/module16/16.04.png)

2. Select **Storage account**.

    ![ALT](/images/module16/16.05.png)

3. Populate the Basics screen and click **Review**.

    > **Note**
    >
    > Supported storage account configurations:
    > | Configuration | Support |
    > | --- | -- |
    > | Regions | Canada Central, Canada East, UK South, UK West, Australia East, Japan East, Korea South, and South Africa North |
    > | Performance | Standard |
    > | Standard | LRS, GRS, RA-GRS |

    ![ALT](/images/module16/16.06.png)

4. Click **Create**.

    ![ALT](/images/module16/16.07.png)

5. Once your deployment is complete, click **Go to resource**.

    ![ALT](/images/module16/16.08.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 3. Populate the Storage Account

Before we can create a share, we must populate our storage account with some data.

1. From the Azure portal, navigate to your resource group, and open your **storage account**.

    ![ALT](/images/module16/16.09.png)

2. On the side menu, click **Storage browser**.

    ![ALT](/images/module16/16.10.png)

3. Open **Blob containers**.

    ![ALT](/images/module16/16.11.png)

4. Click **Add container**.

    ![ALT](/images/module16/16.12.png)

5. Set the container name (e.g. `send`) and click **Create**.

    ![ALT](/images/module16/16.13.png)

6. Open the `send` container and click **Add Directory**.

    ![ALT](/images/module16/16.17.png)

7. Set the virtual directory name (e.g. `data`).

    ![ALT](/images/module16/16.18.png)

8. Click **Upload**.

    ![ALT](/images/module16/16.19.png)

9. Browse your local machine to upload sample data and click **Upload**.

    > **Note**
    >
    > In this example, we are using the [Hippocorpus dataset](https://msropendata.com/datasets/0a83fb6f-a759-4a17-aaa2-fbac84577318) from Microsoft Research Open Data. If you would like to use this data, [download a copy of the zip file](https://github.com/tayganr/purviewlab/raw/main/assets/hippocorpus-u20220112.zip) and extract the contents to your local machine.

    ![ALT](/images/module16/16.20.png)

10. Once the upload is complete, click the close icon.

    ![ALT](/images/module16/16.21.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 4. Provide access to the Storage Account

Before we can create a share, both the data provider and data consumer must have appropriate levels of access to the storage account.

> **Note**
>
> Below are eligible roles for sharing data and receiving shares.
> | Persona | Owner | Contributor | Storage Blob Data Owner | Storage Blob Data Contributor |
> | --- | -- | -- | -- | -- |
> | Data Provider | :white_check_mark: | | :white_check_mark: | |
> | Data Consumer | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |

1. From the Azure portal, navigate to your resource group, and open your **storage account**.

    ![ALT](/images/module16/16.09.png)

2. Open **Access Control (IAM)**.

    ![ALT](/images/module16/16.22.png)

3. Click **Add role assignment**.

    ![ALT](/images/module16/16.23.png)

4. Filter the list of roles by searching for `Storage Blob Data Owner`, select the **Storage Blob Data Owner** role, and click **Next**.

    ![ALT](/images/module16/16.24.png)

5. Click **Select members**.

    ![ALT](/images/module16/16.25.png)

6. Filter the results by searching for your account, select your account, and click **Select**.

    ![ALT](/images/module16/16.26.png)

7. Click **Review + assign**.

    ![ALT](/images/module16/16.27.png)

8. Click **Review + assign**.

    ![ALT](/images/module16/16.28.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 5. Register the Storage Account

Before we can create create or receive a share, the storage account needs to be registered with a collection.

1. From the Azure portal, navigate to your Microsoft Purview account, and open the **Microsoft Purview Governance Portal**.

    ![ALT](/images/module16/16.29.png)

2. Navigate to **Data map** > **Sources**, and click **Register**.

    ![ALT](/images/module16/16.30.png)

3. Filter the list of sources by searching for `Blob`, select **Azure Blob Storage**, and click **Continue**.

    ![ALT](/images/module16/16.31.png)

4. Select your **Azure subscription**, **Storage account**, and click **Register**.

    ![ALT](/images/module16/16.32.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 6. Create a Sent Share

Data sharing within Microsoft Purview allows data providers to share data with data consumers from supported sources such as Azure Data Lake Storage Gen2 and Azure Blob Storage accounts that have been registered with Microsoft Purview under a collection.

1. Navigate to **Data share** > **Sent shares**, and click **New share**.

    ![ALT](/images/module16/16.33.png)

2. Provide a share name (e.g. `sentShare01`), select the Share type **In-place share**, and click **Continue**.

    ![ALT](/images/module16/16.34.png)

3. Click **Add assets**.

    ![ALT](/images/module16/16.35.png)

4. Set the **Type** to **Azure Blob Storage**, select your registered Azure Blob Storage **source**, and click **Continue**.

    ![ALT](/images/module16/16.36.png)

5. Open the `send` container, select the `data` folder, and click **Add**.

    > :bulb: **Did you know?**
    >
    > * When you add assets, you have the option to select **folders** or **files**.
    > * Sharing at the **container** level is not currently supported.

    ![ALT](/images/module16/16.37.png)

6. Optionally rename the asset (e.g. `hippocorpus`), optionally rename the path (e.g. `files`), then click **OK**.

    > :bulb: **Did you know?**
    >
    > The **name** of the asset is what recipients of the Share will see.

    ![ALT](/images/module16/16.38.png)

7. Type your email address (use the same email address currently logged into Microsoft Purview) as a recipient and click **Create and Share**.

    > :bulb: **Did you know?**
    >
    > * You can optionally specify an **Expiration date** for when to terminate the share.
    > * You can share the same data with multiple recipients by clicking on **Add recipient** multiple times.

    ![ALT](/images/module16/16.39.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 7. Accept a Received Share

Once a share has been received, the recipients have the option to accept and configure the share in order to access the shared data.

1. Navigate to **Data share** > **Received shares** > **Pending**, and click to open the received share (e.g. `sentShare01`).

    ![ALT](/images/module16/16.40.png)

2. Update the received share name (e.g. `receivedShare01`) and click **Accept and configure**.

    ![ALT](/images/module16/16.41.png)

3. Click **Map**.

    ![ALT](/images/module16/16.42.png)

4. Select the target Azure Blob Storage account from the list of sources, set the **Path** (e.g. `receive`), set the **Folder** (e.g. `hippocorpus`), and click **Map to target**.

    > :bulb: **Did you know?**
    >
    > **Path** refers to the storage account **container name** (the root of the path). When specified, you must name a new container or a container which was already used to receive in-place share data.

    ![ALT](/images/module16/16.43.png)

5. Click **Close**.

    ![ALT](/images/module16/16.44.png)

6. Periodically click **Refresh** until the asset is **Mapped**.

    ![ALT](/images/module16/16.45.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 8. Access and Download Shared Data

Once a received share has been accepted and configured, you can access and download the data.

> **Note**
>
> While the shared data can be visibly seen within the data consumers target storage account, the data has been shared in-place (without data duplication). In other words, the files are symbolic links pointing back to the original files that reside in the data producers source storage account. These files can be read and downloaded by the data consumer, but the data consumer is unable to delete or modify the files.

1. Once the asset is mapped, click on the **Target** URL.

    ![ALT](/images/module16/16.46.png)

1. Navigate to the **Storage browser**.

    ![ALT](/images/module16/16.47.png)

1. Click **Blob containers**.

    ![ALT](/images/module16/16.48.png)

1. Navigate to `receive` > `hippocorpus` > `files`.

    ![ALT](/images/module16/16.49.png)

1. Open one of the files (e.g. `hippoCorpusV2.csv`) and click **Download**.

    ![ALT](/images/module16/16.50.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## :mortar_board: Knowledge Check

1. Which of the following roles, would allow a data provider to share data from a storage account?

    A ) Storage Blob Data Contributor  
    B ) Storage Blob Data Owner  
    C ) Owner  

2. You can only share data from storage accounts that are registered to a collection within Microsoft Purview's Data Map.

    A ) True  
    B ) False  

3. Which of the following best describes the list of what is currently supported when sharing data from a storage account?

    A ) Files (only)  
    B ) Folder and Files  
    C ) Container, Folder, and Files  

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## :tada: Summary

You have successfully shared data by creating a sent share, and accessed shared data by accepting and configuring a received share.

[Continue >](../modules/module17.md)
