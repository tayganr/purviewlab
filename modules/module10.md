# Module 10 - REST API

[< Previous Module](../modules/module09.md) - **[Home](../README.md)** - [Next Module>](../modules/module11.md)

## Prerequisites

* An Azure account with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).

## Table of Contents

1. [Register an Application](#1-register-an-application)
2. [Generate a Client Secret](#2-generate-a-client-secret)
3. [Provide Service Principal Access to Azure Purview](#3-provide-service-principal-access-to-azure-purview)
4. [Use Postman to Call Azure Purview REST API](#4-use-postman-to-call-azure-purview-rest-api)

<div align="right"><a href="#module-10---rest-api">↥ back to top</a></div>

## 1. Register an Application

1. Sign in to the [Azure portal](https://portal.azure.com/), navigate to **Azure Active Directory** > **App registrations**, and click **New registration**.

    ![](../images/module10/10.01-azuread-appreg.png)

2. Provide the application a **name**, select an **account type**, and click **Register**.

    | Property | Example Value |
    | --- | --- |
    | Name | `purview-spn` |
    | Account Type | Accounts in this organizational directory only - Single tenant |
    | Redirect URI (optional) | *Leave blank* |

    ![](../images/module10/10.02-azuread-register.png)

3. **Copy** the following values for later use.

    * Application (client) ID
    * Directory (tenant) ID

    ![](../images/module10/10.03-spn-copy.png)

<div align="right"><a href="#module-10---rest-api">↥ back to top</a></div>

## 2. Generate a Client Secret

1. Navigate to **Certifications & secrets** and click **New client secret**.

    ![](../images/module10/10.04-spn-secret.png)

2. Provide a **Description** and set the **expiration** to `In 1 year`, click **Add**.

    | Property | Example Value |
    | --- | --- |
    | Description | `purview-api` |
    | Expires | `In 1 year` |

    ![](../images/module10/10.05-spn-secretadd.png)

3. **Copy** the client secret value for later use.

    ![](../images/module10/10.06-secret-copy.png)

<div align="right"><a href="#module-10---rest-api">↥ back to top</a></div>

## 3. Provide Service Principal Access to Azure Purview

1. Under the Azure Purview account, navigate to **Access control (IAM)** and click **Add role assignments**.

    ![](../images/module10/10.07-access-add.png)

2. Select the **Purview Data Curator** role, select the service principal and click **Save**.

    ![](../images/module10/10.08-rbac-assign.png)

<div align="right"><a href="#module-10---rest-api">↥ back to top</a></div>

## 4. Use Postman to Call Azure Purview REST API

1. Do A

    ![](../images/module10/10.09-postman-login.png)

2. Do B

    ![](../images/module10/10.10-postman-get.png)

<div align="right"><a href="#module-10---rest-api">↥ back to top</a></div>

## Summary

In this module, you learn how to get started with the Azure Purview REST APIs. Anyone who wants to submit data to an Azure Purview Catalog, include the catalog as part of an automated process, or build their own user experience on the catalog can use the REST APIs to do so.
