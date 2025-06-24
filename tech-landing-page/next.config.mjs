// /** @type {import('next').NextConfig} */
// const nextConfig = {
//   output: "export",
//   output: "standalone",
// };

const isProd = process.env.NODE_ENV === "production";
/** @type {import('next').NextConfig} */
const config = {
  output: "export",
  basePath: isProd ? "/mtirontech" : "",
  assetPrefix: isProd ? "/mtirontech/" : "",
  images: {
    unoptimized: true, // GitHub Pages does not support Next.js image optimization
  },
};

export default config;
