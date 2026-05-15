-- Enable UUID extension
create extension if not exists "uuid-ossp";

create table if not exists public.automations (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  trigger_type text not null check (trigger_type in (
    'comment_post_reels',
    'direct_message_received',
    'keyword_received',
    'first_user_message',
    'step_response'
  )),
  keyword text,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.automation_steps (
  id uuid primary key default uuid_generate_v4(),
  automation_id uuid not null references public.automations(id) on delete cascade,
  step_name text not null,
  expected_keywords text[] not null default '{}',
  response_text text not null,
  next_step_id uuid references public.automation_steps(id) on delete set null,
  fallback_response text,
  order_position int not null default 1,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.leads (
  id uuid primary key default uuid_generate_v4(),
  instagram_user_id text not null unique,
  username text,
  full_name text,
  current_step_id uuid references public.automation_steps(id) on delete set null,
  automation_id uuid references public.automations(id) on delete set null,
  status text not null default 'active' check (status in ('active','paused','closed')),
  whatsapp text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.messages (
  id uuid primary key default uuid_generate_v4(),
  lead_id uuid not null references public.leads(id) on delete cascade,
  direction text not null check (direction in ('incoming','outgoing')),
  message_text text not null,
  instagram_message_id text,
  created_at timestamptz not null default now()
);

create index if not exists idx_automations_trigger on public.automations(trigger_type, is_active);
create index if not exists idx_steps_automation on public.automation_steps(automation_id, order_position);
create index if not exists idx_leads_current_step on public.leads(current_step_id);
create index if not exists idx_messages_lead on public.messages(lead_id, created_at desc);

create or replace function public.touch_leads_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_leads_updated_at on public.leads;
create trigger trg_leads_updated_at
before update on public.leads
for each row execute function public.touch_leads_updated_at();

alter table public.automations enable row level security;
alter table public.automation_steps enable row level security;
alter table public.leads enable row level security;
alter table public.messages enable row level security;

-- Example admin-only policies with Supabase Auth
create policy "admin full access automations" on public.automations
for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "admin full access automation_steps" on public.automation_steps
for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "admin full access leads" on public.leads
for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

create policy "admin full access messages" on public.messages
for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
