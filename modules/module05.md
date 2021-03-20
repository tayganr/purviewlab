# Module 05 - Classifications

[< Previous Module](../modules/module04.md) - **[Home](../README.md)** - [Next Module>](../modules/module06.md)

## Prerequisites

* An Azure account with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).
* An Azure Data Lake Storage Gen2 Account (see [module 02](../modules/module02.md)).

## Table of Contents

1. [Create a Classification](#1-create-a-classification)
2. [Create a Classification Rule (Regular Expression)](#2-create-a-custom-classification-rule-regular-expression)
3. [Create a Scan Rule Set](#3-create-a-scan-rule-set)
4. [Upload Data to an Azure Data Lake Storage Gen2 Account](#4-upload-data-to-an-azure-data-lake-storage-gen2-account)
5. [Scan an Azure Data Lake Storage Gen2 Account](#5-scan-an-azure-data-lake-storage-gen2-account)
6. [Search by Classification](#6-search-by-classification)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## 1. Create a Classification

1. Do A

    ![New Classification](../images/module05/05.01-classifications-new.png)

2. Do B

    ![Create Classification](../images/module05/05.02-classifications-create.png)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## 2. Create a Custom Classification Rule (Regular Expression)

1. Do A

    ![New Classification Rule](../images/module05/05.03-classificationrules-new.png)

2. Do B

    ![Regular Expression Classification Rule](../images/module05/05.04-classificationrules-regex.png)

3. Do C

    ![Pattern Detection](../images/module05/05.05-regex-file.png)

4. Do D

    ![Create Classification Rule](../images/module05/05.06-regex-create.png)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## 3. Create a Scan Rule Set

1. Do A

    ![New Scan Rule Set](../images/module05/05.07-scanruleset-new.png)

2. Do B

    ![Scan Rule Set Name](../images/module05/05.08-scanruleset-create.png)

3. Do C

    ![Scan Rule Set File Type](../images/module05/05.09-scanruleset-filetype.png)

4. Do D

    ![Scan Rule Set Classification](../images/module05/05.10-scanruleset-rules.png)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## 4. Upload Data to an Azure Data Lake Storage Gen2 Account

1. Do A

    ![Open Container](../images/module05/05.11-explorer-container.png)

2. Do B

    ![New Folder](../images/module05/05.12-explorer-folder.png)

3. Do C

    ![Upload File](../images/module05/05.13-explorer-upload.png)

4. Do D

    ![Upload Parquet](../images/module05/05.14-explorer-parquet.png)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## 5. Scan an Azure Data Lake Storage Gen2 Account

1. Do A

    ![New Scan](../images/module05/05.15-sources-newscan.png)

2. Do B

    ![Test Connection](../images/module05/05.16-scan-test.png)

3. Do C

    ![Scope Scan](../images/module05/05.17-scan-scope.png)

4. D

    ![Scan Rule Set Details](../images/module05/05.18-scanruleset-viewdetail.png)

5. E

    ![Verify Scan Rule Set](../images/module05/05.19-scanruleset-verify.png)

6. F

    ![Select Scan Rule Set](../images/module05/05.20-scanruleset-select.png)

7. G

    ![Scan Cadence](../images/module05/05.21-scan-trigger.png)

8. H

    ![Run Scan](../images/module05/05.22-scan-saverun.png)

9. I

    ![Source Details](../images/module05/05.23-source-viewdetails.png)

10. J

    ![Scan Progress](../images/module05/05.24-source-progress.png)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## 6. Search by Classification

1. Do A

    ![Wildcard Search](../images/module05/05.25-search-wildcard.png)

2. Do B

    ![Filter Classification](../images/module05/05.26-search-filter.png)

3. Do C

    ![Asset Details](../images/module05/05.27-asset-details.png)

4. D

    ![Asset Schema](../images/module05/05.28-asset-schema.png)

<div align="right"><a href="#module-05---classifications">↥ back to top</a></div>

## Summary

This module provided an overview of how to create a custom classification, and how to have the classification automatically applied as part of a scan using a custom scan rule set.
