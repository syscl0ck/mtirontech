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
            Mountain Iron Technology
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
