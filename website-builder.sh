#!/bin/bash

# --- Create Project Directory and Subdirectories ---
echo "Creating project directory: tech-landing-page"
mkdir -p tech-landing-page/app/blog/[slug]
mkdir -p tech-landing-page/components
mkdir -p tech-landing-page/lib
mkdir -p tech-landing-page/posts
mkdir -p tech-landing-page/public
cd tech-landing-page

# --- Create Project Configuration Files ---

echo "Creating package.json..."
cat > package.json << 'EOF'
{
  "name": "tech-landing-page",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "react": "^18",
    "react-dom": "^18",
    "next": "14.2.3",
    "gray-matter": "^4.0.3",
    "remark": "^15.0.1",
    "remark-html": "^16.0.1",
    "lucide-react": "^0.379.0"
  },
  "devDependencies": {
    "@tailwindcss/typography": "^0.5.13",
    "postcss": "^8",
    "tailwindcss": "^3.4.1",
    "eslint": "^8",
    "eslint-config-next": "14.2.3"
  }
}
EOF

echo "Creating next.config.mjs..."
cat > next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
    output: 'standalone',
};

export default nextConfig;
EOF

echo "Creating Dockerfile..."
cat > Dockerfile << 'EOF'
# Dockerfile for a Next.js application

# 1. Builder Stage: Build the Next.js app
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and lock files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the Next.js application
# The output will be in the .next directory
RUN npm run build

# 2. Runner Stage: Create the final, smaller image
FROM node:20-alpine AS runner

WORKDIR /app

# Set environment to production
ENV NODE_ENV=production
# Uncomment the following line in case you want to disable telemetry during runtime.
# ENV NEXT_TELEMETRY_DISABLED 1

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# The `posts` directory needs to be copied to the standalone server
COPY --from=builder /app/posts ./posts

# The Next.js server will run on port 3000 by default.
EXPOSE 3000

# Command to run the Next.js server
CMD ["node", "server.js"]
EOF

echo "Creating .dockerignore..."
cat > .dockerignore << 'EOF'
node_modules
.next
.git
Dockerfile
.dockerignore
EOF

echo "Creating tailwind.config.js..."
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      backgroundImage: {
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",
        "gradient-conic":
          "conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))",
      },
      animation: {
        'fade-in-up': 'fadeInUp 1s ease-out forwards',
      },
      keyframes: {
        fadeInUp: {
          '0%': { opacity: '0', transform: 'translateY(20px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
EOF

echo "Creating postcss.config.js..."
cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# --- Create App Directory Files ---

echo "Creating app/globals.css..."
cat > app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply bg-gray-900 text-gray-100;
}
EOF

echo "Creating app/layout.js..."
cat > app/layout.js << 'EOF'
import { Inter } from "next/font/google";
import "./globals.css";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "TechCo - Build Great Things",
  description: "Innovative solutions for the modern web.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en" className="scroll-smooth">
      <body className={inter.className}>
        <div className="relative min-h-screen flex flex-col">
          <Header />
          <main className="flex-grow">
            {children}
          </main>
          <Footer />
        </div>
      </body>
    </html>
  );
}
EOF

echo "Creating app/page.js..."
cat > app/page.js << 'EOF'
import { Code, Layers, Rocket } from 'lucide-react';

const LogoLarge = () => (
  <svg width="150" height="150" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg" className="animate-fade-in-up">
    <path d="M50 0L93.3 25V75L50 100L6.7 75V25L50 0Z" fill="#818cf8"/>
    <path d="M50 15L84.64 32.5V67.5L50 85L15.36 67.5V32.5L50 15Z" fill="#3730a3"/>
    <path d="M50 28L76 41.5V58.5L50 72L24 58.5V41.5L50 28Z" fill="white"/>
  </svg>
);

const InfoPane = ({ icon, title, children, bgColor }) => {
  return (
    <div className={`h-screen flex items-center justify-center ${bgColor} text-white`}>
      <div className="text-center p-8 max-w-4xl">
        <div className="mb-6 inline-block bg-white/10 p-4 rounded-full">
            {icon}
        </div>
        <h2 className="text-4xl md:text-5xl font-bold mb-4">{title}</h2>
        <p className="text-lg md:text-xl text-gray-300">
            {children}
        </p>
      </div>
    </div>
  );
};

