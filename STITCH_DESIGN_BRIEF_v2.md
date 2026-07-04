# Acrova — Stitch Design Brief (v2 · Canonical)

> **Hand this file to Stitch before generating any screen or flow.**
> Every design decision must trace back to a token or rule in this document.
> Do not invent new patterns, colors, shadows, radii, or type styles.
> Source of truth: live Flutter codebase at `lib/presentation/app/resources/`.

---

## ⚠️ MANDATORY — The Four UI States

> This is the highest-priority rule. Apply it to **every screen that loads, lists, or submits data** — no exceptions.

| State | Trigger | What to design |
|-------|---------|----------------|
| **Loading** | Data fetch in progress | Skeleton shimmer blocks that **mirror the real layout** (not a spinner). Use `skeletonShimmer` gradient (`#E7E8E9 → #F3F4F5 → #E7E8E9`) animating left-to-right. |
| **Success** | Data loaded & present | Fully-populated screen with real representative content. |
| **Empty** | Loaded, zero records | Centered icon (64×64px, `luxuryNavy` @ 30% opacity) + NotoSerif Bold 20px title + Manrope 14px muted subtitle + navy primary CTA. |
| **Error** | Fetch failed | Centered icon (48×48px, `luxuryError #C0392B`) + NotoSerif title + Manrope muted message + "TRY AGAIN" navy CTA. |

**Additional states for forms / wizard steps:**
- **Submitting** — Primary button shows inline circular spinner (white, 20px), button disabled.
- **Field error** — Field gets `#C0392B` border + light red tint fill + error message (Manrope 12px, red) below the field.
- **Pull-to-refresh** — Gold (`#C8A96A`) progress indicator on all scrollable lists.

**Deliver each data screen as separate Stitch frames:**
`[Screen Name] — Loading | [Screen Name] — Success | [Screen Name] — Empty | [Screen Name] — Error`

**Screens requiring all four states:** Dashboard, Projects List, Project Detail (each stage panel), Portfolio / Explore, Notifications, Messages, Profile stats, and every wizard step that validates or calls an API.

**Stateless screens (single state only):** Splash, Welcome, OTP timer, Settings menu items.

---

## 1. Product Identity

| Property | Value |
|----------|-------|
| **Product** | Acrova — Premium PropTech mobile app |
| **Market** | Saudi Arabia (KSA) |
| **Platforms** | iOS + Android (design at 390×844pt / iPhone 14) |
| **Brand tone** | Luxury architectural firm — premium, minimal, structured, trustworthy. Not flashy. |
| **Language** | English (primary) + Arabic (full RTL). Arabic locale replaces ALL fonts with `IBMPlexArabic`. |
| **Currency** | SAR — always use `ريال` or `SAR` symbol |
| **Date style** | Hijri calendar style for all date displays |
| **Project ID format** | `ARC-YYYY-XXXXX` — rendered in `projectId` style (Manrope 700, 8px) |

---

## 2. Color System

> Source: `lib/presentation/app/resources/colors.dart`
> **Do not use any color not listed here.**

### 2.1 Background & Surface

| Token | Hex | Flutter const | Usage |
|-------|-----|---------------|-------|
| `luxuryBackground` | `#F8F9FA` | `0xFFF8F9FA` | All screen scaffolds |
| `luxurySurface` | `#FFFFFF` | `0xFFFFFFFF` | All card / sheet backgrounds |
| `luxuryInputBg` | `#F3F4F5` | `0xFFF3F4F5` | Input fills, OTP boxes |

### 2.2 Primary Palette

| Token | Hex | Flutter const | Usage |
|-------|-----|---------------|-------|
| `luxuryInk` | `#000615` | `0xFF000615` | Deepest text, logo box background |
| `luxuryNavy` | `#0B1F3A` | `0xFF0B1F3A` | Primary CTA buttons, hero cards, section headings |
| `luxuryGold` | `#735B24` | `0xFF735B24` | **Display typography ONLY** — single accent word in headings |
| `luxuryGoldLight` | `#C8A96A` (Figma) | `0xFFC8A96A` | **ALL interactive accents** — progress, links, active tab, focus borders, icons |
| `luxuryGoldOnDark` | `#FFDF9F` | `0xFFFFDF9F` | Gold text on dark backgrounds / navy cards |

