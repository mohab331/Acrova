# Acrova — UI Design Brief for Missing Screens
**App:** Acrova — Premium PropTech Platform (Saudi Arabia)  
**Platform:** iOS (iPhone 14, 390×844pt)  
**Design language:** Luxury · Minimal · Architectural · Elite  
**Audience:** B+ / High-net-worth Saudi clients

---

## Global Design Tokens

### Colors
| Token | Hex | Usage |
|-------|-----|-------|
| Background | `#F8F9FA` | All screen scaffolds |
| Ink | `#000615` | Logo box, deepest text |
| Navy | `#0B1F3A` | Primary CTA buttons, hero card, headings |
| Gold | `#735B24` | Display heading accent word only |
| Gold Light | `#C8A96A` | ALL interactive accents: links, progress, icons, labels, borders |
| Body | `#44474D` | Body text, subtitles |
| Surface | `#FFFFFF` | Card backgrounds |
| Input Fill | `#F3F4F5` | OTP boxes, form inputs |
| Border | `#EDEEEF` | Card borders, dividers |
| Input Border | `rgba(196,198,206,0.3)` | Input/OTP box borders |
| Placeholder | `#C4C6CE` | Placeholder text |
| Muted | `rgba(68,71,77,0.7)` | Secondary/helper text |
| Progress Track | `#E7E8E9` | Progress bar background |
| Error | `#C0392B` | Error states |
| Success | `#1A7A4A` | Success states |
| Warning | `#B7791F` | Warning hints |

### Typography
| Style | Font | Weight | Size | Tracking | Case |
|-------|------|--------|------|----------|------|
| Display XL | Noto Serif | 400 | 48px | -1.2px | — |
| Display L | Noto Serif | 400 | 40px | — | — |
| Display M | Noto Serif | 700 | 32px | — | — |
| Section Title | Noto Serif | 700 | 20px | -0.5px | — |
| Card Title | Noto Serif | 700 | 16px | — | — |
| Body L | Manrope | 300 | 18px | — | — |
| Body M | Manrope | 400 | 16px | — | — |
| Body S | Manrope | 400 | 14px | — | — |
| Caption | Manrope | 400 | 12px | 1.2px | UPPER |
| Label L | Manrope | 700 | 10px | 1px | UPPER |
| Label M | Manrope | 800 | 8px | 0.8px | UPPER |
| Button | Manrope | 600 | 14px | 1.4px | UPPER |
| OTP Digit | Manrope | 600 | 24px | — | — |
| Timer | Manrope | 300 | 36px | -0.9px | — |
| Brand Mark | Noto Serif | 400 | 20px | 6px | UPPER |

### Border Radius
| Element | Radius |
|---------|--------|
| Buttons & Inputs | **2px** (architectural — intentional) |
| Cards | 8px |
| Images | 8px |
| Avatar / Badge | 12px |
| Pills / Tags | 12px |
| Hero action button | 12px |

### Shadows
- **Card:** `0 1px 1px rgba(0,0,0,0.05)`
- **CTA Button:** `0 8px 16px rgba(0,6,21,0.10)`
- **Hero Card:** `0 20px 25px -5px rgba(0,0,0,0.10), 0 8px 10px -6px rgba(0,0,0,0.10)`
- **Gold Button:** `0 10px 15px -3px rgba(200,169,106,0.20)`
- **Image Card:** `0 4px 6px -1px rgba(0,0,0,0.10)`

### Spacing System
- Screen horizontal padding: **24px**
- Section gap (vertical): **32px**
- Component gap: **16px**
- Inner element gap: **8px**
- Card internal padding: **17–24px**

### Existing Screens (already designed — DO NOT recreate)
1. Welcome Screen
2. Phone Input Screen
3. OTP Verification Screen
4. Home / Dashboard Screen

---

## Screen 1 — Profile Setup (KYC)

**Purpose:** Mandatory first-time profile completion after OTP. New users cannot proceed without this.  
**Route:** Appears once after first OTP verification.

### Layout
```
┌──────────────────────────────────────┐
│  ← Back                              │  Top App Bar: back arrow (left)
│                                      │
│  Complete Your                       │  Display M: Noto Serif Bold 32px, Ink
│  Profile                             │
│                                      │
│  Set up your identity to access      │  Body M: Manrope 400 16px, Body color
│  Arcova's exclusive services.        │
│                                      │
│  ─────────────────────────────────   │  Thin divider
│                                      │
│  FULL NAME                           │  Caption label: Manrope 12px, UPPER, muted
│  ┌───────────────────────────────┐   │  Input field: white bg, 2px radius, gold
│  │  e.g. Mohammed Al-Rashidi    │   │  bottom border on focus, 56px height
│  └───────────────────────────────┘   │
│                                      │
│  EMAIL ADDRESS                       │  Same pattern
│  ┌───────────────────────────────┐   │
│  │  your@email.com               │   │
│  └───────────────────────────────┘   │
│                                      │
│  PREFERRED LANGUAGE                  │  Caption label
│  ┌──────────────┐ ┌──────────────┐  │  Two chips side by side (toggle):
│  │  ✓ English   │ │    العربية   │  │  Selected: Navy bg, white text
│  └──────────────┘ └──────────────┘  │  Unselected: white bg, navy text, border
│                                      │
│                 [    ENTER ARCOVA  →  ]│  Primary button: full-width, Navy, 2px radius
│                                      │
│    By continuing you agree to        │  Footer: Manrope 12px, center, muted
│    Arcova's Terms · Privacy Policy   │  "Terms" and "Privacy Policy" in Gold Light
└──────────────────────────────────────┘
```

### States
- **Default:** Empty fields, English chip selected by default
- **Validation error:** Red text below empty required field: "This field is required"
- **Loading:** Button shows spinner + disabled
- **Input focused:** Gold Light bottom border (`#C8A96A`)

---

## Screen 2 — Projects List

