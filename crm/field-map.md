# Existing spreadsheet -> CRM field map

The current spreadsheet is transaction-oriented. The CRM separates the person from each deal so one client can have multiple buyer/seller transactions.

| Existing column | CRM destination |
| --- | --- |
| Lead Source | contacts.lead_source / leads.source |
| Client | contacts.first_name + contacts.last_name |
| Buyer/Seller | contacts.contact_type / transactions.side |
| Address | properties |
| Purchase Price / Sale Price | transactions.projected_price |
| % Commission | transactions.commission_percent |
| Potential Company Commission | transactions.potential_company_commission |
| Potential Income | transactions.potential_income |
| Sale Price | transactions.sale_price |
| Actual Commission | transactions.actual_commission |
| Actual Income | transactions.actual_income |
| Locqube Income | transactions.company_income |

Additional CRM fields include contact information, lead stage, assigned user, notes/activity history, follow-up tasks, contract/closing dates, and timestamps.
