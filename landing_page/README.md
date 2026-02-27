# 🦊 Awhar Butler - Landing Page

> **Modern Next.js landing page for Awhar Butler platform**

This is the **Next.js 15** marketing website that introduces users to the Awhar Butler platform and provides information about features, pricing, and downloads.

---

## 🌐 What This Website Does

**Awhar Landing Page** serves as the public face of the platform:

✅ **Marketing Homepage** — Showcase platform features  
✅ **Feature Pages** — Detailed explanations for clients, drivers, stores  
✅ **App Download Links** — iOS App Store & Google Play Store  
✅ **Legal Pages** — Terms of Service, Privacy Policy, Community Guidelines  
✅ **Contact Form** — Customer support inquiries  
✅ **Multi-Language** — English, Arabic, French, Spanish  
✅ **Dark Mode** — Light/dark theme switching  
✅ **SEO Optimized** — Meta tags, structured data, sitemap  

---

## 🚀 Quick Start

### Prerequisites

- **Node.js**: 18 or higher
- **npm** or **yarn**

### 1. Install Dependencies

```bash
npm install
# or
yarn install
```

### 2. Run Development Server

```bash
npm run dev
# or
yarn dev
```

**Access**: `http://localhost:3000`

### 3. Build for Production

```bash
npm run build
# or
yarn build
```

### 4. Start Production Server

```bash
npm run start
# or
yarn start
```

---

## 📄 Pages

### 1. Homepage (`/`)

**Sections**:
- **Hero**: Main value proposition with CTA buttons
- **Features**: Client, Driver, Store benefits
- **How It Works**: Step-by-step platform explanation
- **Statistics**: Platform metrics (users, orders, earnings)
- **Testimonials**: User reviews
- **App Downloads**: iOS and Android links
- **FAQ**: Common questions
- **CTA**: Final call-to-action

### 2. Contact Page (`/contact`)

**Features**:
- Contact form (name, email, message)
- Form validation
- API submission
- Success/error feedback

**API Endpoint**: `/api/contact`

### 3. Privacy Policy (`/privacy`)

**Content**:
- Data collection practices
- How we use data
- Third-party services (Firebase, Google Maps)
- User rights
- GDPR compliance
- Contact information

### 4. Terms of Service (`/terms`)

**Content**:
- Platform usage terms
- User responsibilities
- Driver/store requirements
- Payment terms
- Dispute resolution
- Liability limitations

### 5. Delete Account (`/delete-account`)

**Features**:
- Account deletion request form
- GDPR compliance (right to be forgotten)
- Email confirmation
- Data retention policy explanation

---

## 🎨 Styling

### Tailwind CSS

**Configuration**: `tailwind.config.ts`

```typescript
export default {
  content: [
    './src/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: '#2196F3',
        secondary: '#03A9F4',
      },
    },
  },
}
```

### Dark Mode

**Toggle Component**: `src/components/ThemeToggle.tsx`

```tsx
const ThemeToggle = () => {
  const { theme, setTheme } = useTheme();
  
  return (
    <button onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}>
      {theme === 'dark' ? '🌙' : '☀️'}
    </button>
  );
};
```

---

## 🌍 Multi-Language Support

### Available Languages

| Language | Code | Status |
|----------|------|--------|
| English | `en` | ✅ |
| Arabic | `ar` | ✅ |
| French | `fr` | ✅ |
| Spanish | `es` | ✅ |

### Translation System

**File**: `src/i18n/translations.ts`

```typescript
export const translations = {
  en: {
    nav: {
      home: 'Home',
      features: 'Features',
      contact: 'Contact',
    },
    hero: {
      title: 'Your Business Butler',
      subtitle: 'Connecting clients, drivers, and stores',
      cta: 'Get Started',
    },
  },
  ar: {
    nav: {
      home: 'الرئيسية',
      features: 'الميزات',
      contact: 'اتصل بنا',
    },
    hero: {
      title: 'مساعدك التجاري الشخصي',
      subtitle: 'ربط العملاء والسائقين والمتاجر',
      cta: 'ابدأ الآن',
    },
  },
};
```

### Language Switcher

**Component**: `src/components/LanguageSwitcher.tsx`

