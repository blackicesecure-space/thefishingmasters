"use client";

import { useQuery } from "@apollo/client";
import { DASHBOARD_QUERY, SPOTS_QUERY } from "@/lib/graphql/queries";
import Link from "next/link";

interface FeedbackEntry {
  id: string;
  spotId: string;
  success: boolean;
  note: string | null;
  createdAt: string;
}

export default function DashboardPage() {
  const { data, loading, error } = useQuery(DASHBOARD_QUERY);
  const { data: spotsData } = useQuery(SPOTS_QUERY);

  const spotMap = new Map<string, string>();
  spotsData?.spots?.forEach((s: { id: string; name: string }) => {
    spotMap.set(s.id, s.name);
  });

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="text-text-muted">Lade Dashboard...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="card text-center py-12">
        <p className="text-error mb-4">Fehler: {error.message}</p>
      </div>
    );
  }

  const stats = data?.dashboard;
  if (!stats) return null;

  return (
    <div className="max-w-3xl mx-auto">
      <h1 className="text-2xl font-bold mb-2">Dashboard</h1>
      <p className="text-text-muted text-sm mb-6">
        Deine Angelstatistiken auf einen Blick
      </p>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-8">
        <div className="card text-center">
          <div className="text-3xl font-bold text-accent">{stats.totalSessions}</div>
          <div className="text-xs text-text-muted mt-1">Angeltrips</div>
        </div>
        <div className="card text-center">
          <div className="text-3xl font-bold text-success">{stats.successCount}</div>
          <div className="text-xs text-text-muted mt-1">Erfolge</div>
        </div>
        <div className="card text-center">
          <div className="text-3xl font-bold text-error">{stats.failCount}</div>
          <div className="text-xs text-text-muted mt-1">Schneider</div>
        </div>
        <div className="card text-center">
          <div className="text-3xl font-bold text-warning">{stats.hitRate}%</div>
          <div className="text-xs text-text-muted mt-1">Trefferquote</div>
        </div>
      </div>

      {/* Hit Rate Bar */}
      {stats.totalSessions > 0 && (
        <div className="card mb-8">
          <h3 className="text-sm text-text-muted mb-3">Erfolgsquote</h3>
          <div className="w-full bg-bg rounded-full h-4 overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-success to-accent rounded-full transition-all"
              style={{ width: `${stats.hitRate}%` }}
            />
          </div>
          <div className="flex justify-between text-xs text-text-muted mt-1">
            <span>{stats.successCount} Erfolge</span>
            <span>{stats.failCount} Schneider</span>
          </div>
        </div>
      )}

      {/* Recent Feedback */}
      <div className="card">
        <h3 className="text-sm text-text-muted mb-4">Letzte Feedback-Einträge</h3>
        {stats.recentFeedback.length === 0 ? (
          <div className="text-center py-8">
            <p className="text-text-muted mb-4">
              Noch kein Feedback vorhanden.
            </p>
            <Link href="/feedback" className="btn-primary">
              Erstes Feedback geben
            </Link>
          </div>
        ) : (
          <div className="space-y-3">
            {stats.recentFeedback.map((entry: FeedbackEntry) => (
              <div
                key={entry.id}
                className="flex items-center gap-3 p-3 rounded-input bg-bg border border-border"
              >
                <div
                  className={`w-8 h-8 rounded-full flex items-center justify-center text-sm ${
                    entry.success
                      ? "bg-success/20 text-success"
                      : "bg-error/20 text-error"
                  }`}
                >
                  {entry.success ? "✓" : "✗"}
                </div>
                <div className="flex-1 min-w-0">
                  <div className="text-sm font-medium truncate">
                    {spotMap.get(entry.spotId) ?? "Unbekannter Spot"}
                  </div>
                  {entry.note && (
                    <div className="text-xs text-text-muted truncate">
                      {entry.note}
                    </div>
                  )}
                </div>
                <div className="text-xs text-text-muted whitespace-nowrap">
                  {new Date(entry.createdAt).toLocaleDateString("de-DE", {
                    day: "2-digit",
                    month: "2-digit",
                  })}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Quick Actions */}
      <div className="flex gap-3 mt-6">
        <Link href="/flow" className="btn-primary flex-1 text-center">
          Neue Empfehlung
        </Link>
        <Link href="/feedback" className="btn-secondary flex-1 text-center">
          Feedback geben
        </Link>
      </div>
    </div>
  );
}