**Purpose:** Full list of all user projects across all statuses.  
**Route:** "Projects" tab (second tab of bottom nav).

### Layout
```
┌──────────────────────────────────────┐
│  WELCOME BACK,        [🔔]           │  Top App Bar: same as dashboard
│  Mohab                               │
├──────────────────────────────────────┤
│  Your Projects                       │  Section Title: Noto Serif Bold 20px, Navy
│                                      │
│  ○ All  ○ Active  ○ Completed        │  Filter chips row: horizontal scroll
│    ○ In Review  ○ Revision           │  Selected chip: Navy bg, white, 12px radius
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ [Blueprint] ARC-2026-00012  AWAITING PRICING │  Project Card (see spec below)
│ │             Al-Yasmeen Estate             │
│ │             ████░░░░░░░░  33%             │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ [Blueprint] ARC-2026-00011  DELIVERABLES READY │
│ │             Al-Nakheel Villa                   │
│ │             ████████████  100%                 │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ [Blueprint] ARC-2026-00010  COMPLETED          │
│ │             Desert Rose Manor                  │
│ │             ████████████  100%  ✓              │
│ └──────────────────────────────────┘ │
│                                      │
│  + START A NEW PROJECT               │  Ghost button: full-width, Navy border,
│                                      │  2px radius, Navy text
└──────────────────────────────────────┘
```

### Project Card Spec
```
White card, #EDEEEF border, 8px radius, card shadow
Internal padding: 17px
Layout: horizontal

LEFT:  64×64 rounded-4px image thumbnail (blueprint/architectural image)
       Background: #EDEEEF if no image

RIGHT: (flex column)
  Row 1: Project ID (8px, Manrope Bold, muted, UPPER)  |  Status Badge (8px, Manrope ExtraBold, color-coded)
  Row 2: Project Name — Noto Serif Bold 16px, Navy
  Row 3: Progress bar (gold fill on grey track, 4px height, 12px radius) + "XX%" right-aligned
```

### Status Badge Colors (text-only, no background fill except...)
| Status | Text Color |
|--------|-----------|
| AWAITING PRICING | `#C8A96A` Gold Light |
| AWAITING PAYMENT | `#C8A96A` Gold Light |
| PAYMENT UNDER REVIEW | `#B7791F` Warning |
| AWAITING ENGINEERING | `#44474D` Body |
| DELIVERABLES READY | `#1A7A4A` Success |
| REVISION IN PROGRESS | `#B7791F` Warning |
| COMPLETED | `#1A7A4A` Success |

### Empty State
```
Center of screen:
  Icon: Blueprint/ruler illustration (48px, muted)
  Title: "No Projects Yet" — Noto Serif 20px, Navy
  Subtitle: "Start your architectural journey by creating your first project."
  Button: "START NEW PROJECT" — primary navy button
```

---

## Screen 3 — New Project Wizard (5 Steps)

**Shared layout for all steps:**
```
┌──────────────────────────────────────┐
│  ←  New Project                      │  App bar: back + title
├──────────────────────────────────────┤
│  ●────●────○────○────○               │  Progress stepper: 5 steps
│  Step 2 of 5                         │  Active: Navy filled circle + gold connector line
│                                      │  Done: Gold filled circle + checkmark
│                                      │  Future: #EDEEEF circle
├──────────────────────────────────────┤
│                                      │
│  [Step-specific content]             │
│                                      │
├──────────────────────────────────────┤
│  [  BACK  ]     [  CONTINUE →  ]    │  Two buttons at bottom
│   Ghost          Primary Navy        │
└──────────────────────────────────────┘
```

---

### Step 1 — Project Type

```
│  What are you                        │  Display M: Noto Serif Bold 32px
│  building?                           │
│                                      │
│  ┌──────────────────────────────┐   │  Selection Card (unselected):
│  │                              │   │  White bg, #EDEEEF border, 8px radius
│  │   🏗  NEW CONSTRUCTION       │   │  Icon 32px + title Noto Serif Bold 16px
│  │                              │   │  + subtitle Manrope 14px Body
│  │   Build from raw land using  │   │
│  │   your Krooki number or      │   │
│  │   land dimensions.           │   │
│  └──────────────────────────────┘   │
│                                      │
│  ┌──────────────────────────────┐   │  (Selected card):
│  │                              │   │  Navy bg (#0B1F3A), white text
│  │   🏠  EXISTING RENOVATION    │   │  Gold Light left-side 3px border accent
│  │                              │   │
│  │   Renovate or extend your    │   │
│  │   existing home.             │   │
│  └──────────────────────────────┘   │
```

---

### Step 2 — Land Details (New Construction)

```
│  Tell us about                       │  Display M: Noto Serif Bold 32px
│  your land.                          │
│                                      │
│  ── OR ENTER DIMENSIONS ────         │  Divider with label: Manrope 12px UPPER, muted
│                                      │
│  LAND LENGTH (METERS)                │  Caption label
│  ┌───────────────────────────────┐   │  Numeric input, 2px radius, gold bottom border
│  │  e.g. 20                     │   │
│  └───────────────────────────────┘   │
│                                      │
│  LAND WIDTH (METERS)                 │
│  ┌───────────────────────────────┐   │
│  │  e.g. 15                     │   │
│  └───────────────────────────────┘   │
│                                      │
│  ── OR USE KROOKI NUMBER ───         │  Divider with label
│                                      │
│  KROOKI NUMBER                       │
│  ┌───────────────────────────────┐   │
│  │  e.g. 12345678               │   │
│  └───────────────────────────────┘   │
│  Auto-populates land dimensions      │  Helper: 12px muted, Gold Light link "Learn more"
│  from municipal records.             │
│                                      │
│  ⚠ Advisory Notice (if applicable): │  Warning box: #FEF3C7 bg, #B7791F text
│  "Minimum land area is 150 sqm per   │  12px Manrope, left-aligned icon ⚠
│  SBC 1101."                          │
│                                      │
│  CITY / DISTRICT                     │
│  ┌───────────────────────────────┐   │
│  │  e.g. Riyadh — Al Yasmeen    │   │
│  └───────────────────────────────┘   │
```

