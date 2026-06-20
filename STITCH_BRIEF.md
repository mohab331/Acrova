# Acrova — Stitch Design Brief

> Give this file to Stitch before generating any screen or flow.
> Every design decision must respect this document. Do not invent new patterns.

---

## 0. MANDATORY — Every Screen Must Define ALL FOUR UI States

> **This is the most important rule in this document.** It applies to EVERY flow and EVERY screen below,
> with NO exceptions. Do not design only the "happy path." For each screen that displays data, produce a
> separate frame/variant for each of the four states:

| State | When shown | What to design |
|-------|-----------|----------------|
| **Loading** | While data is being fetched | **Skeleton shimmer** placeholders that mirror the real layout (cards, rows, images as grey shimmer blocks). NOT a bare spinner — match the final content shape. Use `luxuryProgressTrack → luxuryInputBg` shimmer. |
| **Success** | Data loaded, content exists | The normal, fully-populated screen with real content. |
| **Empty** | Loaded successfully but no data | Centered icon (64px, `luxuryNavy` @ 30%) + NotoSerif title + Manrope muted subtitle + a primary navy CTA to the natural next action (e.g. "START NEW PROJECT"). |
| **Error** | Fetch failed | Centered error icon (48px, `luxuryError`) + NotoSerif title + Manrope muted message + a "TRY AGAIN" navy retry button. |

### Rules
- Deliver the four states as **4 distinct frames** per data screen (e.g. `Projects — Loading`, `Projects — Success`, `Projects — Empty`, `Projects — Error`).
- **Forms / submit actions** additionally need a **submitting state** (primary button shows an inline spinner, disabled) and an **inline field-error state** (red fill tint + red border + error message under the field).
- **Pull-to-refresh** present on every scrollable list (gold spinner).
- Reuse the existing components: `AppSkeletonLoader` + `SkeletonBox` (loading), `AppEmptyState` (empty), `AppErrorState` (error). See §8.
- Static/stateless screens (e.g. Splash, Welcome, Settings menu) only need their single state — but ANY screen that loads, submits, or lists data needs all four.

**Screens that explicitly require all four states:** Dashboard, My Projects, Project Detail, Portfolio/Explore,
Payment, Deliverables, Revisions (list + history), Notifications, Messages, Profile (stats), and every wizard step
that validates or submits.

---

## 1. Product Overview

**Acrova** is a premium B+/Elite PropTech mobile app (iOS + Android) for Saudi Arabia.
It digitises the full architectural design lifecycle — from initial inquiry through to receiving final blueprints.

**Target user:** Saudi residential/commercial property owners who want a premium, guided design experience.

**Brand tone:** Luxury architectural firm. Premium. Minimal. Structured. Trustworthy. Not flashy.

**Language:** English primary + Arabic (full RTL support required). Arabic uses IBMPlexArabic font.

---

## 2. Design System — Colors

### Primary Palette
| Token | Hex | Usage |
|-------|-----|-------|
| `luxuryBackground` | `#F8F9FA` | Screen / scaffold background |
| `luxuryInk` | `#000615` | Deepest text, logo background |
| `luxuryNavy` | `#0B1F3A` | Primary CTA buttons, hero cards, section headings |
| `luxuryGold` | `#735B24` | **ONLY** display typography accent (e.g. gold word in heading) |
| `luxuryGoldLight` | `#735B24` (code) / `#C8A96A` (Figma intent) | ALL interactive accents: progress bars, links, icons, borders |
| `luxuryGoldOnDark` | `#FFDF9F` | Gold text overlaying dark images |
| `luxurySurface` | `#FFFFFF` | Card / sheet backgrounds |
| `luxuryInputBg` | `#F3F4F5` | Input fills, OTP boxes |

### Text Colors
| Token | Hex | Usage |
|-------|-----|-------|
| `luxuryBody` | `#44474D` | Body text, subtitles |
| `luxuryBodyMuted` | `rgba(68,71,77,0.7)` | Secondary / muted text |
| `luxuryPlaceholder` | `#C4C6CE` | Input placeholder text |