```tsx
const LanguageSwitcher = () => {
  const { language, setLanguage } = useLanguage();
  
  return (
    <select value={language} onChange={(e) => setLanguage(e.target.value)}>
      <option value="en">English</option>
      <option value="ar">العربية</option>
      <option value="fr">Français</option>
      <option value="es">Español</option>
    </select>
  );
};
```

---

## 📱 Responsive Design

### Breakpoints

```css
/* Mobile First */
sm: 640px   /* Small devices */
md: 768px   /* Medium devices */
lg: 1024px  /* Large devices */
xl: 1280px  /* Extra large devices */
2xl: 1536px /* 2X large devices */
```

### Example Usage

```tsx
<div className="
  px-4           /* Mobile: 16px padding */
  md:px-8        /* Tablet: 32px padding */
  lg:px-16       /* Desktop: 64px padding */
  max-w-7xl      /* Max width 1280px */
  mx-auto        /* Center horizontally */
">
  Content
</div>
```

---

## 🔧 Configuration

### Environment Variables

Create `.env.local`:

```env
# Contact form email
CONTACT_EMAIL=contact@awhar.io

# API URL
NEXT_PUBLIC_API_URL=https://api.awhar.io

# Google Analytics (optional)
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
```

### Next.js Config

**File**: `next.config.ts`

```typescript
const nextConfig = {
  output: 'standalone',
  images: {
    domains: ['storage.googleapis.com'],
  },
  i18n: {
    locales: ['en', 'ar', 'fr', 'es'],
    defaultLocale: 'en',
  },
};

export default nextConfig;
```

---

## 📊 SEO Optimization

### Meta Tags

```tsx
export const metadata: Metadata = {
  title: 'Awhar Butler - Your Personal Business Assistant',
  description: 'Connecting clients, drivers, and stores in one platform.',
  keywords: 'delivery, ride, service, marketplace, gig economy',
  openGraph: {
    title: 'Awhar Butler',
    description: 'Your Personal Business Assistant',
    images: ['/logo.png'],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Awhar Butler',
    description: 'Your Personal Business Assistant',
  },
};
```

### Sitemap Generation

```typescript
// app/sitemap.ts
export default function sitemap(): MetadataRoute.Sitemap {
  return [
    {
      url: 'https://awhar.io',
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 1,
    },
    {
      url: 'https://awhar.io/contact',
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 0.8,
    },
  ];
}
```

---

## 📧 Contact Form API

**Endpoint**: `/api/contact/route.ts`

```typescript
export async function POST(request: Request) {
  const { name, email, message } = await request.json();
  
  // Validate input
  if (!name || !email || !message) {
    return NextResponse.json(
      { error: 'All fields required' },
      { status: 400 }
    );
  }
  
  // Send email (using SendGrid, Resend, etc.)
  await sendEmail({
    to: process.env.CONTACT_EMAIL,
    subject: `Contact from ${name}`,
    body: message,
  });
  
  return NextResponse.json({ success: true });
}
```

---

## 🚀 Deployment

### Vercel (Recommended)

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel
```

**Auto-deploy** on push to `main` branch when connected to GitHub.

### Docker

```dockerfile
# Dockerfile
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["node", "server.js"]
```

```bash
# Build and run
docker build -t awhar-landing .
docker run -p 3000:3000 awhar-landing
```

---

## 📦 Dependencies

```json
{
  "dependencies": {
    "next": "^15.1.6",
    "react": "^19.0.0",
    "react-dom": "^19.0.0"
  },
  "devDependencies": {
    "@types/node": "^22.10.6",
    "@types/react": "^19.0.6",
    "autoprefixer": "^10.4.21",
    "eslint": "^9.18.0",
    "eslint-config-next": "^15.1.6",
    "postcss": "^8.4.49",
    "tailwindcss": "^3.4.17",
    "typescript": "^5.7.3"
  }
}
```

---

## 🧪 Testing

### Run ESLint

```bash
npm run lint
```

### Type Checking

```bash
npm run type-check
```

---

## 📚 Resources

**Next.js Documentation**: https://nextjs.org/docs

**Tailwind CSS**: https://tailwindcss.com/docs

**Vercel Deployment**: https://vercel.com/docs

---

<div align="center">

**🦊 Awhar Butler Landing Page**

*Built with Next.js 15 and Tailwind CSS*

[Main Repository](https://github.com/FouadABT/awhar-butler) • [Live Site](https://awhar.io)

</div>