---

### Step 3 — Building Requirements

```
│  Design your                         │  Display M: Noto Serif Bold 32px
│  requirements.                       │
│                                      │
│  NUMBER OF FLOORS                    │  Caption label
│  ┌────────────────────────────────┐  │  Stepper: [ − ]  3  [ + ]
│  │   −        3        +          │  │  Navy buttons, number Noto Serif Bold 24px
│  └────────────────────────────────┘  │
│  Maximum 5 floors (SBC 1101).        │  Helper 12px muted
│                                      │
│  ROOM TYPES                          │  Caption label
│  Select all that apply:              │  12px body muted
│                                      │
│  [Bedroom] [Master Bedroom]          │  Chip grid: wrap layout
│  [Guest Room] [Majlis]               │  Unselected: white bg, #EDEEEF border, navy text
│  [Dining Room] [Kitchen]             │  Selected: Navy bg, white text, 12px radius
│  [Living Room] [Driver Room]         │  Tap to toggle
│  [Maid Room] [Storage]               │
│  [Laundry Room]                      │
│                                      │
│  GARDEN PREFERENCE                   │  Caption label
│                                      │
│  ┌──────────┐ ┌──────────┐ ┌──────┐ │  3 selection cards horizontal scroll
│  │   None   │ │Minimalist│ │Trad. │ │  Each: icon + label below
│  └──────────┘ └──────────┘ └──────┘ │  Selected: Navy border + gold light icon
│                                      │
│  GARAGE                              │  Caption label
│  ○ None  ● 1 Space  ○ 2+ Spaces     │  Radio-style selection
```

---

### Step 4 — Design Preferences

```
│  Your design                         │  Display M: Noto Serif Bold 32px
│  style.                              │
│                                      │
│  ARCHITECTURAL STYLE                 │  Caption label
│  Choose one:                         │
│                                      │
│  ←  [Modern] [Neoclassical]          │  Horizontal scroll cards (160×100px each)
│     [Contemporary Arabic]            │  Background: architectural reference image
│     [Classic] [Minimalist]  →        │  Dark navy gradient overlay bottom
│                                      │  Style name: Manrope ExtraBold 10px UPPER Gold Light
│                                      │  Selected card: Gold Light 2px border around
│                                      │
│  SMART HOME INTEGRATION              │  Caption label
│  ┌──────────────┐ ┌──────────────┐  │  Two toggle chips
│  │  ✓  Yes      │ │     No       │  │
│  └──────────────┘ └──────────────┘  │
│                                      │
│  SPECIAL REQUIREMENTS                │  Caption label
│  ┌───────────────────────────────┐   │  Multi-line text input
│  │  Any specific requests,       │   │  4 lines visible, 2px radius
│  │  materials or notes...        │   │  Gold bottom border on focus
│  │                               │   │
│  └───────────────────────────────┘   │
│  Optional                            │  12px muted helper
```

---

### Step 5 — Media Upload

```
│  Upload your                         │  Display M: Noto Serif Bold 32px
│  documents.                          │
│                                      │
│  LAND PHOTOS                         │  Caption label
│  Helps our engineers understand      │  12px muted
│  the site.                           │
│                                      │
│  ┌───────┐ ┌───────┐ ┌───────────┐  │  Photo grid: 3-column
│  │[img1] │ │[img2] │ │  +  ADD   │  │  Each thumbnail: 8px radius, ×  delete badge
│  │  ×    │ │  ×    │ │  PHOTOS   │  │  "ADD" tile: dashed #EDEEEF border, + icon
│  └───────┘ └───────┘ └───────────┘  │  Gold Light + icon (24px), "ADD PHOTOS" 10px
│                                      │
│  ─────────────────────────────────   │
│                                      │
│  REFERENCE IMAGES (Optional)         │  Caption label
│  Inspiration images for your         │  12px muted
│  preferred style.                    │
│                                      │
│  ┌───────────────────────────────┐   │  Single large upload area
│  │   ↑   UPLOAD REFERENCES      │   │  Dashed border, centered content
│  │   Up to 5 images             │   │  Manrope 14px Navy
│  └───────────────────────────────┘   │
│                                      │
│  JPEG, PNG, PDF · Max 10MB each      │  12px muted caption
```

---

### Review & Submit Screen (after step 5)

```
┌──────────────────────────────────────┐
│  ←  Review & Submit                  │
├──────────────────────────────────────┤
│                                      │
│  Review your                         │  Display M: Noto Serif Bold 32px
│  submission.                         │
│                                      │
│  ┌──────────────────────────────┐   │  Summary card (white, border, 8px radius)
│  │  PROJECT TYPE                │   │  Row label: Caption 10px muted UPPER
│  │  New Construction            │   │  Row value: Body M 14px Navy
│  │  ─────────────────────────   │   │  Divider between rows
│  │  LAND DIMENSIONS             │   │
│  │  20m × 15m  (300 sqm)        │   │
│  │  ─────────────────────────   │   │
│  │  FLOORS                      │   │
│  │  3 Floors                    │   │
│  │  ─────────────────────────   │   │
│  │  ROOMS                       │   │
│  │  Master, 3× Bedroom, Majlis  │   │
│  │  ─────────────────────────   │   │
│  │  STYLE                       │   │
│  │  Contemporary Arabic         │   │
│  │  ─────────────────────────   │   │
│  │  SMART HOME                  │   │
│  │  Yes — Advanced              │   │
│  │  ─────────────────────────   │   │
│  │  MEDIA                       │   │
│  │  3 land photos uploaded      │   │
│  └──────────────────────────────┘   │
│                                      │
│  ┌──────────────────────────────┐   │  Terms checkbox card
│  │  ☐  I confirm all details    │   │  Checkbox + Manrope 14px
│  │     are accurate.            │   │
│  └──────────────────────────────┘   │
│                                      │
│  [    SUBMIT REQUEST  →    ]         │  Full-width Navy primary button
└──────────────────────────────────────┘
```

