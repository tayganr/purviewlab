# Module 07 - Insights

[< Previous Module](../modules/module06.md) - **[Home](../README.md)** - [Next Module >](../modules/module08.md)

```diff
!                               << PLEASE READ BEFORE PROCEEDING >>                                
!                                                                                                  
! * Insights within Azure Purview can take several hours to surface post the completion of a scan. 
! * At this point of the workshop, only a limited number of data visualisations may be populated.  
! * To populate all reports with data, Azure Purview requires an environment with a variety of     
! sources and assets to be scanned that is beyond the scope of this workshop.                      
! * The screenshots and information below, has been provided so that you can conceptualise the type
! of insights that can be gleaned from a fully populated environment.                              
```

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).
* Set up and complete a scan (see [module 02](../modules/module02.md)).

## :loudspeaker: Introduction

Insights provides customers, a single pane of glass view into their catalog and further aims to provide specific insights to the data source administrators, business users, data stewards, data officer, and security administrators. Azure Purview currently has the following reports available:

* Assets
* Scans
* Glossary
* Classification
* Sensitivity Labels

## :dart: Objectives

* Understand the different types of insights that can be gleaned from the out of the box reporting.

## Table of Contents

1. [Asset Insights](#1-asset-insights)
2. [Scan Insights](#2-scan-insights)
3. [Glossary Insights](#3-glossary-insights)
4. [Classification Insights](#4-classification-insights)
5. [Sensitivity Labels Insights](#5-sensitivity-labels-insights)
6. [File Extensions Insights](#6-file-extensions-insights)

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## 1. Asset Insights

1. Open Purview Studio, navigate to **Insights** > **Assets**.

    ![Assets Insights](../images/module07/07.01-assets-insights.png)

2. The Assets page displays the following **high-level metrics**.
    * Number of Source Types
    * Number of Discovered Assets
    * Number of Classified Assets

    ![Assets KPI](../images/module07/07.02-assets-kpi.png)

3. Further down the page you will find additional **data visualizations**, typically these tiles will allow interactive filtering and the ability to drill-down into the underlying detail by clicking **View more**. The Assets page includes the following **graphs**:

    **Asset Count per Source Type**

    ![Assets Graph 01](../images/module07/07.03-assets-graph01.png)

    **Size Trend (GB) of File Type within Source Types**

    ![Assets Graph 02](../images/module07/07.04-assets-graph02.png)

    **Files Not Associated with a Resource Set**

    ![Assets Graph 03](../images/module07/07.05-assets-graph03.png)

    > :bulb: **Did you know?**
    >
    > Using the quick filters on the **Asset Count per Source Type** graph and drilling into the details by clicking **View more**, is a quick and easy way of identifying which sources contain certain types of data.

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## 2. Scan Insights

1. Open Purview Studio, navigate to **Insights** > **Scans**.

    ![Scan Insights](../images/module07/07.06-scans-insights.png)

2. The Scans page displays the following **high-level metrics**.
    * Number of Scans
    * Number of Successful Scans
    * Number of Canceled Scans
    * Number of Failed Scans

    ![Scan KPI](../images/module07/07.07-scans-kpi.png)

3. The Scans page includes the following **graphs**:
    
    **Number of Scans by Date and Status**

    ![Scan Graph 01](../images/module07/07.08-scans-graph01.png)

    > :bulb: **Did you know?**
    >
    > Clicking **View more** on the **Scan Status** graph will show scans that have occurred over the last 30 days with aggregated counts by status (Success, Failed, Canceled). Drilling further by clicking on a scan name will reveal the scan run history with quick action buttons to edit, delete, or run.

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## 3. Glossary Insights

1. Open Purview Studio, navigate to **Insights** > **Glossary**.

    ![Glossary Insights](../images/module07/07.09-glossary-insights.png)

2. The Glossary page displays the following **high-level metrics**.
    * Total Number of Terms
    * Number of Approved Terms without Assets
    * Number of Expired Terms with Assets

    ![Glossary KPI](../images/module07/07.10-glossary-kpi.png)

3. The Glossary page includes the following **graphs**:
     
    **Terms by Asset Count**

    ![Glossary Graph 01](../images/module07/07.11-glossary-graph01.png)

    **Terms by Status (with and without assets)**

    ![Glossary Graph 02](../images/module07/07.12-glossary-graph02.png)

    **Number of Incomplete Terms**

    ![Glossary Graph 03](../images/module07/07.13-glossary-graph03.png)

    > :bulb: **Did you know?**
    >
    > Terms are considered **incomplete** if they are missing a definition, expert, or steward. If a term is missing more than one of these things, it is shown as **Missing multiple**.

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## 4. Classification Insights

1. Open Purview Studio, navigate to **Insights** > **Classification**.

    ![Classification Insights](../images/module07/07.14-classification-insights.png)

2. The Classification page displays the following **high-level metrics**.
    * Number of Subscriptions (with Classifications)
    * Unique Number of Classifications Found
    * Number of Sources Classified
    * Number of Files Classified
    * Number of Tables Classified

    ![Classification KPI](../images/module07/07.15-classification-kpi.png)

3. The Classification page includes the following **graphs**:
     
    **Top Sources with Classified Data by Date**

    ![Classification Graph 01](../images/module07/07.16-classification-graph01.png)

    **Top Classification Categories by Sources**

    ![Classification Graph 02](../images/module07/07.17-classification-graph02.png)

    **Top Classifications for Files**

    ![Classification Graph 03](../images/module07/07.18-classification-graph03.png)

    **Top Classifications for Tables**

    ![Classification Graph 04](../images/module07/07.19-classification-graph04.png)

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## 5. Sensitivity Labels Insights

1. Open Purview Studio, navigate to **Insights** > **Sensitivity Labels**.

    > :bulb: **Did you know?**
    >
    > **Sensitivity labels** state how sensitive data is in your organization. For example, data contained within a particular asset might be `highly confidential`. **Classifications** on the other hand indicate the type of data values (e.g. Driver's License Number, Email Address, SWIFT Code, etc) 
    >
    > Azure Purview's ability to apply sensitivity labels is due to the close integration with **Microsoft Information Protection** offered in Microsoft 365. Note: You must turn on Information Protection for Azure Purview in the Microsoft 365 compliance center. For more information, check out how to [Automatically label your data in Azure Purview](https://docs.microsoft.com/en-us/azure/purview/create-sensitivity-label).

    ![Sensitivity Labels Insights](../images/module07/07.20-labels-insights.png)

2. The Sensitivity Labels page displays the following **high-level metrics**.
    * Number of Subscriptions (with Sensitivity Labels)
    * Unique Number of Labels Found
    * Number of Sources Labeled
    * Number of Files Labeled
    * Number of Tables Labeled

    ![Sensitivity Labels KPI](../images/module07/07.21-labels-kpi.png)

3. The Sensitivity Labels page includes the following **graphs**:
    
    **Top Sources with Labeled Data by Date**

    ![Sensitivity Labels Graph 01](../images/module07/07.22-labels-graph01.png)

    **Top Labels Applied Across Sources**

    ![Sensitivity Labels Graph 02](../images/module07/07.23-labels-graph02.png)

    **Top Labels Applied on Files**

    ![Sensitivity Labels Graph 03](../images/module07/07.24-labels-graph03.png)

    **Top Labels Applied on Tables**

    ![Sensitivity Labels Graph 04](../images/module07/07.25-labels-graph04.png)

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## 6. File Extensions Insights

1. Open Purview Studio, navigate to **Insights** > **File Extensions**.

    ![File Extensions Insights](../images/module07/07.26-fileext-insights.png)

2. The File Extensions page displays the following **high-level metrics**.
    * Unique Number of File Extensions Found

    ![File Extensions KPI](../images/module07/07.27-fileext-kpi.png)

3. The File Extensions page includes the following **graphs**:
    
    **Top File Extensions**

    ![File Extensions Graph 01](../images/module07/07.28-fileext-graph01.png)
   
<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## :mortar_board: Knowledge Check

[http://aka.ms/purviewlab/q07](http://aka.ms/purviewlab/q07)

1. Which section would show the **number of discovered assets**?

    A ) Assets  
    B ) Scans  
    C ) File extensions

2. A glossary term that does not have a steward (i.e. an assigned contact), is shown as an **incomplete term**.

    A ) True  
    B ) False

3. An asset has been tagged as `highly confidential`. Which type of tag is this?

    A ) Classification  
    B ) Category  
    C ) Sensitivity Label

<div align="right"><a href="#module-07---insights">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to glean insights on Assets, Scans, Glossary Terms, Classifications, Sensitivity Labels, and File Extensions across your data estate.

[Continue >](../modules/module08.md)