### Borders
| Token | Hex | Usage |
|-------|-----|-------|
| `luxuryBorder` | `#EDEEEF` | Card borders, dividers |
| `luxuryInputBorder` | `rgba(196,198,206,0.3)` | OTP / input box borders |
| `luxuryGoldBorder` | `rgba(200,169,106,0.2)` | Profile avatar gold ring |
| `luxuryGoldBottomBorder` | `#C8A96A` | Phone input bottom-only accent border |

### Semantic
| Token | Hex | Usage |
|-------|-----|-------|
| `luxuryProgressTrack` | `#E7E8E9` | Progress bar track |
| `luxuryError` | `#C0392B` | Error states |
| `luxurySuccess` | `#1A7A4A` | Success states |
| `luxuryWarning` | `#D4850A` | Warning / advisory states |

---

## 3. Typography

### Font Families
- **Headings (EN):** NotoSerif
- **Body / Labels (EN):** Manrope
- **All (AR):** IBMPlexArabic (replaces both NotoSerif and Manrope)

### Type Scale (English — from Figma)

| Style | Font | Weight | Size | Letter-spacing | Line-height | Usage |
|-------|------|--------|------|----------------|-------------|-------|
| displayXL | NotoSerif | 400 | 48px | −1.2px | 60px | Hero screen titles |
| displayL | NotoSerif | 400 | 40px | — | 50px | Large page headings |
| displayM | NotoSerif | 700 | 32px | — | 40px | Section headings |
| brandMark | NotoSerif | 400 | 20px | +6px | 28px | UPPERCASE brand mark |
| sectionTitle | NotoSerif | 700 | 20px | −0.5px | 28px | Section / tab titles |
| cardTitle | NotoSerif | 700 | 16px | — | 24px | Card headings |
| galleryTitle | NotoSerif | 600 | 16px | — | 24px | Gallery item titles |
| bodyL | Manrope | 300 | 18px | — | 29.25px | Long subtitles |
| bodyM | Manrope | 400 | 16px | — | 26px | General body text |
| bodyS | Manrope | 400 | 14px | — | 22.75px | Secondary body |
| caption | Manrope | 400 | 12px | +1.2px | 18px | UPPERCASE captions |
| labelL | Manrope | 700 | 10px | +1px | 15px | UPPERCASE section labels |
| labelM | Manrope | 700 | 8px | +0.8px | 12px | UPPERCASE micro labels |
| otpDigit | Manrope | 600 | 24px | — | normal | OTP digit boxes |
| timer | Manrope | 300 | 36px | −0.9px | 40px | Countdown timer |
| buttonPrimary | Manrope | 600 | 14px | +1.4px | 20px | UPPERCASE primary button |
| buttonSecondary | Manrope | 600 | 16px | +0.4px | 24px | Secondary button |
| projectId | Manrope | 700 | 8px | −0.4px | 12px | Project ID label |
| statusBadge | Manrope | 800 | 8px | +0.8px | 12px | UPPERCASE status chip |

---

## 4. Border Radius

| Element | Radius |
|---------|--------|
| Buttons & Inputs | **2px** ← architectural, near-square. NEVER deviate |
| Cards | **8px** |
| Image cards | **8px** |
| Profile avatar / badge ring | **12px** |
| Quick-action pill / chip | **12px** |
| Feature chips (portfolio) | **100px** (full pill) |

---

## 5. Shadows

| Name | Value |
|------|-------|
| card | `BoxShadow(color: #0D000000, blur: 1, offset: 0,1)` |
| cta | `BoxShadow(color: #1A000615, blur: 16, offset: 0,8)` |
| hero | `BoxShadow(color: #1A000000, blur: 25, spread: -5, offset: 0,20)` |
| image | `BoxShadow(color: #1A000000, blur: 6, spread: -1, offset: 0,4)` |
| goldButton | `BoxShadow(color: #33C8A96A, blur: 15, spread: -3, offset: 0,10)` |
| float | `BoxShadow(color: #14000000, blur: 24, spread: -4, offset: 0,8)` |
| featuredCard | `BoxShadow(color: #0A191C1D, blur: 32, offset: 0,4)` |
| sheet | `BoxShadow(color: #14000615, blur: 30, offset: 0,-8)` (upward) |

---

## 6. Spacing System

| Role | Value |
|------|-------|
| Screen horizontal padding | 24px |
| Section vertical gap | 32px |
| Component gap | 16px |
| Element inner gap | 8px |
| Card padding | 17px |
| Hero card padding | 28px |