### Success Screen (after submit)
```
┌──────────────────────────────────────┐
│                                      │
│           ✦                          │  Gold Light decorative icon (48px)
│                                      │
│    Request Submitted                 │  Noto Serif Bold 28px, Navy, centered
│                                      │
│    Your project has been created.    │  Body M 16px, centered, muted
│    Our team will review and          │
│    prepare a personalised quote.     │
│                                      │
│    PROJECT ID                        │  Caption 10px UPPER, Gold Light
│    ARC-2026-00013                    │  Noto Serif Bold 20px, Navy
│                                      │
│    ESTIMATED RESPONSE                │  Caption 10px UPPER muted
│    Within 24–48 hours                │  Body M Navy
│                                      │
│  [   VIEW MY PROJECT   ]             │  Primary button → project detail
│  [   BACK TO HOME      ]             │  Ghost button
└──────────────────────────────────────┘
```

---

## Screen 4 — Project Detail (Stage Hub)

**This is one screen that adapts per project stage. Design as a single base layout with 8 stage-specific content panel variants.**

### Base Layout
```
┌──────────────────────────────────────┐
│  ←  Al-Yasmeen Estate    [SHARE]    │  App bar: project name + share icon
│                                      │
│  ARC-2026-00012                      │  Project ID: 8px Manrope Bold muted UPPER
│  AWAITING PRICING          [badge]   │  Status badge: Gold Light color
├──────────────────────────────────────┤
│                                      │
│  PROJECT TIMELINE                    │  Section label 10px UPPER muted
│                                      │
│  ●  Awaiting Pricing        ←ACTIVE  │  Timeline stepper (vertical, left-aligned)
│  │                                   │  Active: Gold Light filled dot + label Navy Bold
│  ○  Awaiting Payment                 │  Done: Navy filled dot + checkmark
│  │                                   │  Future: #EDEEEF dot + muted label
│  ○  Payment Under Review             │
│  │                                   │
│  ○  Awaiting Engineering             │
│  │                                   │
│  ○  Deliverables Ready               │
│  │                                   │
│  ○  Completed                        │
│                                      │
├──────────────────────────────────────┤
│                                      │
│  [STAGE-SPECIFIC CONTENT PANEL]      │  See 8 variants below
│                                      │
├──────────────────────────────────────┤
│  [STAGE-SPECIFIC CTA BUTTON]         │  Full-width primary or ghost
└──────────────────────────────────────┘
```

---

### Stage Panel A — Awaiting Pricing
```
│  ┌──────────────────────────────┐   │  Info card: white, border, 8px radius
│  │   🕐  Under Review           │   │  Icon + label: Manrope Bold 14px Navy
│  │                              │   │
│  │   Our team is reviewing      │   │  Body M muted
│  │   your requirements and      │   │
│  │   preparing a personalised   │   │
│  │   quote for your project.    │   │
│  │                              │   │
│  │   ESTIMATED                  │   │  Caption UPPER muted
│  │   24–48 hours                │   │  Body M Navy Bold
│  └──────────────────────────────┘   │
│                                      │
│  No action required at this stage.  │  12px muted, centered, italic
```
*No CTA button for this stage.*

---

### Stage Panel B — Awaiting Payment
```
│  ┌──────────────────────────────┐   │  Quote card: white, border, 8px radius
│  │  QUOTE DETAILS               │   │  Caption 10px UPPER Gold Light
│  │                              │   │
│  │  Phase I — Blueprinting      │   │  Row: label 12px muted | amount 14px Navy
│  │                  SAR 12,000  │   │
│  │  ─────────────────────────   │   │
│  │  Complexity Adjustment       │   │
│  │                    SAR 2,000 │   │
│  │  ─────────────────────────   │   │
│  │  TOTAL                       │   │  Bold divider row
│  │                  SAR 14,000  │   │  Noto Serif Bold 24px Navy
│  │                              │   │
│  │  Valid until: 15 Dhul Hijjah │   │  12px muted. Hijri date
│  │  Invoice: ARC-INV-00013      │   │  12px muted
│  └──────────────────────────────┘   │
│                                      │
│  ┌──────────────────────────────┐   │  Bank transfer details card
│  │  PAYMENT INSTRUCTIONS        │   │  Caption 10px UPPER Gold Light
│  │                              │   │
│  │  Bank         Al Rajhi Bank  │   │  Label/value rows, 12px muted / 14px Navy
│  │  Account     Arcova Company  │   │
│  │  IBAN      SA12 3456 7890…   │   │  IBAN with copy icon
│  │  Reference   ARC-INV-00013   │   │  Bold, with copy icon — MUST include in transfer
│  └──────────────────────────────┘   │
│                                      │
│  [  UPLOAD PAYMENT RECEIPT  →  ]    │  Primary Navy button
```

---

### Stage Panel C — Payment Under Review
```
│  ┌──────────────────────────────┐   │
│  │  ✓  Receipt Submitted        │   │  Success-tinted card: #F0FFF4 bg, #1A7A4A border
│  │                              │   │  Icon + title Noto Serif Bold 16px
│  │  Your payment receipt has    │   │  Body M muted
│  │  been submitted and is       │   │
│  │  being verified by our       │   │
│  │  finance team.               │   │
│  │                              │   │
│  │  Submitted:  12 Jun 2026     │   │  Caption rows
│  │  Reference:  REF-987654321   │   │
│  └──────────────────────────────┘   │
│                                      │
│  SUBMITTED RECEIPT                   │  Caption UPPER muted
│  ┌──────────────────────────────┐   │  Receipt thumbnail (blurred for privacy)
│  │  [receipt image thumbnail]   │   │  White card, 8px radius, 8px image radius
│  └──────────────────────────────┘   │
│                                      │
│  [  UPLOAD ADDITIONAL RECEIPT  ]    │  Ghost button (secondary)
```

