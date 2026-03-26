interface Props {
  text?: string;
  size?: "sm" | "md" | "lg";
}

export default function LoadingSpinner({ text, size = "md" }: Props) {
  const sizeClasses = {
    sm: "w-4 h-4 border-2",
    md: "w-6 h-6 border-2",
    lg: "w-10 h-10 border-[3px]",
  };

  return (
    <div className="flex flex-col items-center justify-center gap-3 py-12">
      <div
        className={`${sizeClasses[size]} border-accent/30 border-t-accent rounded-full animate-spin`}
      />
      {text && <p className="text-text-muted text-sm">{text}</p>}
    </div>
  );
}
