'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { translations, Language, TranslationKey } from './translations';

interface LanguageContextType {
  language: Language;
  setLanguage: (lang: Language) => void;
  t: TranslationKey;
  isRTL: boolean;
}

const LanguageContext = createContext<LanguageContextType | undefined>(undefined);

const RTL_LANGUAGES: Language[] = ['ar'];

export function LanguageProvider({ children }: { children: ReactNode }) {
  const [language, setLanguageState] = useState<Language>('en');
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    // Try to get language from localStorage
    const savedLang = localStorage.getItem('awhar-language') as Language | null;
    if (savedLang && translations[savedLang]) {
      setLanguageState(savedLang);
    } else {
      // Try to detect browser language
      const browserLang = navigator.language.split('-')[0] as Language;
      if (translations[browserLang]) {
        setLanguageState(browserLang);
      }
    }
  }, []);

  useEffect(() => {
    if (mounted) {
      localStorage.setItem('awhar-language', language);
      // Update HTML dir attribute for RTL support
      document.documentElement.dir = RTL_LANGUAGES.includes(language) ? 'rtl' : 'ltr';
      document.documentElement.lang = language;
    }
  }, [language, mounted]);

  const setLanguage = (lang: Language) => {
    setLanguageState(lang);
  };

  const value: LanguageContextType = {
    language,
    setLanguage,
    t: translations[language],
    isRTL: RTL_LANGUAGES.includes(language),
  };

  // Prevent hydration mismatch
  if (!mounted) {
    return (
      <LanguageContext.Provider value={{ ...value, t: translations['en'], isRTL: false }}>
        {children}
      </LanguageContext.Provider>
    );
  }

  return (
    <LanguageContext.Provider value={value}>
      {children}
    </LanguageContext.Provider>
  );
}

export function useLanguage() {
  const context = useContext(LanguageContext);
  if (context === undefined) {
    throw new Error('useLanguage must be used within a LanguageProvider');
  }
  return context;
}

export const languageNames: Record<Language, string> = {
  en: 'English',
  ar: 'العربية',
  fr: 'Français',
  es: 'Español',
};

export const languageFlags: Record<Language, string> = {
  en: 'https://flagcdn.com/w40/gb.png',
  ar: 'https://flagcdn.com/w40/ma.png',
  fr: 'https://flagcdn.com/w40/fr.png',
  es: 'https://flagcdn.com/w40/es.png',
};
