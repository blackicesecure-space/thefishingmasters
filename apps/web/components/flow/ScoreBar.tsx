"use client";

interface Props {
  label: string;
  value: number;
  max: number;
  color: string;
}

export default function ScoreBar({ label, value, max, color }: Props) {
  const pct = Math.min(100, (value / max) * 100);

  return (
    <div className="flex items-center gap-2 text-xs">
      <span className="text-text-muted w-20 text-right shrink-0">{label}</span>
      <div className="flex-1 h-2 bg-bg rounded-full overflow-hidden">
        <div
          className={`h-full rounded-full transition-all ${color}`}
          style={{ width: `${pct}%` }}
        />
      </div>
      <span className="text-text-muted w-8 text-right">
        {value.toFixed(0)}
      </span>
    </div>
  );
}