> Note: In Flutter code `luxuryGoldLight` is set to `#735B24` (legacy mismatch). The visual Figma intent is `#C8A96A`. **Always use `#C8A96A` in Stitch / design files.**

### 2.3 Text Colors

| Token | Hex | Usage |
|-------|-----|-------|
| `luxuryBody` | `#44474D` | Body text, subtitles |
| `luxuryBodyMuted` | `rgba(68,71,77,0.7)` | Secondary / muted text |
| `luxuryPlaceholder` | `#C4C6CE` | Input placeholder text |

### 2.4 Border Colors

| Token | Hex / rgba | Usage |
|-------|-----------|-------|
| `luxuryBorder` | `#EDEEEF` | Card borders, dividers |
| `luxuryInputBorder` | `rgba(196,198,206,0.3)` | OTP & input box borders |
| `luxuryGoldBorder` | `rgba(200,169,106,0.2)` | Profile avatar gold ring |
| `luxuryGoldBottomBorder` | `#C8A96A` | Phone input bottom-only accent border |

### 2.5 Progress & Semantic

| Token | Hex | Usage |
|-------|-----|-------|
| `luxuryProgressTrack` | `#E7E8E9` | Progress bar background track |
| `luxuryError` | `#C0392B` | Error states, destructive actions |
| `luxurySuccess` | `#1A7A4A` | Success states |
| `luxuryWarning` | `#D4850A` | Advisory / warning hints |

### 2.6 Pipeline Stage Badge Colors

| Stage | Badge Color |
|-------|-------------|
| Awaiting Pricing | Amber `#D97706` |
| Awaiting Payment | Blue `#2563EB` |
| Payment Under Review | Purple `#7C3AED` |
| Awaiting Assignment | Teal `#0D9488` |
| In Progress | Blue `#2563EB` |
| Deliverables Ready | Green `#1A7A4A` |
| Revision In Progress | Orange `#EA580C` |
| Completed | Dark Green `#15803D` |

---

## 3. Typography System

> Source: `lib/presentation/app/resources/app_fonts.dart`
> **Never invent a font, size, weight, or letter-spacing not in this table.**
> **No letter-spacing on Arabic text** — set `letterSpacing: 0` when locale is `ar`.

### 3.1 Font Families

| Role | English | Arabic |
|------|---------|--------|
| Headings / display | **NotoSerif** | IBMPlexArabic |
| Body / labels / buttons | **Manrope** | IBMPlexArabic |

### 3.2 Complete Type Scale

| Token | Font | Weight | Size | Line-height | Letter-spacing | Case | Usage |
|-------|------|--------|------|-------------|----------------|------|-------|
| `displayXL` | NotoSerif | 400 | 48px | 60px | −1.2px | — | Hero screen titles |
| `displayL` | NotoSerif | 400 | 40px | 50px | — | — | Large page headings |
| `displayM` | NotoSerif | 700 | 32px | 40px | — | — | Section headings |
| `brandMark` | NotoSerif | 400 | 20px | 28px | +6px | UPPER | "ACROVA" brand mark |
| `sectionTitle` | NotoSerif | 700 | 20px | 28px | −0.5px | — | Section / tab titles |
| `cardTitle` | NotoSerif | 700 | 16px | 24px | — | — | Card headings |
| `galleryTitle` | NotoSerif | 600 | 16px | 24px | — | — | Gallery item titles |
| `appBarTitle` | NotoSerif | 500 | 22px | 30px | −0.5px | — | App bar centered title |
| `bodyL` | Manrope | 300 | 18px | 29px | — | — | Long subtitles, welcome screens |
| `bodyM` | Manrope | 400 | 16px | 26px | 0.15px | — | General body text |
| `bodyS` | Manrope | 400 | 14px | 23px | 0.25px | — | Secondary body |
| `caption` | Manrope | 400 | 12px | 18px | +1.2px | UPPER | Captions, timestamps |
| `labelL` | Manrope | 700 | 10px | 15px | +1px | UPPER | Form field labels |
| `labelM` | Manrope | 700 | 8px | 12px | +0.8px | UPPER | Status chips, micro labels |
| `projectId` | Manrope | 700 | 8px | 12px | −0.4px | — | `ARC-YYYY-XXXXX` ID display |
| `otpDigit` | Manrope | 600 | 24px | normal | — | — | OTP box digits |
| `timer` | Manrope | 300 | 36px | 40px | −0.9px | — | OTP countdown |
| `buttonPrimary` | Manrope | 600 | 14px | 20px | +1.4px | UPPER | Primary button label |
| `buttonSecondary` | Manrope | 600 | 16px | 24px | +0.4px | — | Secondary button label |