---

### Stage Panel D — Awaiting Engineering Assignment
```
│  ┌──────────────────────────────┐   │
│  │  ✓  Payment Approved         │   │  #F0FFF4 success card
│  │                              │   │
│  │  Your project is being       │   │
│  │  matched with a specialist   │   │
│  │  engineer based on your      │   │
│  │  architectural style.        │   │
│  │                              │   │
│  │  STYLE MATCH                 │   │  Caption UPPER Gold Light
│  │  Contemporary Arabic         │   │  Body M Navy Bold
│  └──────────────────────────────┘   │
```
*No CTA button.*

---

### Stage Panel E — Awaiting Engineering
```
│  ┌──────────────────────────────┐   │  Assigned engineer card
│  │  YOUR ENGINEER               │   │  Caption UPPER Gold Light
│  │                              │   │
│  │  [avatar 48px]               │   │  Engineer avatar (circle, 12px radius)
│  │  Eng. Ahmad Al-Harbi         │   │  Noto Serif Bold 16px
│  │  Specialisation: Modern      │   │  12px muted
│  │                              │   │
│  │  ●  Work in progress         │   │  Animated gold dot + label
│  └──────────────────────────────┘   │
│                                      │
│  ESTIMATED COMPLETION                │  Caption UPPER muted
│  10–15 business days                 │  Body M Navy
```
*No CTA button.*

---

### Stage Panel F — Deliverables Ready
```
│  ┌──────────────────────────────┐   │  Success banner
│  │  ✦  Deliverables Ready       │   │  Gold Light icon + Noto Serif Bold 16px
│  │  Your blueprints and renders │   │  Body M muted
│  │  are ready to view.          │   │
│  └──────────────────────────────┘   │
│                                      │
│  WHAT'S INCLUDED                    │  Caption UPPER muted
│                                      │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌────┐ │  4 type chips horizontal:
│  │  PDF │ │ CAD  │ │ 3D   │ │ MP4│ │  Each: icon + label, white bg border chip
│  │  ×3  │ │  ×2  │ │  ×8  │ │ ×1 │ │  Count badge in Gold Light
│  └──────┘ └──────┘ └──────┘ └────┘ │
│                                      │
│  [  VIEW DELIVERABLES  →  ]         │  Primary Navy button
│  [  REQUEST REVISION    ]           │  Ghost button below
```

---

### Stage Panel G — Revision In Progress
```
│  ┌──────────────────────────────┐   │
│  │  ↻  Revision In Progress     │   │  Warning-tinted: #FFFBEB bg, #B7791F border
│  │                              │   │
│  │  The engineer is working on  │   │
│  │  your revision request.      │   │
│  │                              │   │
│  │  REVISION NOTES              │   │  Caption UPPER muted
│  │  "Please widen the Majlis    │   │  Body M Navy (customer's note)
│  │  entrance and adjust the     │   │
│  │  north-facing elevation."    │   │
│  │                              │   │
│  │  Submitted: 14 Jun 2026      │   │  Caption muted
│  │  Free revisions left: 1      │   │  Caption Gold Light
│  └──────────────────────────────┘   │
```
*No CTA. Customer waits.*

---

### Stage Panel H — Completed
```
│  ┌──────────────────────────────┐   │  Completion card: Navy bg
│  │  ✦  Project Complete         │   │  Gold Light icon + white text
│  │                              │   │
│  │  All deliverables have been  │   │  White body text
│  │  finalised and archived.     │   │
│  └──────────────────────────────┘   │
│                                      │
│  ┌──────────────────────────────┐   │  Phase II upsell card: Gold Light border
│  │  READY FOR PHASE II?         │   │  Caption UPPER Gold Light
│  │                              │   │
│  │  Transform your blueprints   │   │  Body M muted
│  │  into stunning 3D interior   │   │
│  │  and exterior designs.       │   │
│  └──────────────────────────────┘   │
│                                      │
│  [  DOWNLOAD ALL FILES  →  ]        │  Primary Navy button
│  [  REQUEST INTERIOR DESIGN ]       │  Gold Light ghost button
```

---

## Screen 5 — Payment Upload

**Route:** From "Upload Payment Receipt" CTA on project detail.

```
┌──────────────────────────────────────┐
│  ←  Upload Receipt                   │
├──────────────────────────────────────┤
│                                      │
│  Payment                             │  Display M: Noto Serif Bold 32px
│  Verification                        │
│                                      │
│  Upload proof of your bank           │  Body M muted
│  transfer to unlock your project.    │
│                                      │
│  ┌──────────────────────────────┐   │  Amount reminder card: Navy bg, 8px radius
│  │  AMOUNT DUE                  │   │  Caption UPPER Gold Light
│  │  SAR 14,000                  │   │  Noto Serif Bold 28px white
│  │  Ref: ARC-INV-00013          │   │  12px white muted
│  └──────────────────────────────┘   │
│                                      │
│  TRANSFER REFERENCE NUMBER           │  Caption label
│  ┌───────────────────────────────┐   │
│  │  e.g. 123456789              │   │  Text input, gold bottom border focus
│  └───────────────────────────────┘   │
│                                      │
│  TRANSFER DATE                       │  Caption label
│  ┌───────────────────────────────┐   │
│  │  14 Dhul Hijjah 1447         │   │  Date picker field, calendar icon right
│  └───────────────────────────────┘   │
│                                      │
│  RECEIPT IMAGE(S)                    │  Caption label
│  JPEG, PNG or PDF · Max 10MB each    │  12px muted helper
│                                      │
│  ┌──────────────────────────────┐   │  Upload area: dashed #EDEEEF border
│  │   ↑                          │   │  8px radius, centered
│  │   UPLOAD RECEIPT             │   │  Manrope Bold 14px Navy
│  │   Tap to upload              │   │  12px muted
│  └──────────────────────────────┘   │
│                                      │
│  ┌───────┐ ┌───────┐               │  Uploaded thumbnails grid (if any)
│  │[img1] │ │[img2] │               │  Each: 8px radius, ×  delete
│  │  ×    │ │  ×    │               │
│  └───────┘ └───────┘               │
│                                      │
│  [  SUBMIT RECEIPT  →  ]            │  Full-width primary Navy button
└──────────────────────────────────────┘
```