export default function HomePage() {
  return (
    <div>
      <section className="h-[calc(100vh-80px)] min-h-[600px] flex flex-col items-center justify-center text-center bg-gray-900 p-6">
        <LogoLarge />
        <h1 
          className="mt-8 text-5xl md:text-7xl font-extrabold text-white animate-fade-in-up"
          style={{ animationDelay: '0.2s' }}
        >
          Build <span className="text-indigo-400">Great</span> Things
        </h1>
        <p 
          className="mt-4 text-lg md:text-xl text-gray-400 max-w-2xl animate-fade-in-up"
          style={{ animationDelay: '0.4s' }}
        >
          We architect and deliver scalable, high-performance solutions that power the future of technology.
        </p>
      </section>

      <InfoPane 
        bgColor="bg-gray-800"
        icon={<Layers size={48} className="text-indigo-300"/>}
        title="Placeholder for Animation 1"
      >
        This is a full-screen section. You can replace this content with your own custom components and animations.
      </InfoPane>
      
      <InfoPane
        bgColor="bg-indigo-900"
        icon={<Rocket size={48} className="text-indigo-300"/>}
        title="Placeholder for Animation 2"
      >
        Each pane can have a unique background and layout.
      </InfoPane>

    </div>
  );
}
EOF

echo "Creating app/about/page.js..."
cat > app/about/page.js << 'EOF'
export default function AboutPage() {
  return (
    <div className="container mx-auto px-6 py-16 text-center">
      <h1 className="text-4xl font-bold mb-4">About Us</h1>
      <p className="max-w-3xl mx-auto text-gray-300">
        This is the about page. Here you can describe your company's mission, vision, and team.
      </p>
    </div>
  );
}
EOF

echo "Creating app/contact/page.js..."
cat > app/contact/page.js << 'EOF'
export default function ContactPage() {
  return (
    <div className="container mx-auto px-6 py-16 text-center">
      <h1 className="text-4xl font-bold mb-4">Contact Us</h1>
      <p className="max-w-3xl mx-auto text-gray-300">
        This is the contact page. You can add a contact form or your contact details here.
      </p>
    </div>
  );
}
EOF

echo "Creating app/blog/page.js..."
cat > app/blog/page.js << 'EOF'
import Link from 'next/link';
import { getSortedPostsData } from '@/lib/posts';

export default function BlogIndexPage() {
  const allPostsData = getSortedPostsData();

  return (
    <div className="container mx-auto px-6 py-12 max-w-4xl">
      <h1 className="text-4xl font-bold mb-8 border-b border-gray-700 pb-4">The Blog</h1>
      <section>
        <ul className="space-y-8">
          {allPostsData.map(({ slug, date, title, excerpt }) => (
            <li key={slug} className="bg-gray-800/50 p-6 rounded-lg hover:bg-gray-800 transition-colors duration-300">
              <Link href={`/blog/${slug}`} className="block">
                <h2 className="text-2xl font-bold text-indigo-300 hover:underline">{title}</h2>
                <small className="text-gray-400 mt-1 block">{date}</small>
                <p className="mt-3 text-gray-300">{excerpt}</p>
              </Link>
            </li>
          ))}
        </ul>
      </section>
    </div>
  );
}
EOF

echo "Creating app/blog/[slug]/page.js..."
cat > "app/blog/[slug]/page.js" << 'EOF'
import { getPostData, getAllPostSlugs } from '@/lib/posts';
import { notFound } from 'next/navigation';

export async function generateStaticParams() {
  const paths = getAllPostSlugs();
  return paths;
}

export async function generateMetadata({ params }) {
  const postData = await getPostData(params.slug).catch(() => null);
  if (!postData) {
    return { title: 'Post Not Found' };
  }
  return {
    title: postData.title,
    description: postData.excerpt,
  };
}

export default async function PostPage({ params }) {
  const postData = await getPostData(params.slug).catch(() => null);

  if (!postData) {
    notFound();
  }

  return (
    <article className="container mx-auto px-6 py-12 max-w-3xl">
      <h1 className="text-4xl font-extrabold mb-2 tracking-tight">{postData.title}</h1>
      <div className="text-gray-400 mb-8">{postData.date}</div>
      <div
        className="prose prose-invert prose-lg max-w-none prose-h2:text-indigo-300 prose-a:text-indigo-400 hover:prose-a:text-indigo-300"
        dangerouslySetInnerHTML={{ __html: postData.contentHtml }}
      />
    </article>
  );
}
EOF

# --- Create Components ---

echo "Creating components/Header.js..."
cat > components/Header.js << 'EOF'
import Link from 'next/link';
import { Sparkles } from 'lucide-react';

const Logo = () => (
  <svg width="40" height="40" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M50 0L93.3 25V75L50 100L6.7 75V25L50 0Z" fill="#818cf8"/>
    <path d="M50 15L84.64 32.5V67.5L50 85L15.36 67.5V32.5L50 15Z" fill="#3730a3"/>
    <path d="M50 28L76 41.5V58.5L50 72L24 58.5V41.5L50 28Z" fill="white"/>
  </svg>
);