---

## 4. Border Radius

> Source: `lib/presentation/app/resources/radius.dart`
> **These values are non-negotiable. Never deviate.**

| Element | Radius |
|---------|--------|
| **Primary buttons** | **12px** (`AppPrimaryButton` is `$r12`) |
| **Secondary buttons & all inputs** | **2px** (architectural near-square) |
| **Cards (AppCard, project cards)** | **8px** |
| **Image cards** | **8px** |
| **Profile avatar / badge ring** | **12px** |
| **Quick-action chips / pills** | **12px** |
| **Portfolio feature chips** | **100px** (full pill / stadium) |
| **Progress bar** | **4px** |
| **LuxuryIconTextField top corners** | top-left 2px, top-right 2px |

---

## 5. Shadow System

> Source: `lib/presentation/app/resources/app_shadows.dart`

| Token | Color | Blur | Spread | Offset | Usage |
|-------|-------|------|--------|--------|-------|
| `card` | `rgba(0,0,0,0.05)` | 1px | — | 0, 1 | Subtle white card lift |
| `cta` | `rgba(0,6,21,0.10)` | 16px | — | 0, 8 | Primary navy CTA button |
| `hero` | `rgba(0,0,0,0.10)` | 25px | −5px | 0, 20 | Dark hero card |
| `image` | `rgba(0,0,0,0.10)` | 6px | −1px | 0, 4 | Gallery / image card |
| `goldButton` | `rgba(200,169,106,0.20)` | 15px | −3px | 0, 10 | Gold accent button glow |
| `float` | `rgba(0,0,0,0.08)` | 24px | −4px | 0, 8 | Floating elements, bottom sheets |
| `featuredCard` | `rgba(25,28,29,0.04)` | 32px | — | 0, 4 | Featured project card |
| `sheet` | `rgba(0,6,21,0.08)` | 30px | — | 0, −8 | Bottom sheet upward lift |

---

## 6. Spacing System

> Source: `lib/presentation/app/resources/dimens.dart`

| Role | Value |
|------|-------|
| Screen horizontal padding | **24px** |
| Section vertical gap | **32px** |
| Component gap | **16px** |
| Inner element gap | **8px** |
| Card internal padding | **17–24px** |
| Hero card padding | **28px** |
| Bottom navigation height | **60px** |
| Primary button height | **55px** |
| App bar height | **56px** (`kToolbarHeight`) |
| OTP box size | **48 × 64px** |
| Progress bar height | **4px** |

---

## 7. Gradient System

> Source: `lib/presentation/app/resources/gradient_colors.dart`
> All are linear, top-to-bottom unless noted.

| Token | Stops | Direction | Usage |
|-------|-------|-----------|-------|
| `heroCardOverlay` | `#E6000615 → #66000615 → #00000615` | Top→Bottom | Portfolio hero card top scrim (90%→40%→0%) |
| `gridCardOverlay` | `#CC000615 → #33000615 → #00000615` | Top→Bottom | Portfolio grid card top scrim (80%→20%→0%) |
| `detailHeaderScrim` | `#99000615 → #00000615` | Top→Bottom | Detail page nav legibility scrim (60%→0%) |
| `designCardOverlay` | `#00000000 → #B8000615` | Top→Bottom | Dashboard gallery card bottom label overlay (0%→72%) |
| `skeletonShimmer` | `#E7E8E9 → #F3F4F5 → #E7E8E9` | Left→Right | Animated skeleton loader wave |
| `goldShimmer` | `#C8A96A → #E8D5A3 → #C8A96A` | Left→Right | Gold accent shimmer |
| `backgroundFade` | `#F8F9FA → #EDEEEF` | Top→Bottom | Welcome screen background depth |
| `heroNavyFade` | `#0B1F3A → #800B1F3A → #000B1F3A` | Top→Bottom | Hero card navy overlay |

---

## 8. Component Catalog

### 8.1 Buttons