---

## Screen 6 — Engineering Deliverables

```
┌──────────────────────────────────────┐
│  ←  Deliverables                     │
│  Al-Yasmeen Estate                   │  Subtitle: project name, 14px muted
├──────────────────────────────────────┤
│                                      │
│  CONSTRUCTION BLUEPRINTS             │  Section header: Caption UPPER Gold Light
│                                      │
│  ┌──────────────────────────────┐   │  File row card: white, border, 8px radius
│  │  [PDF]  Floor Plan v1.1      │   │  Type badge + filename Noto Serif 14px
│  │         2.4 MB  ·  v1.1      │   │  Size + version: 12px muted
│  │                     [↓] [👁] │   │  Download + Preview icons: Gold Light
│  └──────────────────────────────┘   │
│  ┌──────────────────────────────┐   │
│  │  [PDF]  Structural Plan v1.0 │   │
│  │         3.1 MB  ·  v1.0      │   │
│  │                   [✓Downloaded]│  │  Downloaded state: Gold Light checkmark
│  └──────────────────────────────┘   │
│                                      │
│  3D RENDERS                          │  Section header: Caption UPPER Gold Light
│                                      │
│  ┌───────┐ ┌───────┐ ┌───────┐     │  Image thumbnails 3-up grid
│  │[img]  │ │[img]  │ │[img]  │     │  8px radius, overlay "4K" badge top-right
│  │       │ │       │ │       │     │  Tap → full-screen viewer
│  └───────┘ └───────┘ └───────┘     │
│                                      │
│  VIDEO WALKTHROUGHS                  │  Section header
│                                      │
│  ┌──────────────────────────────┐   │  Video row card
│  │  [▶]  3D Walkthrough v1.0    │   │  Play icon + filename
│  │         89 MB  ·  MP4        │   │
│  │                     [↓] [▶] │   │
│  └──────────────────────────────┘   │
│                                      │
│  [  DOWNLOAD ALL  (247 MB)  ]       │  Ghost/secondary full-width button
│  [  REQUEST REVISION          ]     │  Text button, Gold Light color
└──────────────────────────────────────┘
```

---

## Screen 7 — Revision Request

```
┌──────────────────────────────────────┐
│  ←  Request Revision                 │
├──────────────────────────────────────┤
│                                      │
│  Request a                           │  Display M: Noto Serif Bold 32px
│  Revision                            │
│                                      │
│  ┌──────────────────────────────┐   │  Allowance card: white, Gold Light border
│  │  FREE REVISIONS REMAINING    │   │  Caption UPPER Gold Light
│  │  2                           │   │  Noto Serif Bold 40px Navy
│  │  of 3 included revisions     │   │  12px muted
│  └──────────────────────────────┘   │
│                                      │
│  REVISION CATEGORY                   │  Caption label
│  Select all that apply:              │  12px muted
│                                      │
│  [Layout] [Materials] [Dimensions]  │  Chip grid: same style as step 3 room chips
│  [Structural] [Exterior] [Interior] │
│                                      │
│  REVISION DETAILS                    │  Caption label
│  ┌───────────────────────────────┐   │  Multi-line text input
│  │  Describe the changes you     │   │  4 lines, 2px radius
│  │  need in detail...            │   │  Gold bottom border on focus
│  │                               │   │
│  │                               │   │
│  └───────────────────────────────┘   │
│                                      │
│  REFERENCE DELIVERABLE               │  Caption label
│  ┌───────────────────────────────┐   │  Dropdown select
│  │  Floor Plan v1.1          ▾   │   │  Navy text, chevron right
│  └───────────────────────────────┘   │
│                                      │
│  ATTACH REFERENCES (Optional)        │  Caption label
│  ┌──────────────────────────────┐   │  Small upload area
│  │   +  ADD ANNOTATED IMAGES   │   │  Dashed border, 8px radius
│  └──────────────────────────────┘   │
│                                      │
│  [  SUBMIT REVISION REQUEST  →  ]   │  Full-width Navy primary button
└──────────────────────────────────────┘
```

### Zero Free Revisions State
Replace allowance card with:
```
│  ┌──────────────────────────────┐   │  Warning card: #FFFBEB bg, #B7791F border
│  │  ⚠  No Free Revisions Left   │   │
│  │                              │   │
│  │  Additional revisions are    │   │
│  │  available as a paid add-on. │   │
│  │                              │   │
│  │  PAID REVISION COST          │   │
│  │  SAR 1,500                   │   │  Noto Serif Bold 20px Navy
│  └──────────────────────────────┘   │
```

---

## Screen 8 — Phase II Request (Interior Design)