export default function Header() {
  const navLinks = [
    { name: 'Home', href: '/' },
    { name: 'About', href: '/about' },
    { name: 'Blog', href: '/blog' },
    { name: 'Contact', href: '/contact' },
  ];

  return (
    <header className="sticky top-0 z-50 bg-gray-900/50 backdrop-blur-lg border-b border-gray-700">
      <div className="container mx-auto px-6 py-4 flex justify-between items-center">
        <Link href="/" className="flex items-center gap-3">
          <Logo />
          <span className="text-xl font-bold text-white hidden sm:block">
            TechCo
          </span>
        </Link>
        <nav className="hidden md:flex items-center gap-6">
          {navLinks.map((link) => (
            <Link key={link.name} href={link.href} className="text-gray-300 hover:text-indigo-400 transition-colors duration-300">
              {link.name}
            </Link>
          ))}
        </nav>
        <div className="flex items-center gap-2 bg-indigo-500/20 text-indigo-300 px-3 py-1 rounded-full text-sm">
          <Sparkles className="w-4 h-4 text-indigo-400" />
          <span>Coming Soon</span>
        </div>
      </div>
    </header>
  );
}
EOF

echo "Creating components/Footer.js..."
cat > components/Footer.js << 'EOF'
export default function Footer() {
  return (
    <footer className="bg-gray-900 border-t border-gray-800">
      <div className="container mx-auto px-6 py-8 text-center text-gray-500">
        <p>&copy; {new Date().getFullYear()} TechCo. All Rights Reserved.</p>
        <p className="mt-2 text-sm">Build Great Things</p>
      </div>
    </footer>
  );
}
EOF

# --- Create Lib and Posts ---

echo "Creating lib/posts.js..."
cat > lib/posts.js << 'EOF'
import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import { remark } from 'remark';
import html from 'remark-html';

const postsDirectory = path.join(process.cwd(), 'posts');

export function getSortedPostsData() {
  const fileNames = fs.readdirSync(postsDirectory);
  const allPostsData = fileNames.map((fileName) => {
    const slug = fileName.replace(/\.md$/, '');
    const fullPath = path.join(postsDirectory, fileName);
    const fileContents = fs.readFileSync(fullPath, 'utf8');
    const matterResult = matter(fileContents);
    return {
      slug,
      ...matterResult.data,
    };
  });
  return allPostsData.sort((a, b) => {
    if (a.date < b.date) {
      return 1;
    } else {
      return -1;
    }
  });
}

export function getAllPostSlugs() {
    const fileNames = fs.readdirSync(postsDirectory);
    return fileNames.map((fileName) => {
        return {
            slug: fileName.replace(/\.md$/, ''),
        };
    });
}

export async function getPostData(slug) {
    const fullPath = path.join(postsDirectory, `${slug}.md`);
    const fileContents = fs.readFileSync(fullPath, 'utf8');
    const matterResult = matter(fileContents);
    const processedContent = await remark()
        .use(html)
        .process(matterResult.content);
    const contentHtml = processedContent.toString();
    return {
        slug,
        contentHtml,
        ...matterResult.data,
    };
}
EOF

echo "Creating posts/first-post.md..."
cat > posts/first-post.md << 'EOF'
---
title: 'Welcome to Our Blog'
date: '2025-06-15'
excerpt: 'Discover our mission, our technology, and our vision for the future of building great things.'
---

This is our very first blog post. Here, we'll share insights from our journey, technical deep-dives, and updates about our products.

## Why We Started

We believe in the power of technology to solve complex problems. Our goal is to create robust, elegant, and efficient software that empowers other creators and businesses.

## What to Expect

* **In-depth Tutorials:** From front-end frameworks to back-end architecture.
* **Company News:** Milestones, new features, and announcements.
* **Industry Thoughts:** Our take on the latest trends in tech.

We're excited to have you here.
EOF

echo "Creating posts/second-post.md..."
cat > posts/second-post.md << 'EOF'
---
title: 'The Power of a Headless CMS'
date: '2025-06-20'
excerpt: 'This post is rendered from a local Markdown file, but the same principles apply to fetching content from a headless CMS.'
---

The structure of this blog is a great example of a core concept in modern web development: **decoupling the content from the presentation**.

Right now, our content lives in local `.md` files inside the `posts/` directory. Our Next.js application reads these files at build time and generates static HTML pages.

### The Next Step: Headless CMS

The next logical step for many applications is to move this content into a **Headless CMS** like Strapi, Contentful, or Sanity.io.

By doing this, non-technical team members can easily write, edit, and manage blog posts without ever needing to touch the codebase. The `lib/posts.js` file would be modified to fetch data from the CMS API instead of the local filesystem.
EOF

# --- Final Instructions ---
echo ""
echo "---"
echo "Project 'tech-landing-page' created successfully!"
echo ""
echo "Next steps:"
echo "1. Run 'npm install' to install dependencies."
echo "2. Run 'npm run dev' to start the development server."
echo ""