#### AppPrimaryButton
- Height: 55px | Width: full (or custom) | Border radius: **12px**
- Background: `luxuryNavy` (`#0B1F3A`). Disabled: 50% opacity.
- Shadow: `cta` (active) | None (disabled)
- Typography: `buttonPrimary` (Manrope 600, 14px, +1.4px, UPPERCASE)
- Text color: `#FFFFFF`
- Loading: white circular spinner 20px, label hidden
- Padding: 24px horizontal

#### AppSecondaryButton — navy variant
- Height: 55px | Background: transparent | Border radius: **2px**
- Border: 1px `luxuryNavy` | Text: `luxuryNavy`
- Typography: `buttonSecondary` (Manrope 600, 16px, +0.4px)

#### AppSecondaryButton — gold variant
- Same as navy but border `#C8A96A`, text `#C8A96A`

#### AppTextLinkButton
- Inline text | Manrope 14px | `#C8A96A` | Underline on press

---

### 8.2 Cards

#### AppCard (base)
- Background: `#FFFFFF` | Border radius: 8px | Border: 1px `#EDEEEF` | Shadow: `card`
- Padding: configurable (default 17px all sides)

#### Project Card — featured (first in list)
- Full-width image top (16:9 aspect) + content below
- Content: `AppStatusChip` + `projectId` label + `cardTitle` + Manrope 12px subtitle + pipeline progress bar

#### Project Card — standard
- Compact horizontal: 80×80px thumbnail (8px radius, left) + content (right)

#### Hero Dark Card (Dashboard)
- Background: `#0B1F3A` | Border radius: 8px | Shadow: `hero` | Padding: 28px
- Heading: NotoSerif 400 40px white + `luxuryGold` accent word
- CTA: `AppPrimaryButton` gold variant — "START NEW PROJECT"

---

### 8.3 Status Chips

#### AppStatusChip
- Height: 22px | Border radius: 4px
- Typography: `labelM` (Manrope 800, 8px, +0.8px, UPPERCASE)
- Background: stage color @ 15% opacity | Text: stage color (100%)

#### FiltersChip
- Active: `luxuryNavy` fill + white text
- Inactive: `#F3F4F5` fill + `luxuryBody` text
- Height: 36px | Border radius: 12px | Manrope 600 13px, +0.3px

---

### 8.4 Navigation & App Bars

#### AppAppBar
- Elevation: 0 | Background: `#F8F9FA`
- Title: centered, `appBarTitle` (NotoSerif 500, 22px)
- Leading: `AppAppBarBackButton` — 36×36px, 2px radius, 1px `#EDEEEF` border, navy arrow

#### AppAuthBrandHeader
- Centered "ACROVA" — `brandMark` (NotoSerif 400, 20px, +6px, UPPER)
- Optional left back arrow

#### AvatarHeader
- Avatar: 44px circle, `#0B1F3A` fill, 2px `luxuryGoldBorder` ring, initials white
- Greeting: "WELCOME BACK," — `labelL` (Manrope 700, 10px, `#C8A96A`, UPPER)
- Username: `sectionTitle` (NotoSerif 700, 20px, `#000615`)
- Trailing: notification bell 24px, `#0B1F3A`

#### Bottom Navigation
- Background: `#0B1F3A` | Top border: 1px `#EDEEEF` | Shadow: `float` | Height: 60px
- Active: gold top-border 2px + gold icon + gold label (extraBold)
- Inactive: `#C4C6CE` icon + label (medium)

| Tab | Label | Icon |
|-----|-------|------|
| 0 | HOME | home |
| 1 | PROJECTS | folder |
| 2 | PORTFOLIO | account_balance_wallet |
| 3 | MESSAGES | chat_bubble |
| 4 | PROFILE | person |

---

### 8.5 Form Inputs

#### LuxuryIconTextField (Auth / Profile)
- Background: `#E7E8E9` | Border type: underline | Default border: 2px
- Focus: `#C8A96A` 2px bottom border | Error: `#C0392B` 2px
- Prefix icon: 18px, `#0B1F3A`
- Typography: Manrope 400, 16px | Placeholder: Manrope 14px, `#C4C6CE`
- Top corner radius: 2px

#### WizardTextField (Project Creation)
- Label above: `labelL` (Manrope 700, 10px, +1px, UPPER, `#C8A96A`)
- Background: `#F3F4F5` | Default border: 1px `rgba(196,198,206,0.3)`
- Focus: `OutlineInputBorder`, 1.5px `#C8A96A`
- Error: red tint fill + `#C0392B` outline + error text below
- Border radius: 2px | Typography: Manrope 400, 15px

