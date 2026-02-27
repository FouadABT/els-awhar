'use client';

import React from 'react';
import Link from 'next/link';
import { useLanguage } from '../../i18n/LanguageContext';
import { useTheme } from '../../theme/ThemeContext';
import Navbar from '../../components/Navbar';
import Footer from '../../components/Footer';

export default function DeleteAccountPage() {
  const { t, isRTL } = useLanguage();
  const { isDark } = useTheme();

  return (
    <div className={`min-h-screen flex flex-col ${isRTL ? 'rtl' : 'ltr'} ${isDark ? 'bg-gray-900' : 'bg-gray-50'}`}>
      <Navbar />
      
      <main className="flex-1 pt-24 pb-16">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Header */}
          <div className="text-center mb-12">
            <div className={`inline-flex items-center justify-center w-20 h-20 rounded-full mb-6 ${isDark ? 'bg-red-900/30' : 'bg-red-100'}`}>
              <svg className="w-10 h-10 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
              </svg>
            </div>
            <h1 className={`text-4xl md:text-5xl font-bold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.deleteAccount.title}
            </h1>
            <p className={`text-lg max-w-2xl mx-auto ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>
              {t.deleteAccount.subtitle}
            </p>
          </div>

          {/* Warning */}
          <div className={`border-l-4 border-red-500 p-6 rounded-r-lg mb-8 ${isDark ? 'bg-red-900/20' : 'bg-red-50'}`}>
            <div className="flex items-start gap-4">
              <svg className="w-6 h-6 text-red-600 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
              </svg>
              <p className={`font-medium ${isDark ? 'text-red-400' : 'text-red-800'}`}>{t.deleteAccount.warning}</p>
            </div>
          </div>

          {/* Consequences */}
          <section className={`rounded-xl shadow-sm p-6 md:p-8 mb-8 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
            <h2 className={`text-xl md:text-2xl font-semibold mb-6 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.deleteAccount.consequences.title}
            </h2>
            <ul className="space-y-4">
              {t.deleteAccount.consequences.items.map((item, index) => (
                <li key={index} className="flex items-start gap-3">
                  <svg className="w-5 h-5 text-red-500 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                  </svg>
                  <span className={isDark ? 'text-gray-300' : 'text-gray-600'}>{item}</span>
                </li>
              ))}
            </ul>
          </section>

          {/* How to delete */}
          <section className={`rounded-xl shadow-sm p-6 md:p-8 mb-8 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
            <h2 className={`text-xl md:text-2xl font-semibold mb-6 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.deleteAccount.howTo.title}
            </h2>
            <ol className="space-y-4">
              {t.deleteAccount.howTo.steps.map((step, index) => (
                <li key={index} className="flex items-start gap-4">
                  <span className={`flex items-center justify-center w-8 h-8 rounded-full text-sm font-bold flex-shrink-0 ${isDark ? 'bg-amber-900/30 text-amber-500' : 'bg-amber-100 text-amber-700'}`}>
                    {index + 1}
                  </span>
                  <span className={`pt-1 ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>{step}</span>
                </li>
              ))}
            </ol>
          </section>

          {/* Alternative */}
          <section className={`rounded-xl p-6 md:p-8 ${isDark ? 'bg-gradient-to-r from-amber-900/20 to-orange-900/20' : 'bg-gradient-to-r from-amber-50 to-orange-50'}`}>
            <h2 className={`text-xl md:text-2xl font-semibold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.deleteAccount.alternative.title}
            </h2>
            <p className={`mb-6 ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>{t.deleteAccount.alternative.content}</p>
            <Link
              href="/contact"
              className="inline-flex items-center gap-2 px-6 py-3 bg-amber-600 hover:bg-amber-700 text-white font-medium rounded-lg transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
              </svg>
              {t.deleteAccount.alternative.contactButton}
            </Link>
          </section>

          {/* Back to home */}
          <div className="mt-12 text-center">
            <Link
              href="/"
              className="inline-flex items-center gap-2 text-amber-600 hover:text-amber-700 font-medium transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              Back to Home
            </Link>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
