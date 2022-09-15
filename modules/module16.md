# Module 16 - Data Sharing

[< Previous Module](../modules/module14.md) - **[Home](../README.md)**

## :loudspeaker: Introduction

Organizations are increasingly looking for ways to enable seamless and secure data sharing. Whether that be to send and receive data to external organizations or for inter-departmental use cases. However, doing so in a way where organizations are able to maintain control and visibility can be a challenge. Even today, data continues to be shared using File Transfer Protocols (FTPs), Application Programming Interfaces (APIs), USB devices, and email attachments. These methods are traditionally not secure, challenging to govern, and generally inefficient.

With Microsoft Purview Data Sharing:

* Data providers can now share data in-place from Azure Data Lake Storage Gen2 and Azure Storage accounts, both within and across orgnaizations. Share data directly without data duplication and centrally manage your sharing activities from within Microsoft Purview.
* Data consumers can now have near real-time access to shared data. With storage data access and transactions charged to the data consumers based on what they use, at no additional cost to the data provider.

## :thinking: Prerequisites

* A Microsoft Purview account (see [module 01](../modules/module01.md)).

## :dart: Objectives

* OBJECTIVE_PLACHOLDER
* OBJECTIVE_PLACHOLDER
* OBJECTIVE_PLACHOLDER

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [H2_TITLE](#jump-link) | Role |
| 2 | [H2_TITLE](#jump-link) | Role |
| 3 | [H2_TITLE](#jump-link) | Role |

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 1. Enable the AllowDataSharing preview feature

Your Azure subscription must be registered for the Microsoft.Storage **AllowDataSharing** preview feature **BEFORE** you create storage account(s) to share and receive data.

1. Open the Azure portal, type `Subscriptions` in the search bar and click **Subscriptions**.

    ![ALT](/images/module16/16.01.png)

2. Select your Azure subscription.

    ![ALT](/images/module16/16.02.png)

3. Scroll down on the left side menu and click **Preview features**, filter the results by searching for `AllowDataSharing`, select the **AllowDataSharing** feature and click **Register**. Periodically click **Refresh** to confirm the state is **Registered**. Note: This can take 15 minutes to 1 hour to complete.

    ![ALT](/images/module16/16.03.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 2. Create a Storage Account

Microsoft Purview Data Sharing supports sharing of files and folders in-place from Azure Data Lake Storage Gen2 and Blob Storage accounts.

> **Note**
>
> * Source and target storage accounts must be created **AFTER** the **AllowDataSharing** preview registration step is complete.
> * Both the source and target storage accounts **must be in the same Azure region** as each other.
> * The storage account needs to be **registered in the collections** where you'll send or receive the share.

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

Before we can create a share, we must populate our storage account with some folders and files.

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

6. Click **Add container**.

    ![ALT](/images/module16/16.14.png)

7. Set the container name (e.g. `receive`) and click **Create**.

    ![ALT](/images/module16/16.15.png)

8. Open the `send` container.

    ![ALT](/images/module16/16.16.png)

9. Click **Add Directory**.

    ![ALT](/images/module16/16.17.png)

10. Set the virtual directory name (e.g. `data`).

    ![ALT](/images/module16/16.18.png)

11. Click **Upload**.

    ![ALT](/images/module16/16.19.png)

12. Browse your local machine to upload sample data and click **Upload**.

    > Note
    >
    > In this example, we are using the [Hippocorpus dataset](https://msropendata.com/datasets/0a83fb6f-a759-4a17-aaa2-fbac84577318) from Microsoft Research Open Data. If you would like to use this data, [download a copy of the zip file](https://github.com/tayganr/purviewlab/raw/main/assets/hippocorpus-u20220112.zip) and extract the contents to your local machine.

    ![ALT](/images/module16/16.20.png)

13. Once the upload is complete, click the close icon.

    ![ALT](/images/module16/16.21.png)

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## 4. Assign a Storage Account Role

Before we can create a share, both the data provider and data consumer must have appropriate levels of access to the storage account.

> Note
>
> Below are eligible roles for sharing data and receiving shares.
> | Persona | Owner | Contributor | Storage Blob Data Owner | Storage Blob Data Contributor |
> | --- | -- | -- | -- | -- |
> | Data Provider | :white_check_mark: | | :white_check_mark: | |
> | Data Consumer | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |

1. From the Azure portal, navigate to your resource group, and open your **storage account**.

    ![ALT](/images/module16/16.09.png)

## :mortar_board: Knowledge Check

1. PLACEHOLDER_KNOWLEDGE_CHECK_QUESTION

    A ) Asset Type  
    B ) Classification  
    C ) Size  

2. PLACEHOLDER_KNOWLEDGE_CHECK_QUESTION

    A ) True  
    B ) False  

3. PLACEHOLDER_KNOWLEDGE_CHECK_QUESTION

    A ) True  
    B ) False  

<div align="right"><a href="#module-16---data-sharing">↥ back to top</a></div>

## :tada: Summary

MODULE_SUMMARY

[Continue >](../modules/module00.md)
