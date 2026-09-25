-- Jules CRM initial relational schema
-- Designed for PostgreSQL / Supabase-compatible PostgreSQL.

create extension if not exists pgcrypto;

create table if not exists crm_users (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid unique,
  email text not null unique,
  full_name text,
  role text not null default 'agent' check (role in ('admin','agent','va')),
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists contacts (
  id uuid primary key default gen_random_uuid(),
  first_name text not null,
  last_name text not null,
  email text,
  phone text,
  lead_source text,
  contact_type text check (contact_type in ('Buyer','Seller','Buyer/Seller','Other')),
  status text not null default 'New Lead',
  preferred_contact_method text,
  assigned_to uuid references crm_users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists contacts_email_idx on contacts(lower(email));
create index if not exists contacts_status_idx on contacts(status);

create table if not exists properties (
  id uuid primary key default gen_random_uuid(),
  address1 text,
  address2 text,
  city text,
  state text,
  postal_code text,
  property_type text,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  contact_id uuid not null references contacts(id) on delete cascade,
  lead_type text not null check (lead_type in ('Buyer','Seller','Buyer/Seller','Other')),
  source text,
  campaign text,
  location_interest text,
  price_range text,
  property_type text,
  buyer_preferences text,
  stage text not null default 'New Lead',
  assigned_to uuid references crm_users(id),
  created_at timestamptz not null default now()
);

create table if not exists transactions (
  id uuid primary key default gen_random_uuid(),
  contact_id uuid not null references contacts(id),
  property_id uuid references properties(id),
  side text check (side in ('Buyer','Seller')),
  status text not null default 'Prospect',
  projected_price numeric(14,2),
  commission_percent numeric(6,3),
  potential_company_commission numeric(14,2),
  potential_income numeric(14,2),
  sale_price numeric(14,2),
  actual_commission numeric(14,2),
  actual_income numeric(14,2),
  company_income numeric(14,2),
  contract_date date,
  closing_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  contact_id uuid not null references contacts(id) on delete cascade,
  user_id uuid references crm_users(id),
  activity_type text not null default 'Note',
  body text not null,
  occurred_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  contact_id uuid references contacts(id) on delete cascade,
  assigned_to uuid references crm_users(id),
  title text not null,
  details text,
  due_at timestamptz,
  completed_at timestamptz,
  priority text default 'Normal',
  created_at timestamptz not null default now()
);

-- Public website submissions should reach a server-side API.
-- The API should upsert a contact, create a lead, create a follow-up task,
-- and send Jules a notification. Never expose privileged database keys
-- in the GitHub Pages JavaScript.