```
┌──────────────────────────────────────┐
│  ←  Interior Design                  │
├──────────────────────────────────────┤
│                                      │
│  [Full-width hero image — 260px]     │  Luxury interior design photo
│  Navy gradient overlay bottom 50%    │  "PHASE II" badge top-left: Gold Light chip
│                                      │
├──────────────────────────────────────┤
│                                      │
│  Transform Your                      │  Display M: Noto Serif Bold 32px Navy
│  Blueprint                           │
│                                      │
│  Your architectural plans are        │  Body M muted
│  complete. Now bring them to         │
│  life with immersive 3D interior     │
│  and exterior design.                │
│                                      │
│  PHASE II INCLUDES                   │  Caption UPPER Gold Light
│                                      │
│  ┌─────────────────┐ ┌────────────┐ │  2-column feature cards
│  │  🎨  3D Renders  │ │ 🎬  Video  │ │  White, border, 8px radius
│  │  4K interior     │ │ Walkthrough│ │  Icon 24px + Manrope Bold 12px + 10px muted
│  │  & exterior      │ │ & tours    │ │
│  └─────────────────┘ └────────────┘ │
│  ┌─────────────────┐ ┌────────────┐ │
│  │  🛋  Procurement │ │ ↻  Up to   │ │
│  │  Curated links   │ │ 3 free     │ │
│  │  to materials    │ │ revisions  │ │
│  └─────────────────┘ └────────────┘ │
│                                      │
│  LINKED TO                           │  Caption UPPER muted
│  ARC-2026-00012 · Al-Yasmeen        │  12px muted · Noto Serif 14px Navy Bold
│                                      │
│  [  REQUEST INTERIOR DESIGN  →  ]   │  Full-width Navy primary button
│  [  I'll do this later         ]    │  Ghost text button
└──────────────────────────────────────┘
```

---

## Screen 9 — Portfolio / Explore Gallery

```
┌──────────────────────────────────────┐
│  ←  Explore Designs                  │
├──────────────────────────────────────┤
│                                      │
│  ← [All] [Exterior] [Modern]         │  Filter chips: horizontal scroll
│     [Traditional] [Interior]  →      │  Same chip style as other screens
│                                      │
│  ┌──────────────────────────────┐   │  Large hero card: 200px height
│  │  [full-width image]          │   │  Navy gradient overlay bottom
│  │  NEOCLASSICISM               │   │  Category: 8px ExtraBold UPPER Gold Light
│  │  The Grand Residence         │   │  Title: Noto Serif SemiBold 16px white
│  └──────────────────────────────┘   │
│                                      │
│  ┌──────────────┐ ┌──────────────┐  │  2-column grid: equal width
│  │  [image]     │ │  [image]     │  │  Square cards, 8px radius
│  │  MODERNISM   │ │  TRADITIONAL │  │  Overlay with category + title
│  │  Glass Villa │ │  Al-Omran   │  │
│  └──────────────┘ └──────────────┘  │
│                                      │
│  ┌──────────────────────────────┐   │  Another large card
│  │  [full-width image]          │   │
│  │  CONTEMPORARY                │   │
│  │  Desert Pavilion             │   │
│  └──────────────────────────────┘   │
│                                      │
│  ┌──────────────┐ ┌──────────────┐  │  More grid items
│  │  [image]     │ │  [image]     │  │
│  └──────────────┘ └──────────────┘  │
└──────────────────────────────────────┘
```

### Portfolio Detail Screen (tap on any item)
```
┌──────────────────────────────────────┐
│  ←                       [⬆ SHARE]  │
│                                      │
│  [Full-screen image carousel]        │  Swipeable image gallery
│  ● ○ ○ ○ ○ ○ ○ ○                   │  Dots indicator: Gold Light active
│                                      │
├──────────────────────────────────────┤
│  CONTEMPORARY ARABIC                 │  Category: 10px ExtraBold UPPER Gold Light
│  The Al-Rashidi Residence            │  Title: Noto Serif Bold 24px Navy
│                                      │
│  Riyadh · 450 sqm · 4 Floors        │  12px muted · dividers
│                                      │
│  ─────────────────────────────────   │
│                                      │
│  A grand contemporary Arabic         │  Body M 16px muted
│  estate featuring carved stone       │
│  facades and a central courtyard.    │
│                                      │
│  ────────────────────────────────    │
│                                      │
│  [ ▶  WATCH WALKTHROUGH ]           │  Gold Light ghost button
│  [  LIKE THIS STYLE? START PROJECT ]│  Primary Navy button
└──────────────────────────────────────┘
```

---

## Screen 10 — Notifications

```
┌──────────────────────────────────────┐
│  Notifications         [Mark all ✓] │  App bar + right action: 12px Gold Light
├──────────────────────────────────────┤
│                                      │
│  TODAY                               │  Date group: Caption 10px UPPER Gold Light
│  ─────────────────────────────────   │
│                                      │
│  ┌──────────────────────────────┐   │  Notification row: white, no border
│  │  [●] DELIVERABLES READY      │   │  Unread: Gold Light 6px dot left
│  │      Al-Yasmeen Estate       │   │  Type badge: 10px ExtraBold UPPER
│  │      Your blueprints are     │   │  Project name: Noto Serif Bold 14px
│  │      ready to view.          │   │  Body: Manrope 14px muted
│  │                    2 min ago │   │  Time: 12px muted, right-aligned
│  └──────────────────────────────┘   │
│  ─────────────────────────────────   │  Thin divider between rows
│  ┌──────────────────────────────┐   │
│  │     PAYMENT APPROVED         │   │  Read state: no dot, slightly muted row
│  │      Al-Nakheel Villa        │   │
│  │      Your payment has been   │   │
│  │      verified.               │   │
│  │                    1 hr ago  │   │
│  └──────────────────────────────┘   │
│                                      │
│  THIS WEEK                           │  Group label
│  ─────────────────────────────────   │
│  [more notification rows...]         │
│                                      │
│  EARLIER                             │
│  ─────────────────────────────────   │
│  [more rows...]                      │
└──────────────────────────────────────┘
```

### Notification Type Colors
| Type | Badge Color |
|------|------------|
| DELIVERABLES READY | `#1A7A4A` Success |
| PAYMENT APPROVED | `#1A7A4A` Success |
| PAYMENT REJECTED | `#C0392B` Error |
| REVISION UPDATE | `#B7791F` Warning |
| STAGE CHANGE | `#C8A96A` Gold Light |
| QUOTE READY | `#C8A96A` Gold Light |

### Empty State
```
  Center: Bell icon (48px muted) + "No Notifications" + "You're all caught up."
```

