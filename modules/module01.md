# Module 01 - Create an Azure Purview Account

**[Home](../README.md)** - [Next Module>](../modules/module02.md)

## Prerequisites

* An Azure account with an active subscription.
* Your account must have permissions to create resources in the subscription.

## Introduction

To create and use the Azure Purview platform, you will need to provision an Azure Purview account within an active Azure subscription.

## Learning Objectives

* Create an Azure Purview account using the Azure portal.
* Select the appropriate platform size.

## Sign in to the Azure Portal

Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.

<div align="right"><a href="#module-01---create-an-azure-purview-account">↥ back to top</a></div>

## Create an Azure Purview Account

1. From the **Home** screen, click **Create a resource**.

    ![Create a Resource](../images/module01/01-create-resource.png)  

2. Search the Marketplace for "Azure Purview" and click **Create**.

    ![Create Purview Resource](../images/module01/01-create-purview.png)

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

    ![Purview Account Bassics](../images/module01/01-create-basic.png)

4. Provide the necessary inputs on the **Configuration** tab.

    | Parameter  | Example Value | Note |
    | --- | --- | --- |
    | Platform size | `4 capacity units` | Sufficient for non-production scenarios. |

Note:

* Platform size is measured in "Capacity Units".
* A Capacity Unit is a provisioned set of resources to keep Azure Purview up and running.
* While in public preview, there are currently two options: 4 or 16.
* One Capacity Unit is able to support approximately 1 API call per second.

    ![Configure Purview Account](../images/module01/01-create-configuration.png)

5. On the **Review + Create** tab, once the message in the ribbon returns "Validation passed", verify your selections and click **Create**.

    ![Create Purview Account](../images/module01/01-create-create.png)

6. Wait several minutes while your deployment is in progress. Once complete, click **Go to resource**.

    ![Go to resource](../images/module01/01-goto-resource.png)

7. To open the out of the box user experience, click **Open Purview Studio**.

    ![Open Purview Studio](../images/module01/01-open-studio.png)

<div align="right"><a href="#module-01---create-an-azure-purview-account">↥ back to top</a></div>

## Summary

This module provided an overview of how to create an Azure Purview account instance.
