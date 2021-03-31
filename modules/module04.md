# Module 04 - Glossary

[< Previous Module](../modules/module03.md) - **[Home](../README.md)** - [Next Module>](../modules/module05.md)

## :thinking: Prerequisites

* An Azure account with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).

## :loudspeaker: Introduction

A glossary is an important tool for maintaining and organizing your catalog. You build your glossary by defining new terms or importing a term list and then applying those terms to your assets.

## :dart: Objectives

* Create a Term in the Glossary using the System Default Term Template.
* Create a Term in the Glossary using a Custom Term Tempalte.
* Bulk Import Terms into the Glossary via a CSV file.
* Bulk Export Terms from the Glossary into a CSV file.
* Assign a Term to an Asset in the Data Catalog.

## Table of Contents

1. [Create a Term (System Default Term Template)](#1-create-a-term-system-default-term-template)
2. [Create a Term (Custom Term Template)](#2-create-a-term-custom-term-template)
3. [Bulk Import Terms](#3-bulk-import-terms)
4. [Bulk Export Terms](#4-bulk-export-terms)
5. [Assign a Term to an Asset](#5-assign-a-term-to-an-asset)

<div align="right"><a href="#module-04---glossary">↥ back to top</a></div>

## 1. Create a Term (System Default Term Template)

1. Open Purview Studio and from the **Glossary** screen, click **New term**.

    ![New Glossary Term](../images/module04/04.01-glossary-new.png)

2. Select the **System default** term template and click **Continue**.

    ![System default term template](../images/module04/04.02-term-default.png)

3. Populate the term fields as per the examples below and click **Create**.

    | Field  | Example Value |
    | --- | --- |
    | Status | `Approved` |
    | Name | `Contoso Parent` |
    | Definition | `This will be the parent term.` |
    | Acronym | `CP` |
    | Resource Name | `Azure Purview` |
    | Resource Link | `https://aka.ms/Azure-Purview` |

    ![New Term](../images/module04/04.03-term-create.png)

<div align="right"><a href="#module-04---glossary">↥ back to top</a></div>

## 2. Create a Term (Custom Term Template)

1. Open Purview Studio and from the **Glossary** screen, click **New term**.

    ![New Term](../images/module04/04.04-glossary-new2.png)

2. Click **New term template**.

    ![New term template](../images/module04/04.05-template-new.png)

3. Provide the Term Template a **Name** (e.g. `Contoso Template`) and click **New attribute**.

    ![Term template](../images/module04/04.06-attribute-new.png)

4. Provide the Attribute a **Name** (e.g. `Business Unit`), set **Field Type** to **Single Choice** and populate with values (e.g. `Sales`, `Marketing`, `Finance`, `IT`). Click **Apply**.

    ![Attribute](../images/module04/04.07-attribute-properties.png)

5. Click **Create**.

    ![Create term template](../images/module04/04.08-template-create.png)

6. Select **Contoso Template** and click **Continue**.
    
    ![Custom Term Template](../images/module04/04.09-term-custom.png)

9. Populate the term fields as per the examples below and click **Create**.

    | Field  | Example Value |
    | --- | --- |
    | Status | `Approved` |
    | Name | `Contoso Child` |
    | Definition | `This will be the long description for the child glossary term.` |
    | Business Unit | `Marketing` |

    ![](../images/module04/04.10-term-create2.png)

10. From the **Glossary** screen, change the view to **Hierarchical view** to see the hierarchal glossary.

    ![](../images/module04/04.11-glossary-table.png)


<div align="right"><a href="#module-04---glossary">↥ back to top</a></div>

## 3. Bulk Import Terms

1. Download a copy of **[import-terms-sample.csv](https://github.com/tayganr/purviewlab/raw/main/assets/import-terms-sample.csv)** to your local machine.

2. From the **Glossary** screen, click **Import terms**.

    ![Import terms](../images/module04/04.12-glossary-import.png)

3. Selec the **System default** term template and click **Continue**.

    ![Term Template](../images/module04/04.13-import-default.png)

4. Click **Browse** and open the local copy of **[import-terms-sample.csv](https://github.com/tayganr/purviewlab/raw/main/assets/import-terms-sample.csv)**.

    ![Browse](../images/module04/04.14-import-browse.png)

5. Click **OK**.

    ![Upload CSV file](../images/module04/04.15-import-ok.png)

6. Once complete, you should see 50 additional terms beneath the parent (Workplace Analytics).<br>:bulb: **Tip**: You can quickly find specific types of terms using the filters at the top (e.g. Status = Approved).

    ![Filter Terms](../images/module04/04.16-glossary-filter.png)

<div align="right"><a href="#module-04---glossary">↥ back to top</a></div>

## 4. Bulk Export Terms

1. From the **Glossary** screen, we want to select ALL terms (top check box) and then de-select terms that do not belong to Workplace Analytics (i.e. Contoso Parent, Contoso Child). **All Workplace Analytics terms** should be selected. Click **Export terms**.

    ![Export Terms](../images/module04/04.17-glossary-export.png)

2. If the export was successful, you should find a **CSV** file has been copied to your local machine (e.g. Downloads).

    ![Downloads](../images/module04/04.18-export-downloads.png)

<div align="right"><a href="#module-04---glossary">↥ back to top</a></div>

## 5. Assign a Term to an Asset

1. Perform a wildcard search by typing asterik (**\***) into the search bar and hitting **Enter** to submit the query. Click on an asset title (e.g. `QueriesByState`) to view the details.

    ![Wildcard Search](../images/module04/04.19-search-wildcard.png)

2. Click **Edit**.

    ![](../images/module04/04.20-asset-edit.png)

3. Open the **Glossary terms** drop-down and select a glossary term (e.g. `Contoso Child`). Click **Save**.

    ![](../images/module04/04.21-asset-term.png)

4. Click on the hyperlinked term name to view the glossary term details.

    ![](../images/module04/04.22-term-assigned.png)

5. Click **Refresh** to view the **Catalog assets** the term is assigned to.

    ![](../images/module04/04.23-term-assets.png)

<div align="right"><a href="#module-04---glossary">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to create, export, and import terms into the Azure Purview glossary.
