# Module 08 - Monitor

[< Previous Module](../modules/module07.md) - **[Home](../README.md)** - [Next Module >](../modules/module09.md)

## :thinking: Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* An Azure Azure Purview account (see [module 01](../modules/module01.md)).
* Your subscription must have the **Microsoft.Insights** resource provider registered.

## :loudspeaker: Introduction

Azure Purview administrators can use Azure Monitor to track the operational state of an Azure Purview account instance. Metrics are collected to provide data points for you to track potential problems, troubleshoot, and improve the reliability of the Purview platform.

## :dart: Objectives

* View Azure Purview metrics.
* Send Azure Purview diagnostic logs to Azure Storage.

## Table of Contents

1. [Provide a User Access to Azure Purview Metrics](#1-provide-a-user-access-to-azure-purview-metrics)
2. [Visualize Azure Purview Metrics](#2-visualize-azure-purview-metrics)
3. [Send Diagnostic Logs to Azure Storage](#3-send-diagnostic-logs-to-azure-storage)

<div align="right"><a href="#module-08---monitor">↥ back to top</a></div>

## 1. Provide a User Access to Azure Purview Metrics

Metrics can be accessed from the Azure Portal for an Azure Purview account instance. Access to the metrics can be granted via a role assignment.
* The person who created the Purview account automatically gets permissions to view metrics.
* Other individuals can be provided access by adding them to the **Monitoring Reader** role.

1. Sign in to the [Azure portal](https://portal.azure.com), navigate to your **Azure Purview** account (e.g. `pvlab-{randomId}-pv`), select **Access Control** and click **Add role assignment**.

    ![Azure Purview Access Control](../images/module08/08.01-purview-access.png)

2. Filter the list of roles by searching for `Monitoring Reader`, select the **Monitoring Reader** role and then click **Next**.

    ![Add Role Assignment](../images/module08/08.02-access-add.png)

3. Click **Select members**, search for a user within your Azure Active Directory, select that user from the list, and then click **Select**.

    > :bulb: **Did you know?**
    >
    > **Monitoring Reader** role can view all monitoring data but cannot modify any resource or edit any settings related to monitoring resources. This role is appropriate for users in an organization such as Azure Purview administrators.

    ![Assign Role](../images/module08/08.03-access-assign.png)

4. Click **Review + assign** to progress to the final screen, then click **Review + assign** once more to add the role assignment.

    ![Verify Access](../images/module08/08.04-access-verify.png)

<div align="right"><a href="#module-08---monitor">↥ back to top</a></div>

## 2. Visualize Azure Purview Metrics

1. Navigate to your **Azure Purview** account instance and click **Metrics**.

    ![Azure Purview Metrics](../images/module08/08.05-purview-metrics.png)

2. Click to open the **Metric** drop-down menu and select one of the metrics (e.g. `Scan time taken`).

    **Available Metrics**
    | Metric ID  | Metric Name | Metric Description |
    | --- | --- | --- |
    | DataMapCapacityUnits | `Data Map Capacity Units` | Indicates the number of capacity units consumed. |
    | DataMapStorageSize | `Data Map Storage Size` | Indicates the data map storage size. |
    | ScanCancelled | `Scan Cancelled` | Indicates the number of scans cancelled. |
    | ScanCompleted | `Scan Completed` | Indicates the number of scans completed successfully. |
    | ScanFailed | `Scan Failed` | Indicates the number of scans failed. |
    | ScanTimeTaken | `Scan Time Taken` | Indicates the total scan time in seconds. |

    ![Select Metric](../images/module08/08.06-metrics-select.png)

3. Click on the chart type to change the graph to a **Bar chart**.

    ![Metrics Chart Type](../images/module08/08.07-metrics-chart.png)

4. Click on the **time range** to change the duration to **Last 30 Days** and click **Apply**.

    ![Metrics Time Range](../images/module08/08.08-metrics-range.png)

5. Below is an example. Note: The account instance would need some historical scan activity in order to visualize the metric. 

    ![Metrics Graph](../images/module08/08.09-metrics-graph.png)

<div align="right"><a href="#module-08---monitor">↥ back to top</a></div>

## 3. Send Diagnostic Logs to Azure Storage

1. Navigate to your **Azure Purview** account instance, click **Diagnostic settings** and select **Add diagnostic setting**.

    > :bulb: **Did you know?**
    >
    > **Diagnostic settings** can be used to send platform logs and metrics to one or more destinations (Log Analytics Workspace, Storage Account, an Event Hub).

    ![Add Diagnostic Setting](../images/module08/08.14-diagnostic-add.png)

2. Provide the diagnostic setting a name (e.g. `Audit`), select **ScanStatusLogEvent**, select **Archive to a storage account**, select an existing storage account (e.g. `pvlab{randomId}adls`) and click **Save**.

    > :bulb: **Did you know?**
    >
    > **ScanStatusLogEvent** tracks the scan life cycle. A scan operation follows progress through a sequence of states, from Queued, Running and finally a terminal state of Succeeded | Failed | Canceled. An event is logged for each state transition.

    ![Save Diagnostic Setting](../images/module08/08.15-diagnostic-save.png)

3. To test the capture of raw events, trigger a full scan by navigating to **Azure Purview Studio** > **Data map** > **Sources** and click **View details** on an existing source.

    ![Source Details](../images/module08/08.16-sources-details.png)

4. Navigate to the **Scans** tab and click the name of a previously run scan.

    ![Source Scans](../images/module08/08.17-sources-scans.png)

5. Open the **Run scan now** drop-down menu and select **Full Scan**.

    ![Full Scan](../images/module08/08.18-scan-full.png)

6. Monitor the scan status by periodically clicking the **Refresh** button.

    ![Scan Progress](../images/module08/08.19-scan-progress.png)

7. Once the scan is complete, navigate to your storage account within the Azure Portal, select **Storage Explorer**, expand **CONTAINERS** and select **insights-logs-scanstatuslogevent**, navigate down the folder hierarchy until you reach a JSON document (e.g. `PT1H.json`).

    ![Storage Explorer](../images/module08/08.20-storage-explorer.png)

8. Download and open a local copy of the JSON document to see the details (e.g. dataSourceName, dataSourceType, assetsDiscovered, scanTotalRunTimeInSeconds, etc).

    ![Event JSON](../images/module08/08.21-event-json.png)

<div align="right"><a href="#module-08---monitor">↥ back to top</a></div>

## :mortar_board: Knowledge Check

[http://aka.ms/purviewlab/q08](http://aka.ms/purviewlab/q08)

1. Which built-in role is needed to provide users access to **view monitoring data**?

    A ) Purview Data Reader  
    B ) Metrics Reader  
    C ) Monitoring Reader

2. Which of the following is **not** available as an Azure Purview metric?

    A ) ScanCompleted  
    B ) ScanDuration  
    C ) ScanTimeTaken

3. The **ScanStatusLogEvent** schema contains an attribute that indicates the total run time. What is the name of this attribute?

    A ) scanTotalRunTime  
    B ) scanTotalRunTimeInSeconds  
    C ) scanTotalDuration

<div align="right"><a href="#module-08---monitor">↥ back to top</a></div>

## :tada: Summary

This module provided an overview of how to visualize Azure Purview metrics within the Azure Portal and how to capture raw telemetry to an Azure Storage account.

[Continue >](../modules/module09.md)