---

## 7. Gradient Overlays (for image cards)

| Name | Colors | Usage |
|------|--------|-------|
| heroCardOverlay | `#E6000615 → #66000615 → #00000615` | Portfolio hero card top scrim |
| gridCardOverlay | `#CC000615 → #33000615 → #00000615` | Portfolio grid card top scrim |
| detailHeaderScrim | `#99000615 → #00000615` | Detail page top nav scrim |
| designCardOverlay | `#00000000 → #B8000615` | Dashboard gallery card bottom overlay |

---

## 8. Component Inventory (Common Widgets)

### Buttons
- **AppPrimaryButton** — full-width navy (`#0B1F3A`), 55px height, 2px radius, shadow `cta`, UPPERCASE label, loading spinner state
- **AppSecondaryButton** — outlined, navy or gold variant, 2px radius
- **AppTextLinkButton** — inline text link

### Cards
- **AppCard** — white surface, 8px radius, 1px `luxuryBorder`, shadow `card`, configurable padding

### Chips / Tags
- **AppStatusChip** — colored badge showing project pipeline status (8 statuses)
- **FiltersChip** — filter tab for lists/galleries. Active = navy fill, inactive = `luxuryInputBg`

### Feedback
- **AppEmptyState** — centered icon (64px, navy) + title (NotoSerif titleLarge, navy) + subtitle (body, muted) + optional CTA
- **AppErrorState** — centered error icon (48px, error red) + title + message + optional retry button
- **AppSkeletonLoader** + **SkeletonBox** — shimmer effect for loading states

### Navigation / App Bars
- **AppAuthBrandHeader** — centered "ACROVA" brand mark, optional back arrow
- **AvatarHeader** — avatar circle (navy fill, gold border ring) + "WELCOME BACK," greeting + username + notification bell
- **CustomBackButton** — rounded 2px square with navy arrow icon

### Progress
- **AppProgressStepper** — horizontal step dots with gold active indicator

### Layout
- **AppSectionHeader** — left-aligned section title (NotoSerif 700 20px) + right-aligned gold "VIEW ALL" link
- **AppDivider** — thin `luxuryBorder` horizontal line
- **CommonScreen** — Scaffold wrapper with RTL support, 20px horizontal padding, gesture dismiss

### Images
- **AppCachedNetworkImage** — CachedNetworkImage with placeholder shimmer

---

## 9. Navigation Structure

```
Splash Page
    ↓ (no token)
Welcome Page
    ↓ (GET STARTED)
Phone Input Page
    ↓ (Continue)
OTP Verification Page
    ↓ (VERIFY IDENTITY)
    ├── New user → Profile Setup Page (KYC mandatory)
    └── Existing user → Home Shell

Home Shell (Bottom Nav — 5 tabs)
├── [0] Home / Dashboard
├── [1] My Projects
├── [2] Portfolio / Explore
├── [3] Messages / Support
└── [4] Profile

Full-screen overlays (above Shell):
├── Project Creation Wizard (6 steps)
└── Portfolio Detail Page
```

---

## 10. Bottom Navigation

5 tabs. Navy surface, `luxuryBorder` top divider, `float` shadow. Height: 60px.

| Tab | Icon | Label |
|-----|------|-------|
| Home | home_outlined / home | HOME |
| Projects | folder_outlined / folder | PROJECTS |
| Portfolio | account_balance_wallet_outlined / ... | PORTFOLIO |
| Messages | chat_bubble_outline / chat_bubble | MESSAGES |
| Profile | person_outline / person | PROFILE |

Active tab: gold (`#735B24`) top border (2px) + gold icon + gold label (extraBold).
Inactive: `luxuryPlaceholder` icon + label (medium weight).

---

## 11. Project Pipeline — 8 Lifecycle Stages

The entire app revolves around this stage-gated pipeline. Every project card and detail screen shows current stage.

