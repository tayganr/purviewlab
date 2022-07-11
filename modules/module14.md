# Module 14 - Policies

[< Previous Module](../modules/module00.md) - **[Home](../README.md)** - [Next Module >](../modules/module00.md)

## :loudspeaker: Introduction

A new feature of Purview is Policies, which enables you to secure your data estate from within the Microsoft Purview Governance Portal. This feature is in Preview as of July 2022.

Data access policies can be enforced through Purview on data systems that have been registered in Purview for scanning and data use management. This feature allows Data stewards and owners to grant read, write access to various data stores from within Purview by creating a data access policy through the Policy Management app in the governance portal, enabling a single dashboard view of all access granted to all systems.

A **policy** is a named collection of policy statements. When a policy is published to one or more data systems under Purview’s governance, it's then enforced by the system. A policy definition includes a policy name, description, and a list of one or more policy statements.

## :thinking: Prerequisites

* An Azure account with an active subscription.
* An Azure Data Lake Storage Gen2 Account (see module 00) in same subscription.
* A Azure SQL DB account in same subscription.
* A Microsoft Purview account (see module 01).

## :dart: Objectives

* Register data source for data use management
* Create data owner access policy for Azure Storage

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [Configure permissions for policy management actions](#1-configure-permissions-for-policy-management-actions) | Collection Admin |
| 2 | [Author and Publish policies for an Azure Storage](#2-Author-and-Publish-policies-for-an-Azure-Storage) | Data Source Administrator / Policy Author |

<div align="right"><a href="#module-14---policies">↥ back to top</a></div>

## 1. Configure permissions for policy management actions

To make a data resource available for policy management, the Data Use Management (DUM) toggle needs to be enabled. A user, who will manage the policies in Purview, will need certain IAM privileges on the resource and MS Purview in order to enable the DUM toggle.

1. Grant IAM privileges to the user on the storage resource.  
    Navigate to the **Access Control(IAM)** page of the storage account resource. Click on **+ Add** --> **Add role assignment**. Grant either of the following IAM role combinations 
    * Owner
    * Both Contributor and User Access Administrator

 ![Grant IAM privilege](../images/module14/Storage-IAM.png)    
 
 
 ![Grant Contributor privilege](../images/module14/01-01contributor-role.png)    
 
 ![Grant User Mgmt privilege](../images/module14/01-01user-management.png)  
  
 >
2. Grant roles to the same user in MS Purview.
    In Purview grant the same user **Data Source Adminstrator (DSA)** and **Policy authors** role at the root collection level. 
    Navigate to **Collections**. Click on the root collection. Click on **Role assignments**

 ![Grant DSA privilege](../images/module14/01-01purview-role.png)
 

 ![Grant policy privilege](../images/module14/01-02policy-author-roles.png)

3. Enable Data Use Management
    After a source is registered, edit the source. Set the **Data Use Management** toggle to **Enabled** as shown below. 
    
![Enable DUM](../images/module14/01-03DUM.png)

> :bulb: **Did you know?**
>
> DSA role can publish a policy. 
> Policy authors role can create or edit a policy.


<div align="right"><a href=""#module-14---policies">↥ back to top</a></div>

## 2. Author and Publish policies for an Azure Storage

1. In the Microsoft Purview governance portal, navigate to the Data policy feature using the left side panel as shown

 ![Create policy](../images/module14/02-01create-policy.png)


2. On the new policy page, enter the **Name** and **Description** of the policy and select the **New policy statement** button, to add a new policy.

 ![Add policy](../images/module14/02-02New-Policy.png)

3. Select the **Effect** dropdown and choose **Allow**. 
4. Select the **Action** dropdown and choose **Read** or **Modify**.
5. Select the **Data Resources** button This will bring up a window to enter the Data resource information. Use the **Assets** box and enter the **Data Source Type** and hte **Name** of a previously registered and scanned data source.

 ![Data Resource](../images/module14/02-05DataResource.png)
 
6. Select the **Continue** button and transverse the hierarchy to select and underlying data-object (for example: folder, file, etc.). Select **Recursive** to apply the policy from that point in the hierarchy down to any child data-objects. Then select the **Add** button. This will take you back to the policy editor.

![Data Resource1](../images/module14/0206DataResource.png)

7. Select the **Subjects** button and enter the subject identity as a principal, group, or MSI. Then select the **OK** button. This will take you back to the policy editor

![Policy Subject](../images/module14/02-07Subject.png)

8. Select the **Save** button to save the policy.
9. Select the newly created policy from the list of policies on the the Policy portal. Select the **Publish** button on the right top cornerof the page.

![Policy Publish](../images/module14/02-09publish-policy.png)

11. A list of data sources is displayed. You can enter a name to filter the list. Then, select each data source where this policy is to be published and then select the **Publish** button.

![Data Source](../images/module14/02-10select-data-sources-publish-policy.png)

<div align="right"><a href="#module-14---policies">↥ back to top</a></div>

## :mortar_board: Knowledge Check

1. The data source has to be scanned before the policy can be published on it.

    A ) True   
    B ) False    

2. Which role is needed for a user to be able to publish the policy.

    A ) Policy Author   
    B ) Owner  
    c ) Data Source Administrator  

3. Once the policy is published, it cannot be edited

    A ) True  
    B ) False  

<div align="right"><a href="#module-00---title">↥ back to top</a></div>

## :tada: Summary

Purview policies allow you to manage access to data source from within the governance portal. 

[Continue >](../modules/module00.md)
