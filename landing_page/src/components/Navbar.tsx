'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { useLanguage } from '../i18n/LanguageContext';
import LanguageSwitcher from './LanguageSwitcher';
import ThemeToggle from './ThemeToggle';

export default function Navbar() {
  const { t, isRTL } = useLanguage();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-gradient-to-r from-amber-600 to-orange-500 shadow-lg">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-3">
            <Image
              src="/logo.png"
              alt="Awhar"
              width={40}
              height={40}
              className="rounded-lg"
            />
            <span className="text-2xl font-bold text-white">Awhar</span>
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center gap-6">
            <Link href="/#features" className="text-white/90 hover:text-white transition-colors">
              {t.nav.features}
            </Link>
            <Link href="/#download" className="text-white/90 hover:text-white transition-colors">
              {t.nav.download}
            </Link>
            <Link href="/contact" className="text-white/90 hover:text-white transition-colors">
              {t.nav.contact}
            </Link>
            <Link
              href="/admin"
              className="px-4 py-2 bg-white/10 hover:bg-white/20 rounded-lg text-white transition-colors"
            >
              {t.nav.admin}
            </Link>
            <ThemeToggle />
            <LanguageSwitcher />
          </div>

          {/* Mobile menu button */}
          <div className="md:hidden flex items-center gap-2">
            <ThemeToggle />
            <LanguageSwitcher />
            <button
              onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
              className="p-2 text-white"
              aria-label="Toggle menu"
            >
              {mobileMenuOpen ? (
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              ) : (
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                </svg>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {mobileMenuOpen && (
        <div className="md:hidden bg-amber-700 border-t border-amber-600">
          <div className="px-4 py-4 space-y-3">
            <Link
              href="/#features"
              className="block text-white/90 hover:text-white py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              {t.nav.features}
            </Link>
            <Link
              href="/#download"
              className="block text-white/90 hover:text-white py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              {t.nav.download}
            </Link>
            <Link
              href="/contact"
              className="block text-white/90 hover:text-white py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              {t.nav.contact}
            </Link>
            <Link
              href="/admin"
              className="block px-4 py-2 bg-white/10 rounded-lg text-white text-center"
              onClick={() => setMobileMenuOpen(false)}
            >
              {t.nav.admin}
            </Link>
          </div>
        </div>
      )}
    </nav>
  );
}
