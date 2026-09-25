# Jules CRM

This folder is the foundation for Jules Zaphire, Jr.'s private real estate CRM.

## Architecture
- Public website: GitHub Pages
- CRM: authenticated web application
- Database: PostgreSQL-compatible schema
- Authentication: email/password with per-user roles
- Website leads: secure API endpoint (not browser localStorage)

## Initial modules
- Contacts
- Leads
- Properties
- Transactions
- Activities / notes
- Tasks / follow-ups
- Users and roles
- Financial tracking

The public website must never contain database service-role keys or other secrets.
