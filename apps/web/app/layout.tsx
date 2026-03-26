import type { Metadata } from "next";
import Link from "next/link";
import { ApolloWrapper } from "./providers";
import "./globals.css";

export const metadata: Metadata = {
  title: "The Fishing Masters – Wo angel ich heute?",
  description:
    "KI-gestützte Angelempfehlungen für Mitteldeutschland. Tägliche Top-3 Spot-Empfehlungen basierend auf Wetter, Mondphase und Beißwahrscheinlichkeit.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="de">
      <body className="min-h-screen">
        <ApolloWrapper>
          <header className="border-b border-border">
            <nav className="max-w-content mx-auto px-4 py-4 flex items-center justify-between">
              <Link href="/" className="text-xl font-bold text-accent">
                The Fishing Masters
              </Link>
              <div className="flex gap-4 text-sm text-text-muted">
                <Link href="/flow" className="hover:text-accent transition-colors">
                  Empfehlung
                </Link>
                <Link href="/spots" className="hover:text-accent transition-colors">
                  Spots
                </Link>
                <Link href="/dashboard" className="hover:text-accent transition-colors">
                  Dashboard
                </Link>
                <Link href="/feedback" className="hover:text-accent transition-colors">
                  Feedback
                </Link>
              </div>
            </nav>
          </header>
          <main className="max-w-content mx-auto px-4 py-8">{children}</main>
          <footer className="border-t border-border mt-16">
            <div className="max-w-content mx-auto px-4 py-6 text-center text-xs text-text-muted">
              The Fishing Masters &copy; {new Date().getFullYear()} – KI-Angel-Empfehlungen für
              Mitteldeutschland
            </div>
          </footer>
        </ApolloWrapper>
      </body>
    </html>
  );
}
