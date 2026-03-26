/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  async rewrites() {
    return [
      {
        source: '/api/graphql',
        destination: process.env.GRAPHQL_BACKEND_URL ?? 'http://api:4000',
      },
    ];
  },
};

export default nextConfig;
