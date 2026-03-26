-- ============================================================
-- The Fishing Masters – MVP Database Schema
-- ============================================================
-- Supabase (PostgreSQL) – erweitert um weather_cache,
-- predictions, feedback und profiles Tabellen.
-- ============================================================

create extension if not exists "pgcrypto";

-- ============================================================
-- 1. SPOTS – Angelstellen
-- ============================================================
create table if not exists public.spots (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  latitude decimal(9,6) not null,
  longitude decimal(9,6) not null,
  bundesland text not null,
  gewaesser_typ text not null,        -- See, Fluss, Teich, Kanal, Talsperre
  fischarten jsonb not null default '[]'::jsonb,
  regelung text not null default '',
  angelkarte_preis_tag decimal(5,2),
  schonzeiten jsonb,
  catch_history jsonb,
  avg_crowd_level integer default 0,   -- 0-5 Skala
  flaeche_ha decimal(8,2),
  max_tiefe_m decimal(5,1),
  strukturen jsonb default '[]'::jsonb, -- z.B. ["Schilf","Kraut","Steg"]
  parkplatz boolean default false,
  barrierefrei boolean default false,
  beschreibung text,
  source_file text,                    -- Herkunft (z.B. LAV PDF Name)
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_spots_bundesland on public.spots (bundesland);
create index if not exists idx_spots_geotype on public.spots (gewaesser_typ);
create index if not exists idx_spots_location on public.spots (latitude, longitude);

-- ============================================================
-- 2. PROFILES – Benutzerprofile (erweitert Supabase Auth)
-- ============================================================
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  preferred_species jsonb default '[]'::jsonb,
  home_latitude decimal(9,6),
  home_longitude decimal(9,6),
  bundesland text,
  created_at timestamptz not null default now()
);

-- ============================================================
-- 3. USER_SESSIONS – Empfehlungs-Sessions
-- ============================================================
create table if not exists public.user_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  spot_id uuid references public.spots(id) on delete set null,
  target_species text,
  weather_snapshot jsonb,
  lunar_snapshot jsonb,
  prediction_score numeric(5,2),
  score_breakdown jsonb,               -- {bite: 40, quality: 25, ...}
  outcome text,                        -- 'success' | 'failure' | null
  created_at timestamptz not null default now()
);

create index if not exists idx_user_sessions_user on public.user_sessions (user_id);
create index if not exists idx_user_sessions_spot on public.user_sessions (spot_id);
create index if not exists idx_user_sessions_created on public.user_sessions (created_at desc);

-- ============================================================
-- 4. FEEDBACK – Detailliertes Nutzer-Feedback
-- ============================================================
create table if not exists public.feedback (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  spot_id uuid not null references public.spots(id) on delete cascade,
  session_id uuid references public.user_sessions(id) on delete set null,
  success boolean not null,
  target_species text,
  fish_caught text,                    -- Was tatsaechlich gefangen wurde
  lure_used text,                      -- Koeder
  note text,
  crowd_level integer check (crowd_level between 0 and 5),
  created_at timestamptz not null default now()
);

create index if not exists idx_feedback_spot on public.feedback (spot_id);
create index if not exists idx_feedback_user on public.feedback (user_id);
create index if not exists idx_feedback_created on public.feedback (created_at desc);

-- ============================================================
-- 5. WEATHER_CACHE – Wetter-Daten Cache
-- ============================================================
create table if not exists public.weather_cache (
  id uuid primary key default gen_random_uuid(),
  latitude decimal(9,6) not null,
  longitude decimal(9,6) not null,
  temp_celsius decimal(4,1),
  wind_speed_kmh decimal(5,1),
  wind_direction integer,              -- Grad (0-360)
  pressure_hpa decimal(6,1),
  cloud_cover integer,                 -- Prozent (0-100)
  precipitation decimal(5,2),          -- mm
  humidity integer,                    -- Prozent (0-100)
  description text,
  icon text,
  fetched_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '15 minutes')
);

create index if not exists idx_weather_cache_location on public.weather_cache (latitude, longitude);
create index if not exists idx_weather_cache_expires on public.weather_cache (expires_at);

-- ============================================================
-- 6. PREDICTIONS – Vorhersage-Log
-- ============================================================
create table if not exists public.predictions (
  id uuid primary key default gen_random_uuid(),
  session_id uuid references public.user_sessions(id) on delete cascade,
  spot_id uuid not null references public.spots(id) on delete cascade,
  model_version text not null,
  bite_probability decimal(5,2) not null,
  confidence decimal(4,3),
  features_used jsonb,                 -- Input-Features fuer Transparenz
  score_breakdown jsonb,               -- Detaillierte Score-Aufschluesselung
  rank integer,                        -- Position im Top-3 Ranking
  created_at timestamptz not null default now()
);

create index if not exists idx_predictions_session on public.predictions (session_id);
create index if not exists idx_predictions_spot on public.predictions (spot_id);

-- ============================================================
-- 7. Row Level Security (RLS) Policies
-- ============================================================

-- Spots: Oeffentlich lesbar
alter table public.spots enable row level security;
create policy "Spots sind oeffentlich lesbar"
  on public.spots for select using (true);

-- Profiles: Nur eigenes Profil
alter table public.profiles enable row level security;
create policy "User sieht eigenes Profil"
  on public.profiles for select using (auth.uid() = id);
create policy "User aktualisiert eigenes Profil"
  on public.profiles for update using (auth.uid() = id);
create policy "User erstellt eigenes Profil"
  on public.profiles for insert with check (auth.uid() = id);

-- Feedback: Eigenes Feedback schreiben, alle lesen
alter table public.feedback enable row level security;
create policy "Feedback ist oeffentlich lesbar"
  on public.feedback for select using (true);
create policy "User erstellt eigenes Feedback"
  on public.feedback for insert with check (auth.uid() = user_id);

-- User Sessions: Nur eigene
alter table public.user_sessions enable row level security;
create policy "User sieht eigene Sessions"
  on public.user_sessions for select using (auth.uid() = user_id);
create policy "User erstellt eigene Sessions"
  on public.user_sessions for insert with check (auth.uid() = user_id);

-- Predictions: Ueber Session verknuepft
alter table public.predictions enable row level security;
create policy "Predictions sind oeffentlich lesbar"
  on public.predictions for select using (true);

-- Weather Cache: Oeffentlich lesbar, nur Service schreibt
alter table public.weather_cache enable row level security;
create policy "Weather Cache ist oeffentlich lesbar"
  on public.weather_cache for select using (true);

-- ============================================================
-- 8. Updated_at Trigger
-- ============================================================
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger spots_updated_at
  before update on public.spots
  for each row execute function public.set_updated_at();
