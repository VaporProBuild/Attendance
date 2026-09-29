-- Main Street Dental attendance — run this once in Supabase: SQL Editor → New query → Run

create table if not exists settings (
  id int primary key default 1 check (id = 1),
  team_name text not null default 'Main Street Dental',
  skaters_needed int not null default 10
);
insert into settings (id) values (1) on conflict do nothing;

create table if not exists players (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text,
  role text not null default 'regular'
    check (role in ('goalie', 'backup_goalie', 'regular', 'sub')),
  position text,
  created_at timestamptz not null default now()
);

create table if not exists games (
  id uuid primary key default gen_random_uuid(),
  starts_at timestamptz not null,
  opponent text,
  location text
);

create table if not exists rsvps (
  game_id uuid not null references games(id) on delete cascade,
  player_id uuid not null references players(id) on delete cascade,
  status text not null check (status in ('in', 'out', 'maybe')),
  updated_at timestamptz not null default now(),
  primary key (game_id, player_id)
);

-- Anyone with the site link can read and change everything (no logins).
alter table settings enable row level security;
alter table players  enable row level security;
alter table games    enable row level security;
alter table rsvps    enable row level security;

drop policy if exists "open access" on settings;
drop policy if exists "open access" on players;
drop policy if exists "open access" on games;
drop policy if exists "open access" on rsvps;
create policy "open access" on settings for all to anon, authenticated using (true) with check (true);
create policy "open access" on players  for all to anon, authenticated using (true) with check (true);
create policy "open access" on games    for all to anon, authenticated using (true) with check (true);
create policy "open access" on rsvps    for all to anon, authenticated using (true) with check (true);

-- Live updates: everyone's screen refreshes when someone changes something.
alter publication supabase_realtime add table settings, players, games, rsvps;
