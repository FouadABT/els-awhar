'use client';

import React from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { useLanguage } from '../i18n/LanguageContext';
import { useTheme } from '../theme/ThemeContext';

export default function Footer() {
  const { t, isRTL } = useLanguage();
  const { isDark } = useTheme();

  return (
    <footer className={isDark ? 'bg-gray-900 text-white' : 'bg-gray-100 text-gray-900'}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Logo and description */}
          <div className="col-span-1 md:col-span-2">
            <div className="flex items-center gap-3 mb-4">
              <Image
                src="/logo.png"
                alt="Awhar"
                width={48}
                height={48}
                className="rounded-lg"
              />
              <span className="text-2xl font-bold">Awhar</span>
            </div>
            <p className={isDark ? 'text-gray-400' : 'text-gray-600'} style={{ maxWidth: '28rem' }}>
              {t.footer.copyright}
            </p>
          </div>

          {/* Quick links */}
          <div>
            <h3 className="text-lg font-semibold mb-4">Links</h3>
            <ul className="space-y-3">
              <li>
                <Link href="/privacy" className={`transition-colors ${isDark ? 'text-gray-400 hover:text-white' : 'text-gray-600 hover:text-gray-900'}`}>
                  {t.footer.privacy}
                </Link>
              </li>
              <li>
                <Link href="/terms" className={`transition-colors ${isDark ? 'text-gray-400 hover:text-white' : 'text-gray-600 hover:text-gray-900'}`}>
                  {t.footer.terms}
                </Link>
              </li>
              <li>
                <Link href="/contact" className={`transition-colors ${isDark ? 'text-gray-400 hover:text-white' : 'text-gray-600 hover:text-gray-900'}`}>
                  {t.footer.contact}
                </Link>
              </li>
              <li>
                <Link href="/delete-account" className={`transition-colors ${isDark ? 'text-gray-400 hover:text-white' : 'text-gray-600 hover:text-gray-900'}`}>
                  {t.footer.deleteAccount}
                </Link>
              </li>
            </ul>
          </div>

          {/* Download */}
          <div>
            <h3 className="text-lg font-semibold mb-4">{t.nav.download}</h3>
            <div className="space-y-3">
              {/* App Store */}
              <a
                href="#"
                className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-colors ${isDark ? 'bg-gray-800 hover:bg-gray-700 text-white' : 'bg-gray-200 hover:bg-gray-300 text-gray-900'}`}
              >
                <svg className="w-7 h-7" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                </svg>
                <div>
                  <div className={`text-xs ${isDark ? 'text-gray-400' : 'text-gray-500'}`}>{t.hero.downloadOn}</div>
                  <div className="text-sm font-semibold">{t.hero.appStore}</div>
                </div>
              </a>

              {/* Google Play */}
              <a
                href="#"
                className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-colors ${isDark ? 'bg-gray-800 hover:bg-gray-700 text-white' : 'bg-gray-200 hover:bg-gray-300 text-gray-900'}`}
              >
                <svg className="w-7 h-7" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M3.609 1.814L13.792 12 3.61 22.186a.996.996 0 0 1-.61-.92V2.734a1 1 0 0 1 .609-.92zm10.89 10.893l2.302 2.302-10.937 6.333 8.635-8.635zm3.199-3.198l2.807 1.626a1 1 0 0 1 0 1.73l-2.808 1.626L15.206 12l2.492-2.491zM5.864 2.658L16.8 9.991l-2.302 2.302-8.634-8.635z"/>
                </svg>
                <div>
                  <div className={`text-xs ${isDark ? 'text-gray-400' : 'text-gray-500'}`}>{t.hero.getItOn}</div>
                  <div className="text-sm font-semibold">{t.hero.googlePlay}</div>
                </div>
              </a>
            </div>
          </div>
        </div>

        {/* Bottom bar */}
        <div className={`border-t mt-12 pt-8 text-center text-sm ${isDark ? 'border-gray-800 text-gray-500' : 'border-gray-300 text-gray-500'}`}>
          {t.footer.copyright}
        </div>
      </div>
    </footer>
  );
}
