'use client';

import React, { useState } from 'react';
import { useLanguage } from '../../i18n/LanguageContext';
import { useTheme } from '../../theme/ThemeContext';
import Navbar from '../../components/Navbar';
import Footer from '../../components/Footer';

export default function ContactPage() {
  const { t, isRTL } = useLanguage();
  const { isDark } = useTheme();
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  });
  const [status, setStatus] = useState<'idle' | 'sending' | 'success' | 'error'>('idle');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setStatus('sending');

    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        setStatus('success');
        setFormData({ name: '', email: '', subject: '', message: '' });
      } else {
        setStatus('error');
      }
    } catch (err) {
      setStatus('error');
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData(prev => ({ ...prev, [e.target.name]: e.target.value }));
  };

  return (
    <div className={`min-h-screen flex flex-col ${isRTL ? 'rtl' : 'ltr'} ${isDark ? 'bg-gray-900' : 'bg-gray-50'}`}>
      <Navbar />
      
      <main className="flex-1 pt-24 pb-16">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Header */}
          <div className="text-center mb-12">
            <h1 className={`text-4xl md:text-5xl font-bold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.contact.title}
            </h1>
            <p className={`text-lg max-w-2xl mx-auto ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>
              {t.contact.subtitle}
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-8">
            {/* Contact Form */}
            <div className="md:col-span-2">
              <div className={`rounded-xl shadow-sm p-6 md:p-8 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
                {status === 'success' && (
                  <div className={`px-4 py-3 rounded-lg mb-6 flex items-center gap-3 ${isDark ? 'bg-green-900/30 border border-green-700 text-green-400' : 'bg-green-50 border border-green-200 text-green-800'}`}>
                    <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                    </svg>
                    {t.contact.success}
                  </div>
                )}

                {status === 'error' && (
                  <div className={`px-4 py-3 rounded-lg mb-6 flex items-center gap-3 ${isDark ? 'bg-red-900/30 border border-red-700 text-red-400' : 'bg-red-50 border border-red-200 text-red-800'}`}>
                    <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                    </svg>
                    {t.contact.error}
                  </div>
                )}

                <form onSubmit={handleSubmit} className="space-y-6">
                  <div className="grid md:grid-cols-2 gap-6">
                    <div>
                      <label htmlFor="name" className={`block text-sm font-medium mb-2 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                        {t.contact.form.name}
                      </label>
                      <input
                        type="text"
                        id="name"
                        name="name"
                        value={formData.name}
                        onChange={handleChange}
                        required
                        className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition-colors ${isDark ? 'bg-gray-700 border-gray-600 text-white placeholder-gray-400' : 'bg-gray-50 border-gray-300 text-gray-900 placeholder-gray-400'}`}
                        placeholder={t.contact.form.name}
                      />
                    </div>
                    <div>
                      <label htmlFor="email" className={`block text-sm font-medium mb-2 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                        {t.contact.form.email}
                      </label>
                      <input
                        type="email"
                        id="email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        required
                        className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition-colors ${isDark ? 'bg-gray-700 border-gray-600 text-white placeholder-gray-400' : 'bg-gray-50 border-gray-300 text-gray-900 placeholder-gray-400'}`}
                        placeholder={t.contact.form.email}
                      />
                    </div>
                  </div>

                  <div>
                    <label htmlFor="subject" className={`block text-sm font-medium mb-2 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                      {t.contact.form.subject}
                    </label>
                    <input
                      type="text"
                      id="subject"
                      name="subject"
                      value={formData.subject}
                      onChange={handleChange}
                      required
                      className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition-colors ${isDark ? 'bg-gray-700 border-gray-600 text-white placeholder-gray-400' : 'bg-gray-50 border-gray-300 text-gray-900 placeholder-gray-400'}`}
                      placeholder={t.contact.form.subject}
                    />
                  </div>

                  <div>
                    <label htmlFor="message" className={`block text-sm font-medium mb-2 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                      {t.contact.form.message}
                    </label>
                    <textarea
                      id="message"
                      name="message"
                      value={formData.message}
                      onChange={handleChange}
                      required
                      rows={6}
                      className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-transparent transition-colors resize-none ${isDark ? 'bg-gray-700 border-gray-600 text-white placeholder-gray-400' : 'bg-gray-50 border-gray-300 text-gray-900 placeholder-gray-400'}`}
                      placeholder={t.contact.form.message}
                    />
                  </div>

                  <button
                    type="submit"
                    disabled={status === 'sending'}
                    className="w-full md:w-auto px-8 py-3 bg-amber-600 hover:bg-amber-700 disabled:bg-amber-400 text-white font-medium rounded-lg transition-colors flex items-center justify-center gap-2"
                  >
                    {status === 'sending' ? (
                      <>
                        <svg className="animate-spin w-5 h-5" fill="none" viewBox="0 0 24 24">
                          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                        </svg>
                        {t.contact.form.sending}
                      </>
                    ) : (
                      <>
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                        </svg>
                        {t.contact.form.submit}
                      </>
                    )}
                  </button>
                </form>
              </div>
            </div>

            {/* Contact Info */}
            <div>
              <div className={`rounded-xl shadow-sm p-6 md:p-8 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
                <h2 className={`text-xl font-semibold mb-6 ${isDark ? 'text-white' : 'text-gray-900'}`}>
                  {t.contact.info.title}
                </h2>

                <div className="space-y-6">
                  {/* Address */}
                  <div className="flex items-start gap-4">
                    <div className={`flex items-center justify-center w-10 h-10 rounded-lg flex-shrink-0 ${isDark ? 'bg-amber-900/30' : 'bg-amber-100'}`}>
                      <svg className="w-5 h-5 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                      </svg>
                    </div>
                    <div>
                      <h3 className={`font-medium ${isDark ? 'text-white' : 'text-gray-900'}`}>{t.contact.info.address}</h3>
                      <p className={isDark ? 'text-gray-400' : 'text-gray-600'}>{t.contact.info.addressValue}</p>
                    </div>
                  </div>

                  {/* Hours */}
                  <div className="flex items-start gap-4">
                    <div className={`flex items-center justify-center w-10 h-10 rounded-lg flex-shrink-0 ${isDark ? 'bg-amber-900/30' : 'bg-amber-100'}`}>
                      <svg className="w-5 h-5 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </div>
                    <div>
                      <h3 className={`font-medium ${isDark ? 'text-white' : 'text-gray-900'}`}>{t.contact.info.hours}</h3>
                      <p className={isDark ? 'text-gray-400' : 'text-gray-600'}>{t.contact.info.hoursValue}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
