# Module 03 - Search & Browse

[< Previous Module](../modules/module02b.md) - **[Home](../README.md)** - [Next Module >](../modules/module04.md)

## :loudspeaker: Introduction

Once sources have been registered and scanned, the underlying data catalog will begin to populate with assets that represent real-world objects (e.g. a table in an Azure SQL Database, a Power BI report, etc.) The surfacing of these assets via Microsoft Purview's search experience helps empower data consumers to find data assets that matters to them.

In this module, you'll learn to edit technical metadata by adding definitions and classifications to data attributes, such as tables and columns. You'll learn to assign technical ownership by linking technical attributes to contact persons. You'll learn to use classifications to mark data. All these activities, such as categorizing data, will help you to better manage your data.

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/free/) with an active subscription.
* A Microsoft Purview account (see [module 01](../modules/module01.md)).
* A Microsoft Purview catalog with some assets (see [module 02](../modules/module02.md)).

## :dart: Objectives

* Search the catalog by keyword.
* Browse the catalog by source.
* Update an existing asset.
* Perform a bulk edit operation.

## :bookmark_tabs: Table of Contents

| #  | Section | Role |
| --- | --- | --- |
| 1 | [Search Catalog](#1-search-catalog) | Data Reader |
| 2 | [Update an Asset](#2-update-an-asset) | Data Curator |
| 3 | [Browse Assets](#3-browse-assets) | Data Reader |
| 4 | [Bulk Edit](#4-bulk-edit) | Data Curator |

<div align="right"><a href="#module-03---search--browse">↥ back to top</a></div>

## 1. Search Catalog

1. Open the **Microsoft Purview Governance Portal**, navigate to **Data Catalog** > **Home**, type the asterisk character (**\***) into the search bar, and hit **Enter**.

    ![Search Wildcard](../images/module03/03.01-search-wildcard.png)

2. Filter the search results by **Classification** (e.g. **Country/Region**) and click the hyperlinked asset name to view the details (e.g. `QueriesByState`).

    ![Filter by Classification](../images/module03/03.02-search-filter.png)

> :bulb: **Did you know?**
>
> While the **Microsoft Purview Governance Portal** is provided as the default user experience, customers and partners can interface with the underlying platform using the [Microsoft Purview REST API](https://docs.microsoft.com/rest/api/purview/). The openness of the platform enables the possibility of integrating Microsoft Purview with custom user interfaces as well as the ability to perform read/write operations programmatically.

<div align="right"><a href="#module-03---search--browse">↥ back to top</a></div>

## 2. Update an Asset

1. Click **Edit** to modify the asset details.

    ![Edit Asset](../images/module03/03.03-asset-edit.png)

2. Update the **Description** by copying and pasting the sample text below.

    ```text
    This dataset was curated from the Bing search logs (desktop users only) over the period of Jan 1st, 2020 – (Current Month - 1). Only searches that were issued many times by multiple users were included. The dataset includes queries from all over the world that had an intent related to the Coronavirus or Covid-19. In some cases this intent is explicit in the query itself (e.g., “Coronavirus updates Seattle”), in other cases it is implicit , e.g. “Shelter in place”
    ```

    ![Update Description](../images/module03/03.04-asset-description.png)

3. Assign a **Classification** (e.g. `World Cities`) using the drop-down menu.

    ![Update Classification](../images/module03/03.05-asset-classification.png)

4. Navigate to the **Schema** tab and update the **Asset description** for each column using the sample text below.

    > :bulb: **Did you know?**
    >
    > **Classifications** and **Glossary Terms** can be assigned at the asset level (e.g. a Table within a Database) as well as at the schema level (e.g. a Column within a Table Schema).

    ![Update Schema](../images/module03/03.06-asset-schema.png)

    **Date**

    ```text
    Date on which the query was issued.
    ```

    **Query**

    ```text
    The actual search query issued by user(s).
    ```

    **IsImplicitIntent**

    ```text
    True if query did not mention covid or coronavirus or sarsncov2 (e.g, “Shelter in place”). False otherwise.
    ```

    **State**

    ```text
    State from where the query was issued.
    ```

    **Country**

    ```text
    Country from where the query was issued.
    ```

    **PopularityScore**

    ```text
    Value between 1 and 100 inclusive. 1 indicates least popular query on the day/State/Country with Coronavirus intent, and 100 indicates the most popular query for the same geography on the same day.
    ```

5. Navigate to the **Contacts** tab and set someone within your organization to be an **Expert** and an **Owner**. Click **Save**.

    > :bulb: **Did you know?**
    >
    > Assets can be related to two different types of contacts:
    >
    > * **Experts** are often business process or subject matter experts.
    > * Where as **Owners** are often senior executives or business area owners that define governance or business processes over certain data areas.
    >
    > For assets in which you are tagged as a **Contact**, these will appear on the home screen (Data catalog), under **My items**.

    ![Update Contacts](../images/module03/03.07-asset-contacts.png)

6. To see other assets within the same path, navigate to the **Related** tab.

    ![Related Assets](../images/module03/03.08-asset-related.png)

<div align="right"><a href="#module-03---search--browse">↥ back to top</a></div>

## 3. Browse Assets

While the search experience is ideal for keyword based discovery, the Microsoft Purview Governance Portal allows alternate methods of browsing assets (i.e. by collection OR by source type).

1. Open the **Microsoft Purview Governance Portal**, navigate to **Data Catalog** and click **Browse**.

    ![Browse Assets](../images/module03/03.09-home-browse.png)

2. Switch to the **By source type** tab and select a **source** (e.g. `Azure Data Lake Storage Gen2`).

    ![ADLS Gen2](../images/module03/03.10-browse-adls.png)

3. Select an **account** (e.g. `pvlab{randomId}adls`).

    ![ADLS Gen2 Account](../images/module03/03.11-browse-account.png)

4. Select a **container** (e.g. `raw`).

    ![ADLS Gen2 Container](../images/module03/03.12-browse-container.png)

<div align="right"><a href="#module-03---search--browse">↥ back to top</a></div>

## 4. Bulk Edit

Microsoft Purview allows us to perform certain operations (add/replace/remove) against a subset of attributes (Expert, Owner, Term, Classification) in bulk directly within the Microsoft Purview Governance Portal.

1. Open the **Microsoft Purview Governance Portal**, navigate to **Data Catalog** > **Home**, type the asterisk character (**\***) into the search bar, and hit **Enter**.

    ![Search Wildcard](../images/module03/03.01-search-wildcard.png)

2. Hover your mouse over an item in the list to reveal the checkbox on the right-hand side. Select five items and click **View selected**.

    ![View Selected](../images/module03/03.13-bulk-view.png)

3. Click **Bulk edit**.

    ![Bulk Edit](../images/module03/03.14-bulk-edit.png)

4. Set the **Attribute** to `Owner`, set **Operation** to `Add`, select one or more users in your organization, and click **Apply**.

    ![Apply Changes](../images/module03/03.15-bulk-apply.png)

5. Click **Deselect all and close**.

    ![Deselect](../images/module03/03.16-bulk-deselect.png)

<div align="right"><a href="#module-03---search--browse">↥ back to top</a></div>

## :mortar_board: Knowledge Check

[https://aka.ms/purviewlab/q03](https://aka.ms/purviewlab/q03)

1. There are a number of **attributes** that we can use to narrow our search results via the **filter pane**, which of the following is **not** available as a quick filter?

    A ) Asset Type  
    B ) Classification  
    C ) Size  

2. Using the Microsoft Purview Governance Portal (UI), you can edit an asset and manually update an assets **Description**?

    A ) True  
    B ) False  

3. Using the Microsoft Purview Governance Portal (UI), you can edit an asset and manually add and remove **Classifications**?

    A ) True  
    B ) False  

4. Using the Microsoft Purview Governance Portal (UI), you can edit an asset and manually update an assets **Technical Properties** (e.g. qualifiedName, partitionCount, totalSizeBytes, etc)?

    A ) True  
    B ) False  

5. Assets in the catalog can be assigned contacts, which of the following is an **invalid contact type**?

    A ) Expert  
    B ) Owner  
    C ) Reader  

<div align="right"><a href="#module-03---search--browse">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to search, browse, and update assets.

[Continue >](../modules/module04.md)