---

## Screen 11 — Profile

```
┌──────────────────────────────────────┐
│  Profile                   [EDIT]    │  App bar + Edit link: Gold Light 14px
├──────────────────────────────────────┤
│                                      │
│         [Avatar 80px]                │  Circular, 12px border Gold Light
│         CHANGE PHOTO                 │  12px Gold Light below avatar
│                                      │
│  Mohab Al-Rashidi                    │  Noto Serif Bold 22px Navy, centered
│  +966 5X XXX XXXX                   │  14px muted, centered
│                                      │
│  ┌──────────────────────────────┐   │  KYC badge card: #F0FFF4, #1A7A4A border
│  │  ✓  Identity Verified        │   │  Success icon + 14px Navy Bold
│  └──────────────────────────────┘   │
│                                      │
│  ─────────────────────────────────   │
│                                      │
│  EMAIL                               │  Caption UPPER muted
│  mohab@email.com                     │  Body M Navy
│                                      │
│  LANGUAGE                            │  Caption UPPER muted
│  English                             │  Body M Navy
│                                      │
│  MEMBER SINCE                        │  Caption UPPER muted
│  Rajab 1447 · May 2026              │  Body M Navy, Hijri + Gregorian
│                                      │
│  ACTIVE PROJECTS                     │  Caption UPPER muted
│  2 of 3 maximum                      │  Body M Navy
└──────────────────────────────────────┘
```

---

## Screen 12 — Settings

```
┌──────────────────────────────────────┐
│  Settings                            │
├──────────────────────────────────────┤
│                                      │
│  PREFERENCES                         │  Section label: Caption UPPER Gold Light
│                                      │
│  ┌──────────────────────────────┐   │  Settings card: white, border, 8px radius
│  │  Language                    │   │  Label 14px Navy | Value 14px muted | ›
│  │  English                   › │   │
│  │  ─────────────────────────   │   │
│  │  Calendar Format             │   │
│  │  Hijri (default)           › │   │
│  │  ─────────────────────────   │   │
│  │  Notifications               │   │
│  │  All enabled          [ ON ] │   │  Toggle: Navy when on, grey when off
│  └──────────────────────────────┘   │
│                                      │
│  SUPPORT                             │  Section label: Caption UPPER Gold Light
│                                      │
│  ┌──────────────────────────────┐   │
│  │  Contact Support           › │   │
│  │  ─────────────────────────   │   │
│  │  Privacy Policy            › │   │
│  │  ─────────────────────────   │   │
│  │  Terms of Service          › │   │
│  └──────────────────────────────┘   │
│                                      │
│  ABOUT                               │  Section label: Caption UPPER Gold Light
│                                      │
│  ┌──────────────────────────────┐   │
│  │  Version 1.0.0 (Build 1)     │   │  12px muted, no chevron
│  └──────────────────────────────┘   │
│                                      │
│  ─────────────────────────────────   │
│                                      │
│  [  LOG OUT  ]                       │  Full-width error-colored ghost button
│                                      │  #C0392B text, #C0392B border, 2px radius
└──────────────────────────────────────┘
```

---

## Shared Components to Design

### Bottom Navigation Bar (4 tabs)
```
┌──────────────────────────────────────┐
│  [🏠]      [📁]      [↻]      [👤] │
│  Home    Projects  Revisions  Profile │  10px Manrope Bold UPPER
│  ●                                   │  Active: Navy icon + Gold Light dot
└──────────────────────────────────────┘
```
- Height: **64px**
- Background: `#F8F9FA`
- Top border: 1px `#EDEEEF`
- Active icon + label: `#0B1F3A`
- Active indicator: 2px Gold Light line above icon
- Inactive: `#44474D` 60% opacity

---

### SBC Warning Banner (reused in project wizard)
```
┌──────────────────────────────────────┐
│  ⚠  Advisory Notice                  │  #B7791F icon + Bold 12px
│  Minimum land area is 150 sqm (SBC   │  12px muted body
│  1101). Our engineers will confirm.  │
└──────────────────────────────────────┘
Background: #FFFBEB · Border: 1px #B7791F · Radius: 8px
```

---

### Empty State (reusable)
```
         [Icon — 48px, muted]
         
         No [Content] Yet              Noto Serif Bold 20px Navy
         
         [Contextual subtitle]         Body M muted, centered, max 2 lines
         
         [  ACTION BUTTON  ]           Primary Navy, only if actionable
```

---

### Loading Skeleton (reusable shimmer)
All list items: replace content with grey shimmer rectangles matching the real item layout.  
Shimmer: `#EDEEEF` → `#F8F9FA` animated gradient, left to right.

---

## Design Notes for Stitch

1. **Button radius is 2px** — this is intentional and defines the architectural character of the brand. Do not round buttons.
2. **Gold Light (`#C8A96A`) is the interactive accent** — not the darker gold `#735B24`. The dark gold only appears in display headings.
3. **Noto Serif** for all headings, display text, project names, section titles. **Manrope** for all body text, labels, buttons, captions.
4. **Background is never pure white** — it is always `#F8F9FA` (off-white). Cards are pure white.
5. **Input style:** Bottom-border only when active/focused (Gold Light), no border at rest. OTP boxes are the exception (full border all states).
6. **Status text is always uppercase** with extra letter spacing — it reads like a luxury editorial badge.
7. **Section headers** follow the pattern: Left = Noto Serif Bold 20px Navy | Right = Manrope ExtraBold 10px Gold Light UPPERCASE ("VIEW ALL", "GALLERY")
8. **The app has no tab bar titles** on the Bottom Nav — icons + short labels only, clean and minimal.
9. **Spacing is generous** — sections have 32px between them. Cards have 16px gaps. This creates the luxury breathing room.
10. **Imagery** should be architectural photography (not illustration): bold Saudi villas, glass facades, desert landscapes, luxury interiors. Dark and dramatic.
