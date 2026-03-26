import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        bg: {
          DEFAULT: "#0b1220",
          card: "#10192b",
          hover: "#162035",
        },
        accent: {
          DEFAULT: "#59d0ff",
          dim: "#3a9fd4",
        },
        text: {
          DEFAULT: "#e9f3ff",
          muted: "#9db2cc",
        },
        success: "#77e1a5",
        warning: "#ffd17f",
        error: "#ff9090",
        border: "#1e2d45",
      },
      borderRadius: {
        container: "20px",
        card: "14px",
        input: "10px",
      },
      maxWidth: {
        content: "1080px",
      },
    },
  },
  plugins: [],
};

export default config;
