# Module 01 - Create an Azure Purview Account

**[Home](../README.md)** - [Next Module>](../modules/module02.md)

## Prerequisites

* An Azure account with an active subscription.
* Your account must have permissions to create resources in the subscription.

## Introduction

To create and use the Azure Purview platform, you will need to provision a Purview account within an active Azure subscription.

## Learning Objectives

* Create an Azure Purview account using the Azure portal.
* Select the appropriate platform size.

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.

## Create an Azure Purview Account

1. From the **Home** screen, click **Create a resource**.

![Azure Purview](../images/01-create-resource.png)  

2. Search the Marketplace for "Azure Purview" and click **Create**.

![Azure Purview](../images/01-create-purview.png)

3. On the **Basics** tab, do the following:
    *  Select a **Subscription**.
    *  Select a **Resource group**.
    *  Enter a **Purview account name**.
    *  Select a **Location**.

Note:

* The Purview account name is used to programmatically access the Purview account and cannot be changed.
* The Purview account name can only contain letters, numbers, and hyphens.
* The first and last characters must be a letter or number.
* The hyphen (-) character must be immediately preceded and followed by a letter or number.
* Spaces are not allowed.

![Azure Purview](../images/01-create-basic.png)

4. On the **Configuration** tab, do the following:
    *  Select a **Platform size**.

Note:

* Platform size is measured in "Capacity Units".
* A Capacity Unit is a provisioned set of resources to keep Azure Purview up and running.
* While in public preview, there are currently two options: 4 or 16.
* One Capacity Unit is able to support approximately 1 API call per second.

![Azure Purview](../images/01-create-configuration.png)

5. On the **Review + Create** tab, once the message in the ribbon returns "Validation passed", verify your selections and click **Create**.

![Azure Purview](../images/01-create-create.png)

6. Wait several minutes while your deployment is in progress. Once complete, click **Go to resource**.

![Azure Purview](../images/01-goto-resource.png)

7. To open the out of the box user experience, click **Open Purview Studio**.

![Azure Purview](../images/01-open-studio.png)