| Stage | Label (EN) | Customer Action | Color |
|-------|-----------|-----------------|-------|
| `awaitingPricing` | AWAITING PRICING | Wait | Amber |
| `awaitingPayment` | AWAITING PAYMENT | Upload receipt | Blue |
| `paymentUnderReview` | PAYMENT UNDER REVIEW | Wait | Purple |
| `awaitingEngineeringAssignment` | AWAITING ASSIGNMENT | Wait | Teal |
| `awaitingEngineering` | IN PROGRESS | Wait | Blue |
| `deliverablesReady` | DELIVERABLES READY | View + Download | Green |
| `revisionInProgress` | REVISION IN PROGRESS | Wait | Orange |
| `completed` | COMPLETED | — | Dark green |

Progress bar fills from 0% → 100% as stages advance.

---

## 12. SRS — Mobile Flows to Design

### Flow 1 — Onboarding / Auth
**Screens:**
1. **Splash** — Centered ACROVA logo + brand name on `#F8F9FA`. Auto-navigates.
2. **Welcome** — Logo + NotoSerif display heading with gold accent word + subtitle + "GET STARTED" navy CTA + footer
3. **Phone Input** — ACROVA brand header + "Identity Verification" title + phone field with country selector (SA default, +966) + gold bottom border + "Continue" CTA + terms text + "Issue signing in?" link
4. **OTP Verification** — 6 digit boxes (48×64px, 2px radius) + countdown timer (5 min) + "VERIFY IDENTITY" CTA + "RESEND OTP" link
5. **Profile Setup** (new users only) — Name + Email + National ID + Language preference (EN/AR) + "ENTER ACROVA" CTA

### Flow 2 — Dashboard (Home Tab)
**Screen:** Dashboard
- AvatarHeader (avatar + greeting + notification bell)
- Hero dark card (navy bg, 8px radius): "Your Vision / Fully Realised" heading + "START NEW PROJECT" gold CTA
- "Your Projects" section header + project card list (or empty state)
- "Quick Actions" 2×2 grid: New Project / Upload Receipt / Revision / Support
- "Explore Designs" gallery section (featured + 2-column grid)

### Flow 3 — Project Creation Wizard
6-step wizard with progress bar. Full-screen (no shell nav).

| Step | Title | Content |
|------|-------|---------|
| 1 | Project Type | 3 option cards (Villa / Commercial / Mixed) with icon + label + description. Selected = navy fill |
| 2 | Land Details | Location text field + Area (m²) + Width + Length + Floor counter (−/+) + SBC advisory warning card |
| 3 | Building Requirements | Bedrooms counter + Bathrooms counter + Additional spaces toggle grid (Majlis, Maid Room, Driver, Basement, Pool, Rooftop) |
| 4 | Design Preferences | Style chips (Modern / Classic / Contemporary / Minimalist) + Notes textarea |
| 5 | Media Upload | Upload area + list of added photos |
| 6 | Review & Submit | Summary cards per section (type / land / requirements / design / media) with EDIT button + SBC warning (if any) + agreement text |

### Flow 4 — Projects List
**Screen:** Projects (tab 2)
- AvatarHeader
- Section header with title + subtitle
- Filter chips: All / Active / Completed
- Featured card (first project — large image + content)
- Standard cards (remaining projects — compact image + content)
- Empty state (no projects yet)
- Skeleton loading state

### Flow 5 — Project Detail + Stage Pipeline (PHASE 4 — TO DESIGN)
**Screen:** Project Detail
- Hero image / carousel
- Stage timeline (vertical stepper showing all 8 stages)
- Current stage panel (stage-specific UI):
  - **awaitingPricing** — "Your project is being reviewed" message + estimated timeline
  - **awaitingPayment** — Price quote card + bank transfer details + "UPLOAD RECEIPT" CTA
  - **paymentUnderReview** — Receipt upload confirmation + "What's next" info
  - **awaitingEngineeringAssignment** — Engineer assignment info
  - **awaitingEngineering** — Progress indicator + engineer info
  - **deliverablesReady** — Deliverable list (grouped by type) + Download / View buttons
  - **revisionInProgress** — Revision request form + history
  - **completed** — Completion summary

### Flow 6 — Payment Module (PHASE 5 — TO DESIGN)
- Quote display card (SAR amount + breakdown)
- Bank transfer details (bank name, IBAN, reference number)
- Receipt upload area (drag or tap)
- Upload success / under review state

### Flow 7 — Engineering Deliverables (PHASE 6 — TO DESIGN)
- List of deliverables grouped by type (Floor Plans, Elevations, 3D Views, etc.)
- Each item: file name + type + size + download button
- In-app PDF viewer
- Download to device

