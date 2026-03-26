import Link from "next/link";

export default function HomePage() {
  return (
    <div className="flex flex-col items-center text-center gap-10 py-12">
      {/* Hero */}
      <div className="max-w-2xl">
        <h1 className="text-4xl md:text-5xl font-bold mb-4">
          Wo angel ich <span className="text-accent">heute</span>?
        </h1>
        <p className="text-text-muted text-lg leading-relaxed">
          KI-gestützte Angelempfehlungen für Mitteldeutschland. Basierend auf
          Wetter, Mondphase, Solunar-Daten und 35+ Gewässern in Sachsen-Anhalt,
          Thüringen und Sachsen.
        </p>
      </div>

      {/* CTA */}
      <Link href="/flow" className="btn-primary text-lg px-10 py-4">
        Empfehlung starten
      </Link>

      {/* Feature Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-5 w-full mt-4">
        <div className="card text-left">
          <div className="text-2xl mb-2">🎯</div>
          <h3 className="font-semibold mb-1">Top-3 Spots</h3>
          <p className="text-text-muted text-sm">
            Tägliche Empfehlungen mit transparenter Score-Aufschlüsselung und
            Begründung.
          </p>
        </div>
        <div className="card text-left">
          <div className="text-2xl mb-2">🌙</div>
          <h3 className="font-semibold mb-1">Solunar-Daten</h3>
          <p className="text-text-muted text-sm">
            Mondphasen und beste Beißzeiten für optimales Timing.
          </p>
        </div>
        <div className="card text-left">
          <div className="text-2xl mb-2">🐟</div>
          <h3 className="font-semibold mb-1">16+ Fischarten</h3>
          <p className="text-text-muted text-sm">
            Artspezifische Köder- und Taktik-Empfehlungen – vom Zander bis
            zum Köderfisch.
          </p>
        </div>
      </div>

      {/* Stats */}
      <div className="flex gap-8 text-center mt-4">
        <div>
          <div className="text-3xl font-bold text-accent">35+</div>
          <div className="text-text-muted text-sm">Gewässer</div>
        </div>
        <div>
          <div className="text-3xl font-bold text-accent">3</div>
          <div className="text-text-muted text-sm">Bundesländer</div>
        </div>
        <div>
          <div className="text-3xl font-bold text-accent">16</div>
          <div className="text-text-muted text-sm">Fischarten</div>
        </div>
      </div>
    </div>
  );
}
