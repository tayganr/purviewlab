# Module 01 - Create an Azure Purview Account

**[Home](../README.md)** - [Next Module>](../modules/module02.md)

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* Your must have permissions to create resources in your Azure subscription.
* Your subscription must have the following resource providers registered: Microsoft.Purview, Microsoft.Storage, and Microsoft.EventHub.

## :loudspeaker: Introduction

To create and use the Azure Purview platform, you will need to provision an Azure Purview account within an active Azure subscription.

## :dart: Objectives

* Create an Azure Purview account using the Azure portal.

<div align="right"><a href="#module-01---create-an-azure-purview-account">↥ back to top</a></div>

## Create an Azure Purview Account

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account and from the **Home** screen, click **Create a resource**.

    ![Create a Resource](../images/module01/01.01-create-resource.png)  

2. Search the Marketplace for "Azure Purview" and click **Create**.

    ![Create Purview Resource](../images/module01/01.02-create-purview.png)

3. Provide the necessary inputs on the **Basics** tab.

    | Parameter  | Example Value |
    | --- | --- |
    | Subscription | `Azure Internal Access` |
    | Resource group | `purviewlab` |
    | Purview account name | `purview-69426` |
    | Location | `Brazil South` |

Note:

* The Purview account name is used to programmatically access the Purview account and cannot be changed.
* The Purview account name can only contain letters, numbers, and hyphens.
* The first and last characters must be a letter or number.
* The hyphen (-) character must be immediately preceded and followed by a letter or number.
* Spaces are not allowed.

    ![Purview Account Bassics](../images/module01/01.03-create-basic.png)

4. Provide the necessary inputs on the **Configuration** tab.

    | Parameter  | Example Value | Note |
    | --- | --- | --- |
    | Platform size | `4 capacity units` | Sufficient for non-production scenarios. |

Note:

* Platform size is measured in "Capacity Units".
* A Capacity Unit is a provisioned set of resources to keep Azure Purview up and running.
* While in public preview, there are currently two options: 4 or 16.
* One Capacity Unit is able to support approximately 1 API call per second.

    ![Configure Purview Account](../images/module01/01.04-create-configuration.png)

5. On the **Review + Create** tab, once the message in the ribbon returns "Validation passed", verify your selections and click **Create**.

    ![Create Purview Account](../images/module01/01.05-create-create.png)

6. Wait several minutes while your deployment is in progress. Once complete, click **Go to resource**.

    ![Go to resource](../images/module01/01.06-goto-resource.png)

7. To open the out of the box user experience, click **Open Purview Studio**.

    ![Open Purview Studio](../images/module01/01.07-open-studio.png)

<div align="right"><a href="#module-01---create-an-azure-purview-account">↥ back to top</a></div>

## :mortar_board: Knowledge Check

1. Which of the following Azure Purview pricing meters is fluid, with consumption varying based on usage?

    A ) Capacity Units  
    B ) vCore Hours  
    C ) Neither

2. Which of the following Azure Purview pricing meters is fixed, with consumption based on quantity provisioned?

    A ) Capacity Units  
    B ) vCore Hours  
    C ) Neither

3. Which Azure Purview module provides the base funcionality (i.e. source registration, automated scanning and classification, data discovery)?

    A ) C0  
    B ) C1  
    C ) D0

<div align="right"><a href="#module-01---create-an-azure-purview-account">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to create an Azure Purview account instance.
