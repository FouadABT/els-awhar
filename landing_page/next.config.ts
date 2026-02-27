import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Enable static export for Serverpod hosting
  output: "export",
  
  // Generate trailing slashes: /about/ instead of /about
  trailingSlash: true,
  
  // Required for static export - disable image optimization
  images: {
    unoptimized: true,
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'flagcdn.com',
        pathname: '/w40/**',
      },
    ],
  },
  
  // React compiler for performance
  reactCompiler: true,
};

export default nextConfig;
