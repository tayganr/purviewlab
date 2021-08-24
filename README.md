# Azure Purview Workshop

## What is Azure Purview?

Azure Purview is a unified data governance service that helps you manage and govern your on-premises, multicloud and software-as-a-service (SaaS) data. Easily create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification and end-to-end data lineage. Empower data consumers to find valuable, trustworthy data.

## Table of Contents

* [Prerequisites](#thinking-prerequisites)
* [Lab Environment Setup](#test_tube-lab-environment-setup)
* [Learning Modules](#books-learning-modules)

<div align="right"><a href="#azure-purview-workshop">↥ back to top</a></div>

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* Owner permissions within a Resource Group to create resources and manage role assignments.
* The subscription must have the following resource providers registered.
    * Microsoft.Authorization
    * Microsoft.DataFactory
    * Microsoft.EventHub
    * Microsoft.KeyVault
    * Microsoft.Purview
    * Microsoft.Storage
    * Microsoft.Sql
    * Microsoft.Synapse

<div align="right"><a href="#azure-purview-workshop">↥ back to top</a></div>

## :test_tube: Lab Environment Setup

Click the button below to automatically deploy the associated resources to Azure. Tip: Right-click the button to open the Azure Portal in a new window.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftayganr%2Fpurviewlab%2Fmain%2Ftemplate%2Fazuredeploy.json)

Note:

* The Azure Purview account resource has been purposely **excluded** from the template so that participants have an opportunity to understand how to deploy an Azure Purview account via the Azure Portal.
* The template is setup to deploy resources to the same location as the selected resource group, ensure to select a [valid location](https://azure.microsoft.com/en-us/global-infrastructure/services/?products=purview&regions=all).
* The deployment should take approximately 5 minutes to complete.

<div align="right"><a href="#azure-purview-workshop">↥ back to top</a></div>

## :books: Learning Modules

1. [Create an Azure Purview Account](./modules/module01.md)
2. Register & Scan: [2A. ADLS Gen1 (Managed Identity)](./modules/module02a.md) | [2B. Azure SQL DB (Azure Key Vault)](./modules/module02b.md)
3. [Search & Browse](./modules/module03.md)
4. [Glossary](./modules/module04.md)
5. [Classifications](./modules/module05.md)
6. [Lineage](./modules/module06.md)
7. [Insights](./modules/module07.md)
8. [Monitor](./modules/module08.md)
9. [Integrate with Azure Synapse Analytics](./modules/module09.md)
10. [REST API](./modules/module10.md)

<div align="right"><a href="#azure-purview-workshop">↥ back to top</a></div>

## :link: Workshop URL
[aka.ms/purviewlab](https://aka.ms/purviewlab)