### Flow 8 — Revisions (PHASE 7 — TO DESIGN)
- Revision request form: revision type + description + media attachments
- Revision history list (date, status, notes)
- Free revision counter ("2 free revisions remaining")

### Flow 9 — Portfolio / Explore (PHASE 8)
**Screen:** Portfolio (tab 3)
- AvatarHeader
- Page title + subtitle
- Filter chips: All / Exterior / Modern / Traditional / Interior
- Hero card (featured) + 2-column grid
- Detail page (carousel + content panel + spec grid + feature chips + CTA)

### Flow 10 — Interior Design Phase Gate (PHASE 9 — TO DESIGN)
- Phase gate screen explaining Phase II availability
- Style preferences for interior
- Interior deliverables list

### Flow 11 — Notifications (PHASE 10 — TO DESIGN)
- Push notification list grouped by date
- Notification detail (tap → navigates to relevant project stage)

### Flow 12 — Profile + Settings (PHASE 10)
**Screen:** Profile (tab 5)
- AvatarHeader
- Profile card (avatar circle + name + email + "MEMBER SINCE" + Edit Profile button)
- Stats row (Projects count + Completed count)
- Settings sections: Account / Preferences / Help & Support
- Logout button (red outlined)

---

## 13. UX Patterns

### Button Placement
- Single primary CTA always at bottom of screen / bottom of form card
- Secondary / text actions above the primary CTA
- Destructive actions (Logout) use outlined error-red button

### Forms
- Label above input (UPPERCASE, 10px, gold, Manrope bold)
- Input: filled background `luxuryInputBg`, 2px border radius, gold bottom-only focus border
- Error state: error-red fill tint + red border + inline error message below

### Four Required UI States (see §0 — applies to EVERY data screen)
Every screen that fetches, lists, or submits data must be designed in all four states:

- **Loading** — Skeleton shimmer mirroring the real layout (not a bare spinner). Submit actions show an inline button spinner.
- **Success** — Fully-populated content.
- **Empty** — Centered icon (64px, navy @ 30%) + NotoSerif title + Manrope subtitle + navy CTA.
- **Error** — Centered error icon (48px, red) + title + message + "TRY AGAIN" CTA.

Deliver these as separate frames (e.g. `Dashboard — Loading / Success / Empty / Error`).

### Stage Pipeline Feedback
- Progress bar (4px height, gold fill, `luxuryProgressTrack` background, 4px radius)
- Status chip (colored by stage) on every project card

### RTL
- Full RTL layout mirroring for Arabic
- No letter-spacing on Arabic text (only on Latin)
- IBMPlexArabic replaces both NotoSerif and Manrope in Arabic locale

---

## 14. Key Business Rules for Design

1. Max 3 concurrent active projects per customer — surface this limit clearly
2. Project IDs format: `ARC-YYYY-XXXXX` — always show in projectId style (8px, Manrope 700)
3. 2–3 free revisions — show counter in revision-related screens
4. Payment = manual bank transfer + receipt upload (NO card/payment gateway UI)
5. OTP = 5-minute countdown with resend option
6. KYC = National ID required at profile setup (new users only)
7. SBC advisory shown when: land < 150m², floors > 5, width < 10m

---

## 15. Assets Available

| Asset | Path |
|-------|------|
| App Logo (PNG) | `assets/images/Arcova-Logo-Transparent.png` |
| App Logo (SVG) | `assets/icons/Arcova-Logo-Transparent.svg` |
| Background Image | `assets/images/Background.png` |
| Interior Design | `assets/images/Interior Design.png` |
| img1, img2 | `assets/images/img1.png`, `assets/images/img2.png` |

---

## 16. Design Constraints — DO NOT CHANGE

- Button radius is **2px**. Non-negotiable.
- Card radius is **8px**. Non-negotiable.
- `luxuryGold` (`#735B24`) is ONLY for display typography (gold accent word in headings)
- `luxuryGoldLight` / `#C8A96A` for ALL interactive elements (links, progress bars, borders, icons)
- No payment gateway UI — bank transfer only
- All text must be localizable (no hardcoded strings in designs)
- Hijri calendar style for date displays
- SAR (ريال) currency symbol for monetary amounts
