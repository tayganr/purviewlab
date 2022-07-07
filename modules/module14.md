@@ -0,0 +1,110 @@
# Module 14 - Policies

[< Previous Module](../modules/module00.md) - **[Home](../README.md)** - [Next Module >](../modules/module00.md)

## :loudspeaker: Introduction

A new feature of Purview is Policies, which enables you to secure your data estate from within the Microsoft Purview Governance Portal. This feature is in Preview as of July 2022.

Data access policies can be enforced through Purview on data systems that have been registered for policy. This allows Data stewards and owners to grant read, write access to various data stores from within Purview by creating a data access plicy through the Policy Management app in the governance portal. This allows data owners to get a single view / modify of all access granted to all systems from a single dashboard.

A policy is a named collection of policy statements. When a policy is published to one or more data systems under Purview’s governance, it's then enforced by them. A policy definition includes a policy name, description, and a list of one or more policy statements.

## :thinking: Prerequisites

* An Azure account with an active subscription.
* An Azure Data Lake Storage Gen2 Account (see module 00) in same subscription.
* A Azure SQL DB account in same subscription.
* A Microsoft Purview account (see module 01).

## :dart: Objectives

* Register data source for data use management
* Create data owner access policy for Azure Storage
* Create data owner access policy forAzure SQL DB
* Create data owner access policy for resource groups or subscriptions.

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [H2_TITLE](#jump-link) | Role |
| 2 | [H2_TITLE](#jump-link) | Role |
| 3 | [H2_TITLE](#jump-link) | Role |

<div align="right"><a href="#module-00---title">↥ back to top</a></div>

## 1. Configure permissions for policy management actions

To make a data resource available for policy management, the Data Use Management (DUM) toggle needs to be enabled. A user, who will manage the policies in Purview, will need certain IAM privileges on the resource and MS Purview in order to enable the DUM toggle.

1. Grant IAM privileges to the user on the storage resource
    Navigate to the Access Control(IAM) page of the storage account resource. Click on "+ Add" --> Add role assignment. Grant either of the following IAM role combinations 
    * Owner
    * Both Contributor and USer Access Administrator

 ![Grant IAM privilege](../images/module14/Storage-IAM.png)  
    

2. Grant Data Source Administrator role to the same user in MS Purview.

3. STEP_PLACEHOLDER

> :bulb: **Did you know?**
>
> Did you know sections can be used to help articulate a concept, provide additional clarity, etc.

```text
Values that need to be copied/pasted should be placed in code snippets
```

<div align="right"><a href="#module-00---title">↥ back to top</a></div>

## 2. H2_TITLE

SHORT_DESCRIPTION

1. STEP_PLACEHOLDER

2. STEP_PLACEHOLDER

3. STEP_PLACEHOLDER

<div align="right"><a href="#module-00---title">↥ back to top</a></div>

## 3. H2_TITLE

SHORT_DESCRIPTION

1. STEP_PLACEHOLDER

2. STEP_PLACEHOLDER

3. STEP_PLACEHOLDER

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
