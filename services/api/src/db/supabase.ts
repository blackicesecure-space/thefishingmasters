import { createClient, SupabaseClient } from '@supabase/supabase-js';

let client: SupabaseClient | null = null;

/**
 * Returns a singleton Supabase client.
 * Reads SUPABASE_URL and SUPABASE_ANON_KEY from env.
 * Uses anon key by default so RLS policies are enforced.
 * Only uses service role key when SUPABASE_USE_SERVICE_ROLE=true.
 */
export function getSupabase(): SupabaseClient {
  if (client) return client;

  const url = process.env.SUPABASE_URL;
  const useServiceRole = process.env.SUPABASE_USE_SERVICE_ROLE === 'true';
  const key = useServiceRole
    ? (process.env.SUPABASE_SERVICE_ROLE_KEY ?? process.env.SUPABASE_ANON_KEY)
    : (process.env.SUPABASE_ANON_KEY ?? process.env.SUPABASE_SERVICE_ROLE_KEY);

  if (!url || !key) {
    throw new Error(
      'Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY / SUPABASE_ANON_KEY env vars. ' +
      'See .env.example for required configuration.'
    );
  }

  client = createClient(url, key, {
    auth: { persistSession: false },
  });

  return client;
}

// ----- Data Types -----

export interface SpotRow {
  id: string;
  name: string;
  latitude: number;
  longitude: number;
  bundesland: string;
  gewaesser_typ: string;
  fischarten: string[];
  regelung: string;
  angelkarte_preis_tag: number | null;
  avg_crowd_level: number;
  flaeche_ha: number | null;
  max_tiefe_m: number | null;
  strukturen: string[];
  parkplatz: boolean;
  beschreibung: string | null;
  created_at: string;
}

export interface FeedbackInsert {
  user_id?: string;
  spot_id: string;
  session_id?: string;
  success: boolean;
  target_species?: string;
  note?: string;
  crowd_level?: number;
}
