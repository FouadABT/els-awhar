'use client';

import React, { useState, useRef, useEffect } from 'react';
import Image from 'next/image';
import { useLanguage, languageNames, languageFlags } from '../i18n/LanguageContext';
import { Language } from '../i18n/translations';

export default function LanguageSwitcher() {
  const { language, setLanguage, isRTL } = useLanguage();
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const languages: Language[] = ['en', 'ar', 'fr', 'es'];

  return (
    <div className="relative" ref={dropdownRef}>
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="flex items-center gap-2 px-3 py-2 rounded-lg bg-white/10 hover:bg-white/20 transition-colors text-white text-sm font-medium"
        aria-label="Select language"
      >
        <Image
          src={languageFlags[language]}
          alt={languageNames[language]}
          width={24}
          height={18}
          className="rounded-sm"
        />
        <span className="hidden sm:inline">{languageNames[language]}</span>
        <svg
          className={`w-4 h-4 transition-transform ${isOpen ? 'rotate-180' : ''}`}
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
        </svg>
      </button>

      {isOpen && (
        <div
          className={`absolute top-full mt-2 ${isRTL ? 'left-0' : 'right-0'} bg-white rounded-lg shadow-xl py-2 min-w-[160px] z-50`}
        >
          {languages.map((lang) => (
            <button
              key={lang}
              onClick={() => {
                setLanguage(lang);
                setIsOpen(false);
              }}
              className={`w-full flex items-center gap-3 px-4 py-2.5 text-gray-700 hover:bg-gray-100 transition-colors ${
                language === lang ? 'bg-amber-50 text-amber-700' : ''
              }`}
            >
              <Image
                src={languageFlags[lang]}
                alt={languageNames[lang]}
                width={28}
                height={21}
                className="rounded-sm"
              />
              <span className="font-medium">{languageNames[lang]}</span>
              {language === lang && (
                <svg className="w-4 h-4 ml-auto text-amber-600" fill="currentColor" viewBox="0 0 20 20">
                  <path
                    fillRule="evenodd"
                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                    clipRule="evenodd"
                  />
                </svg>
              )}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
