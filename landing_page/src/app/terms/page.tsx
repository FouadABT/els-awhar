'use client';

import React from 'react';
import { useLanguage } from '../../i18n/LanguageContext';
import { useTheme } from '../../theme/ThemeContext';
import Navbar from '../../components/Navbar';
import Footer from '../../components/Footer';

export default function TermsPage() {
  const { t, isRTL } = useLanguage();
  const { isDark } = useTheme();

  const sections = [
    { key: 'acceptance', ...t.terms.sections.acceptance },
    { key: 'eligibility', ...t.terms.sections.eligibility },
    { key: 'account', ...t.terms.sections.account },
    { key: 'conduct', ...t.terms.sections.conduct },
    { key: 'payments', ...t.terms.sections.payments },
    { key: 'liability', ...t.terms.sections.liability },
    { key: 'changes', ...t.terms.sections.changes },
    { key: 'contact', ...t.terms.sections.contact },
  ];

  return (
    <div className={`min-h-screen flex flex-col ${isRTL ? 'rtl' : 'ltr'} ${isDark ? 'bg-gray-900' : 'bg-gray-50'}`}>
      <Navbar />
      
      <main className="flex-1 pt-24 pb-16">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Header */}
          <div className="text-center mb-12">
            <h1 className={`text-4xl md:text-5xl font-bold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.terms.title}
            </h1>
            <p className={isDark ? 'text-gray-400' : 'text-gray-500'}>{t.terms.lastUpdated}</p>
          </div>

          {/* Intro */}
          <div className={`border-l-4 border-amber-500 p-6 rounded-r-lg mb-8 ${isDark ? 'bg-amber-900/20' : 'bg-amber-50'}`}>
            <p className={`leading-relaxed ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>{t.terms.intro}</p>
          </div>

          {/* Sections */}
          <div className="space-y-8">
            {sections.map((section, index) => (
              <section key={section.key} className={`rounded-xl shadow-sm p-6 md:p-8 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
                <h2 className={`text-xl md:text-2xl font-semibold mb-4 flex items-center gap-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>
                  <span className={`flex items-center justify-center w-8 h-8 rounded-full text-sm font-bold ${isDark ? 'bg-amber-900/50 text-amber-400' : 'bg-amber-100 text-amber-700'}`}>
                    {index + 1}
                  </span>
                  {section.title}
                </h2>
                <p className={`leading-relaxed ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>{section.content}</p>
              </section>
            ))}
          </div>

          {/* Back to home */}
          <div className="mt-12 text-center">
            <a
              href="/"
              className="inline-flex items-center gap-2 text-amber-600 hover:text-amber-700 font-medium transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              Back to Home
            </a>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
