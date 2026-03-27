-- 003_zones.sql
-- Vorbereitung für Zonen-Modell: Große Gewässer können in
-- Teilbereiche (Zonen) unterteilt werden, z.B. "Goitzschesee — Nordstrand".
-- Wird aktuell noch nicht befüllt, Schema ist aber bereit.

ALTER TABLE public.spots ADD COLUMN IF NOT EXISTS parent_spot_id UUID REFERENCES public.spots(id);
ALTER TABLE public.spots ADD COLUMN IF NOT EXISTS zone_name TEXT;

CREATE INDEX IF NOT EXISTS idx_spots_parent ON public.spots (parent_spot_id);
