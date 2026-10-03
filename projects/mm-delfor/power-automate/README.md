## Snapshot Validation

The flow validates the latest available snapshot in the Power BI model against a control value stored in a SharePoint List.

The SharePoint List stores the **latest snapshot date that has already been processed and notified**.

This value acts as the control point for the automation and allows the flow to determine whether Power BI contains a new snapshot.

### Comparison Logic

The flow retrieves:

- Latest snapshot from Power BI.
- Current processed snapshot stored in the SharePoint List.

The values are then compared.

If:

    Power BI Snapshot = SharePoint Snapshot

the flow stops without sending a notification.

If:

    Power BI Snapshot > SharePoint Snapshot

the flow continues with the analytical queries and notification process.

After the notification is successfully sent, the SharePoint List is updated with the new Power BI snapshot date.

This creates a simple control mechanism:

    Power BI
    Latest Snapshot
          ↓
       Compare
          ↕
    SharePoint List
    Processed Snapshot
          ↓
    New Snapshot?
       ↓        ↓
      No       Yes
       ↓        ↓
     Stop     Process
                ↓
             Notify
                ↓
        Update SharePoint
