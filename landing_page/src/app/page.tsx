'use client';

import Image from 'next/image';
import { useLanguage } from '../i18n/LanguageContext';
import { useTheme } from '../theme/ThemeContext';
import Navbar from '../components/Navbar';
import Footer from '../components/Footer';

export default function Home() {
  const { t, isRTL } = useLanguage();
  const { isDark } = useTheme();

  return (
    <div className={`min-h-screen ${isRTL ? 'rtl' : 'ltr'} ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <Navbar />

      {/* Hero Section */}
      <section className="bg-gradient-to-br from-amber-500 via-amber-600 to-orange-600 pt-24 pb-20">
        <div className="container mx-auto px-6 py-16">
          <div className="flex flex-col lg:flex-row items-center gap-12">
            {/* Text Content */}
            <div className="flex-1 text-center lg:text-start">
              <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6">
                {t.hero.title}
                <br />
                <span className="text-amber-200">{t.hero.titleHighlight}</span>
              </h1>
              <p className="text-lg md:text-xl text-white/90 max-w-xl mx-auto lg:mx-0 mb-10">
                {t.hero.subtitle}
              </p>
              
              {/* App Store Buttons with Coming Soon badges */}
              <div id="download" className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
                <div className="relative">
                  <a 
                    href="#" 
                    className="inline-flex items-center gap-3 px-6 py-3 bg-black rounded-xl text-white hover:bg-gray-900 transition shadow-lg opacity-80 cursor-not-allowed"
                  >
                    <svg className="w-8 h-8" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                    </svg>
                    <div className={`${isRTL ? 'text-right' : 'text-left'}`}>
                      <div className="text-xs text-gray-400">{t.hero.downloadOn}</div>
                      <div className="text-lg font-semibold">{t.hero.appStore}</div>
                    </div>
                  </a>
                  <span className="absolute -top-2 -right-2 bg-amber-400 text-amber-900 text-xs font-bold px-2 py-1 rounded-full shadow-lg">
                    Soon
                  </span>
                </div>
                <div className="relative">
                  <a 
                    href="#" 
                    className="inline-flex items-center gap-3 px-6 py-3 bg-black rounded-xl text-white hover:bg-gray-900 transition shadow-lg opacity-80 cursor-not-allowed"
                  >
                    <svg className="w-8 h-8" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.53,12.9 20.18,13.18L17.89,14.5L15.39,12L17.89,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z"/>
                    </svg>
                    <div className={`${isRTL ? 'text-right' : 'text-left'}`}>
                      <div className="text-xs text-gray-400">{t.hero.getItOn}</div>
                      <div className="text-lg font-semibold">{t.hero.googlePlay}</div>
                    </div>
                  </a>
                  <span className="absolute -top-2 -right-2 bg-amber-400 text-amber-900 text-xs font-bold px-2 py-1 rounded-full shadow-lg">
                    Soon
                  </span>
                </div>
              </div>
            </div>

            {/* Phone Mockup with actual screenshot */}
            <div className="flex-1 flex justify-center">
              <div className="relative">
                <Image
                  src="/hero-app.png"
                  alt="Awhar App Screenshot"
                  width={300}
                  height={600}
                  className="rounded-3xl shadow-2xl"
                  priority
                />
                {/* Decorative elements */}
                <div className="absolute -top-4 -right-4 w-24 h-24 bg-white/10 rounded-full blur-xl" />
                <div className="absolute -bottom-8 -left-8 w-32 h-32 bg-orange-400/20 rounded-full blur-2xl" />
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* For Clients Section */}
      <section id="clients" className={`py-20 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
        <div className="container mx-auto px-6">
          <div className="flex flex-col lg:flex-row items-center gap-12">
            <div className="flex-1">
              <div className={`inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 ${isDark ? 'bg-blue-900/50' : 'bg-blue-100'}`}>
                <svg className="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
                <span className={`font-semibold ${isDark ? 'text-blue-300' : 'text-blue-700'}`}>For Clients</span>
              </div>
              <h2 className={`text-3xl md:text-4xl font-bold mb-6 ${isDark ? 'text-white' : 'text-gray-900'}`}>
                Get Things Done<br />
                <span className="text-blue-600">Without the Hassle</span>
              </h2>
              <p className={`text-lg mb-8 ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>
                Need a ride? Package delivered? Something picked up from the store? Just post your request and let verified drivers come to you.
              </p>
              <ul className="space-y-4">
                {[
                  'Post any service request in seconds',
                  'Get instant quotes from nearby drivers',
                  'Track your delivery in real-time',
                  'Chat directly with your driver',
                  'Pay securely through the app',
                ].map((item, i) => (
                  <li key={i} className="flex items-center gap-3">
                    <div className="w-6 h-6 rounded-full bg-blue-100 flex items-center justify-center">
                      <svg className="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                      </svg>
                    </div>
                    <span className={isDark ? 'text-gray-300' : 'text-gray-700'}>{item}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="flex-1 flex justify-center">
              <div className={`w-full max-w-md p-8 rounded-3xl ${isDark ? 'bg-gray-700' : 'bg-gradient-to-br from-blue-50 to-blue-100'}`}>
                <div className="text-center">
                  <div className={`w-20 h-20 rounded-2xl mx-auto mb-6 flex items-center justify-center ${isDark ? 'bg-blue-900/50' : 'bg-blue-200'}`}>
                    <svg className="w-10 h-10 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                    </svg>
                  </div>
                  <h3 className={`text-xl font-bold mb-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>Easy to Use</h3>
                  <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>
                    Create a request in under 30 seconds. Our smart system matches you with the best driver for your needs.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* For Drivers Section */}
      <section id="drivers" className={`py-20 ${isDark ? 'bg-gray-900' : 'bg-amber-50'}`}>
        <div className="container mx-auto px-6">
          <div className="flex flex-col lg:flex-row-reverse items-center gap-12">
            <div className="flex-1">
              <div className={`inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 ${isDark ? 'bg-amber-900/50' : 'bg-amber-100'}`}>
                <svg className="w-5 h-5 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                </svg>
                <span className={`font-semibold ${isDark ? 'text-amber-300' : 'text-amber-700'}`}>For Drivers</span>
              </div>
              <h2 className={`text-3xl md:text-4xl font-bold mb-6 ${isDark ? 'text-white' : 'text-gray-900'}`}>
                Turn Your Vehicle Into<br />
                <span className="text-amber-600">Your Business</span>
              </h2>
              <p className={`text-lg mb-8 ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>
                Stop wasting time in WhatsApp groups. Get job notifications directly on your phone, accept with one tap, and start earning.
              </p>
              <ul className="space-y-4">
                {[
                  'Receive job alerts for your area',
                  'Set your own availability schedule',
                  'Fair, transparent pricing',
                  'Track all your earnings in one place',
                  'Build your reputation with reviews',
                ].map((item, i) => (
                  <li key={i} className="flex items-center gap-3">
                    <div className="w-6 h-6 rounded-full bg-amber-100 flex items-center justify-center">
                      <svg className="w-4 h-4 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                      </svg>
                    </div>
                    <span className={isDark ? 'text-gray-300' : 'text-gray-700'}>{item}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="flex-1 flex justify-center">
              <div className={`w-full max-w-md p-8 rounded-3xl ${isDark ? 'bg-gray-800' : 'bg-gradient-to-br from-amber-100 to-orange-100'}`}>
                <div className="text-center">
                  <div className={`w-20 h-20 rounded-2xl mx-auto mb-6 flex items-center justify-center ${isDark ? 'bg-amber-900/50' : 'bg-amber-200'}`}>
                    <svg className="w-10 h-10 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                  <h3 className={`text-xl font-bold mb-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>Maximize Earnings</h3>
                  <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>
                    See exactly what you&apos;ll earn before accepting. No hidden fees, no surprises. Your earnings, your way.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* For Stores Section */}
      <section id="stores" className={`py-20 ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
        <div className="container mx-auto px-6">
          <div className="flex flex-col lg:flex-row items-center gap-12">
            <div className="flex-1">
              <div className={`inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 ${isDark ? 'bg-green-900/50' : 'bg-green-100'}`}>
                <svg className="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                </svg>
                <span className={`font-semibold ${isDark ? 'text-green-300' : 'text-green-700'}`}>For Stores</span>
              </div>
              <h2 className={`text-3xl md:text-4xl font-bold mb-6 ${isDark ? 'text-white' : 'text-gray-900'}`}>
                Deliver to Your Customers<br />
                <span className="text-green-600">Without the Overhead</span>
              </h2>
              <p className={`text-lg mb-8 ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>
                No need to hire delivery staff. Connect with reliable drivers in your area and dispatch orders with one click.
              </p>
              <ul className="space-y-4">
                {[
                  'Manage all orders in one dashboard',
                  'Find nearby drivers instantly',
                  'Track every delivery in real-time',
                  'Chat with drivers and customers',
                  'Analyze your delivery performance',
                ].map((item, i) => (
                  <li key={i} className="flex items-center gap-3">
                    <div className="w-6 h-6 rounded-full bg-green-100 flex items-center justify-center">
                      <svg className="w-4 h-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                      </svg>
                    </div>
                    <span className={isDark ? 'text-gray-300' : 'text-gray-700'}>{item}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="flex-1 flex justify-center">
              <div className={`w-full max-w-md p-8 rounded-3xl ${isDark ? 'bg-gray-700' : 'bg-gradient-to-br from-green-50 to-green-100'}`}>
                <div className="text-center">
                  <div className={`w-20 h-20 rounded-2xl mx-auto mb-6 flex items-center justify-center ${isDark ? 'bg-green-900/50' : 'bg-green-200'}`}>
                    <svg className="w-10 h-10 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                  <h3 className={`text-xl font-bold mb-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>Reliable Delivery</h3>
                  <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>
                    Your customers get their orders on time, every time. Happy customers, repeat business.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className={`py-20 ${isDark ? 'bg-gray-900' : 'bg-gray-50'}`}>
        <div className="container mx-auto px-6">
          <div className="text-center mb-16">
            <h2 className={`text-3xl md:text-4xl font-bold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {t.features.title}
            </h2>
            <p className={`max-w-2xl mx-auto ${isDark ? 'text-gray-300' : 'text-gray-600'}`}>
              {t.features.subtitle}
            </p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-8">
            {/* Feature 1 */}
            <div className={`rounded-2xl p-8 text-center hover:shadow-lg transition-shadow ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
              <div className={`w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-6 ${isDark ? 'bg-amber-900/50' : 'bg-amber-100'}`}>
                <svg className="w-8 h-8 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0m6 0a2 2 0 104 0m-4 0a2 2 0 114 0" />
                </svg>
              </div>
              <h3 className={`text-xl font-semibold mb-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>{t.features.delivery.title}</h3>
              <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>
                {t.features.delivery.description}
              </p>
            </div>
            
            {/* Feature 2 */}
            <div className={`rounded-2xl p-8 text-center hover:shadow-lg transition-shadow ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
              <div className={`w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-6 ${isDark ? 'bg-amber-900/50' : 'bg-amber-100'}`}>
                <svg className="w-8 h-8 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
              </div>
              <h3 className={`text-xl font-semibold mb-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>{t.features.providers.title}</h3>
              <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>
                {t.features.providers.description}
              </p>
            </div>
            
            {/* Feature 3 */}
            <div className={`rounded-2xl p-8 text-center hover:shadow-lg transition-shadow ${isDark ? 'bg-gray-800' : 'bg-white'}`}>
              <div className={`w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-6 ${isDark ? 'bg-amber-900/50' : 'bg-amber-100'}`}>
                <svg className="w-8 h-8 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                </svg>
              </div>
              <h3 className={`text-xl font-semibold mb-3 ${isDark ? 'text-white' : 'text-gray-900'}`}>{t.features.reviews.title}</h3>
              <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>
                {t.features.reviews.description}
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="bg-gradient-to-r from-gray-900 to-gray-800 py-20">
        <div className="container mx-auto px-6 text-center">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
            {t.cta.title}
          </h2>
          <p className="text-gray-400 max-w-xl mx-auto mb-8">
            {t.cta.subtitle}
          </p>
          <a 
            href="#download" 
            className="inline-flex items-center gap-2 px-8 py-4 bg-amber-500 text-white font-semibold rounded-full hover:bg-amber-600 transition shadow-lg hover:shadow-xl"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
            </svg>
            {t.cta.button}
          </a>
        </div>
      </section>

      <Footer />
    </div>
  );
}