#### OTP Boxes
- Size per box: 48×64px | 6 boxes | 12px gap between
- Background: `#F3F4F5` | Border: 1px `rgba(196,198,206,0.3)` | Active: 1.5px `#C8A96A`
- Border radius: 2px | Typography: Manrope 600, 24px, `#000615`

---

### 8.6 Feedback Components

#### AppEmptyState
- Icon: 64×64px, `#0B1F3A` @ 30%
- Title: NotoSerif 700, 20px, `#0B1F3A`
- Subtitle: Manrope 400, 14px, `luxuryBodyMuted`
- CTA: `AppPrimaryButton`

#### AppErrorState
- Icon: 48×48px, `#C0392B`
- Title: NotoSerif 700, 20px, `#000615`
- Message: Manrope 400, 14px, `luxuryBodyMuted`
- CTA: "TRY AGAIN" `AppPrimaryButton`

#### AppSkeletonLoader
- Shimmer blocks mirroring exact real-content shape
- Gradient: `skeletonShimmer` (#E7E8E9→#F3F4F5→#E7E8E9) animated left-to-right, 1.5s loop
- Corner radius matches replaced component

---

### 8.7 Progress & Stepper

#### Pipeline Progress Bar
- Height: 4px | Radius: 4px | Track: `#E7E8E9` | Fill: `#C8A96A`

#### AppProgressStepper (Wizard)
- Active dot: `#C8A96A`, 10px | Past dot: `#0B1F3A` @ 60%, 8px | Future dot: `#E7E8E9`, 8px
- Connector line: 1px `#EDEEEF`

---

### 8.8 Layout Components

#### AppSectionHeader
- Left: `sectionTitle` (NotoSerif 700, 20px, `#000615`)
- Right: "VIEW ALL" — `labelL` (Manrope 700, 10px, `#C8A96A`, UPPER)

#### CommonScreen
- Scaffold bg: `#F8F9FA` | Horizontal padding: 24px | Top: 16px | Bottom: 60px
- RTL-aware | Tap-to-dismiss keyboard gesture

---

## 9. Navigation Map

```
Splash (2s auto)
  └─► Welcome
        └─► Phone Input (SA +966 default)
              └─► OTP Verification (6-digit, 5 min)
                    ├─► [New user] Profile Setup (KYC)
                    │         └─► Home Shell
                    └─► [Existing] Home Shell

Home Shell (BottomNav 5 tabs)
  ├─ [0] Dashboard
  ├─ [1] My Projects
  ├─ [2] Portfolio / Explore
  ├─ [3] Messages
  └─ [4] Profile

Full-screen modals (over shell):
  ├─ Project Creation Wizard (6 steps)
  ├─ Project Detail
  ├─ Portfolio Detail
  └─ Notifications
```

---

## 10. Screen Specifications

### 10.1 Splash
- Bg: `#F8F9FA` | Center: ACROVA SVG logo 120×120px
- Below: "ACROVA" `brandMark` style, `#000615`
- Auto-advance 2s, no interaction

### 10.2 Welcome
- Top 40%: hero image (`assets/images/Background.png`) + `detailHeaderScrim` overlay
- Logo overlaid top-center (white)
- Heading: NotoSerif 400 40px — line 1 `#000615`, line 2 accent word `#735B24` (luxuryGold)
- Subtitle: Manrope 300, 18px, `luxuryBodyMuted`
- CTA: `AppPrimaryButton` — "GET STARTED"
- Footer: Manrope 12px, `luxuryBodyMuted` — terms & privacy

### 10.3 Phone Input
- `AppAuthBrandHeader` (no back)
- Heading: "Identity Verification" NotoSerif 700 32px `#000615`
- Subtitle: Manrope 400 16px muted
- Divider
- Country selector: flag + "+966" dropdown, Manrope 400 16px
- Phone field: `LuxuryIconTextField`, `#C8A96A` bottom-only border
- CTA: "CONTINUE" primary button
- Footer: "Issue signing in?" `AppTextLinkButton` gold

### 10.4 OTP Verification
- `AppAuthBrandHeader` with back arrow
- Heading: NotoSerif 700 32px
- Subtitle: "Code sent to +966 XX XXX XXXX" Manrope 400 16px
- 6 × OTP boxes (48×64px, 2px radius)
- Countdown: Manrope 300 36px `#C8A96A`
- Label: "minutes remaining" Manrope 12px muted
- CTA: "VERIFY IDENTITY" primary button
- Resend: "RESEND OTP" `AppTextLinkButton` gold, UPPER

### 10.5 Profile Setup (KYC)
- Back arrow app bar
- Heading: NotoSerif 700 32px | Subtitle: Manrope 400 16px muted
- Form: Full Name / Email / National ID (all `LuxuryIconTextField`)
- Language toggle: "English" / "عربي" pills (active = navy fill)
- CTA: "ENTER ACROVA"

### 10.6 Dashboard — 4 states required
**Success state:**
1. `AvatarHeader`
2. Hero dark card (navy, 28px pad): heading + "START NEW PROJECT" CTA
3. "Your Projects" `AppSectionHeader` + project card list / empty state
4. "Quick Actions" 2×2 grid (New Project / Upload Receipt / Revision / Support)
5. "Explore Designs" `AppSectionHeader` + full-width featured card + 2-col grid

### 10.7 Projects List — 4 states required
- `AvatarHeader` + page heading
- Filter chips: All / Active / Completed
- Featured card (large) + standard card list
- Pull-to-refresh (gold spinner)

### 10.8 Project Creation Wizard (6 steps, no bottom nav)
- App bar: back arrow + "CREATE PROJECT" center + "1 of 6" right (Manrope 600 12px muted)
- `AppProgressStepper` below app bar

| Step | Title | Key UI |
|------|-------|--------|
| 1 | Project Type | 3 option cards: Villa / Commercial / Mixed-Use. Selected = navy fill |
| 2 | Land Details | Location + Area m² + Width + Length + Floors counter. SBC warning card if thresholds met |
| 3 | Building Requirements | Bedrooms + Bathrooms counters + Additional spaces toggle grid |
| 4 | Design Preferences | Style chips (multi-select) + Notes textarea |
| 5 | Media Upload | Dashed drop zone + added photos list |
| 6 | Review & Submit | Summary cards per section + EDIT links + agreement checkbox + SUBMIT button |

### 10.9 Project Detail — 4 states per stage
- Hero: full-bleed image carousel (16:9) + `detailHeaderScrim`
- Back button: `CustomBackButton` overlaid top-left
- Content panel: white, 16px top radius, `sheet` shadow, overlaps image bottom
- Stage vertical timeline: 8 stages, gold = current, navy = past, border = future
- Stage panel: dynamic content per §13

### 10.10 Portfolio / Explore — 4 states required
- `AvatarHeader` + page title
- Filter chips: All / Exterior / Interior / Modern / Traditional / Minimalist
- Hero card: full-width, 220px tall, `heroCardOverlay`
- 2-col grid: 165px wide, 200px tall, `gridCardOverlay`
- Detail page: carousel + content sheet + spec grid + feature chips (100px pill) + "REQUEST SIMILAR" CTA

### 10.11 Messages — 4 states required
- `AvatarHeader`
- Conversation list: avatar + name (`cardTitle`) + snippet (Manrope 14px muted) + timestamp
- Unread dot: `#C8A96A`, 8px
- Detail: navy bubbles (user, right) + white bubbles (support, left) + input bar

### 10.12 Notifications — 4 states required
- "NOTIFICATIONS" app bar
- Grouped by date ("TODAY", "THIS WEEK" — `labelL` gold UPPER)
- Row: icon (24px, stage color) + title (`cardTitle`) + timestamp
- Unread: `#F3F4F5` bg tint

### 10.13 Profile
- `AvatarHeader`
- Profile card: avatar 64px + name + email + "MEMBER SINCE" (`labelL` gold) + "EDIT PROFILE" secondary button
- Stats row: Projects count + Completed count (number in NotoSerif 700 32px, label `labelL` gold)
- Settings sections separated by `AppDivider`
- Logout: secondary button → destructive (border + text `#C0392B`)

---

## 11. Payment Flow

> No card / payment gateway UI — bank transfer only.

- Quote card: SAR amount NotoSerif 700 32px `#0B1F3A` + breakdown table
- Bank details card: bank name / IBAN / reference (each: `labelL` key + `bodyM` value)
- Upload area: dashed border 1.5px `#EDEEEF` 8px radius + upload icon 32px `#0B1F3A` @ 40% + "TAP TO UPLOAD RECEIPT" `labelL` gold UPPER
- Post-upload: thumbnail + "PAYMENT UNDER REVIEW" chip + "What happens next" info block

---

## 12. Revision Flow

- Free revisions banner: "X FREE REVISIONS REMAINING" — `labelL` gold UPPER, navy bg
- Request form: type selector + description (multiline `WizardTextField`) + media upload
- History list: date + revision number + status chip + notes

---

## 13. Project Pipeline — 8 Stages

| # | Stage key | Badge label | Badge color | Stage panel |
|---|-----------|-------------|-------------|-------------|
| 1 | `awaitingPricing` | AWAITING PRICING | Amber `#D97706` | "Under review" message + estimated timeline card |
| 2 | `awaitingPayment` | AWAITING PAYMENT | Blue `#2563EB` | Quote card + bank details + "UPLOAD RECEIPT" CTA |
| 3 | `paymentUnderReview` | PAYMENT UNDER REVIEW | Purple `#7C3AED` | Receipt thumbnail + "What's next" info card |
| 4 | `awaitingEngineeringAssignment` | AWAITING ASSIGNMENT | Teal `#0D9488` | Assignment info + estimated date |
| 5 | `awaitingEngineering` | IN PROGRESS | Blue `#2563EB` | Progress indicator + engineer card (avatar + name + title) |
| 6 | `deliverablesReady` | DELIVERABLES READY | Green `#1A7A4A` | Grouped file list (Floor Plans / Elevations / 3D Views) + download & view buttons |
| 7 | `revisionInProgress` | REVISION IN PROGRESS | Orange `#EA580C` | Active revision card + history |
| 8 | `completed` | COMPLETED | Dark Green `#15803D` | Completion summary + "START NEW PROJECT" CTA |

---

## 14. RTL Rules (Arabic Locale)

- Full layout mirroring — all LTR ↔ RTL
- ALL fonts → `IBMPlexArabic` (headings + body + labels)
- `letterSpacing: 0` on all Arabic text (no tracking)
- Directional icons (arrows, back buttons) flip
- Numbers and currency remain LTR within RTL context
- Currency symbol: `ريال`

---

## 15. Business Rules — Surface in Design

| Rule | Design implication |
|------|--------------------|
| Max 3 active projects | "3/3 ACTIVE PROJECTS" counter on Dashboard; disable "START NEW PROJECT" at limit |
| SBC thresholds: land < 150m², floors > 5, width < 10m | Yellow advisory card in Wizard Steps 2 & 6 |
| 2–3 free revisions | Counter banner in Revision flow |
| OTP expires in 5 min | Countdown on OTP screen; "RESEND OTP" disabled until 0 |
| KYC mandatory | Profile Setup cannot be skipped; National ID field marked "Required" |
| Payment = bank transfer only | No card fields, no payment gateway logos |
| Project IDs: `ARC-YYYY-XXXXX` | Manrope 700, 8px, −0.4px tracking |

---

## 16. Asset Inventory

| Asset | Path |
|-------|------|
| App Logo (PNG) | `assets/images/Arcova-Logo-Transparent.png` |
| App Logo (SVG) | `assets/icons/Arcova-Logo-Transparent.svg` |
| Hero Background | `assets/images/Background.png` |
| Interior Design sample | `assets/images/Interior Design.png` |
| Gallery image 1 | `assets/images/img1.png` |
| Gallery image 2 | `assets/images/img2.png` |

---

## 17. Absolute Design Constraints

> Non-negotiable. Stitch must never override these.

1. **Primary button radius: 12px** | **Input / secondary button radius: 2px**. Never 16px or 24px on any element.
2. **`luxuryGold` (`#735B24`)** — display typography accent ONLY (one word in a heading). Never on interactive elements.
3. **`luxuryGoldLight` (`#C8A96A`)** — ALL interactive accents (links, progress, focus borders, active tab, icons).
4. No payment gateway UI. Bank transfer + receipt upload only.
5. Zero letter-spacing on Arabic text.
6. All text must be localizable — no hardcoded strings in designs.
7. Hijri calendar format for all date fields and displays.
8. SAR / ريال for all monetary amounts.
9. Skeleton shimmer must mirror real content shape. Never use a bare spinner for loading.
10. Every data screen delivered as 4 frames: Loading / Success / Empty / Error.
