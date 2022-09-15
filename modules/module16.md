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

## 1. Register the AllowDataSharing preview feature

Your Azure subscription must be registered for the Microsoft.Storage **AllowDataSharing** preview feature **BEFORE** you create storage account(s) to share and receive data.

1. Open the Azure portal, type `Subscriptions` in the search bar and click **Subscriptions**.

    ![ALT](/images/module16/16.01.png)

2. Select your Azure subscription.

    ![ALT](/images/module16/16.02.png)

3. Scroll down on the left side menu and click **Preview features**, filter the results by searching for `AllowDataSharing`, select the **AllowDataSharing** feature and click **Register**. Periodically click **Refresh** to confirm the state is **Registered**. Note: This can take 15 minutes to 1 hour to complete.

    ![ALT](/images/module16/16.03.png)

<div align="right"><a href="#module-00---title">↥ back to top</a></div>

## 2. Create a Storage Account

Microsoft Purview Data Sharing supports sharing of files and folders in-place from Azure Data Lake Storage Gen2 and Blob Storage accounts.

> :grey_exclamation: **Note**
>
> * Source and target storage accounts must be created **AFTER** the **AllowDataSharing** preview registration step is complete.
> * Both the source and target storage accounts **must be in the same Azure region** as each other.
> * The storage account needs to be **registered in the collections** where you'll send or receive the share.

1. From the Azure portal, open the portal menu and click **Create a resource**.

    ![ALT](/images/module16/16.04.png)

2. Select **Storage account**.

    ![ALT](/images/module16/16.05.png)

3. Populate the Basics screen and click **Review**.

    > :grey_exclamation: **Note**
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


<div align="right"><a href="#module-00---title">↥ back to top</a></div>

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

<div align="right"><a href="#module-00---title">↥ back to top</a></div>

## :tada: Summary

MODULE_SUMMARY

[Continue >](../modules/module00.md)
