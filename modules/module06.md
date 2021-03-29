# Module 06 - Lineage

[< Previous Module](../modules/module05.md) - **[Home](../README.md)** - [Next Module>](../modules/module07.md)

## :thinking: Prerequisites

* An Azure account with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).
* An Azure Data Lake Storage Gen2 Account (see [module 02](../modules/module02.md)).

## :loudspeaker: Introduction

One of the platform features of Azure Purview is the ability to show the lineage between datasets created by data processes. Systems like Data Factory, Data Share, and Power BI capture the lineage of data as it moves. Custom lineage reporting is also supported via Atlas hooks and REST API.

Lineage in Purview includes datasets and processes. Datasets are also referred to as nodes while processes can be also called edges:

* Dataset (Node): A dataset (structured or unstructured) provided as an input to a process. For example, a SQL Table, Azure blob, and files (such as .csv and .xml), are all considered datasets. In the lineage section of Purview, datasets are represented by rectangular boxes.

* Process (Edge): An activity or transformation performed on a dataset is called a process. For example, ADF Copy activity, Data Share snapshot and so on. In the lineage section of Purview, processes are represented by round-edged boxes.

This document explains the steps required for connecting an Azure Data Factory account with an Azure Purview account to track data lineage.

## Table of Contents

1. [Azure Purview Access Control (Purview Data Source Administrator)](#1-azure-purview-access-control-purview-data-source-administrator)
2. [Create an Azure Data Factory Account](#2-create-an-azure-data-factory-account)
3. [Create an Azure Data Factory Connection in Azure Purview](#3-create-an-azure-data-factory-connection-in-azure-purview)
4. [Copy Data using Azure Data Factory](#4-copy-data-using-azure-data-factory)
5. [View Lineage in Azure Purview](#5-view-lineage-in-azure-purview)

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 1. Azure Purview Access Control (Purview Data Source Administrator)

1. Do A
2. Do B
3. Do C

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 2. Create an Azure Data Factory Account

1. Do A
2. Do B
3. Do C

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 3. Create an Azure Data Factory Connection in Azure Purview

1. Do A
2. Do B
3. Do C

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 4. Copy Data using Azure Data Factory

1. Do A
2. Do B
3. Do C

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## 5. View Lineage in Azure Purview

1. Do A
2. Do B
3. Do C

<div align="right"><a href="#module-06---lineage">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to intergrate Azure Purview with Azure Data Factory and how relationships between assets and ETL activities can be automatically created at run time, allowing us to visually represent data lineage and trace upstream and downstream dependencies.
