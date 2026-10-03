# SUMARGHA

Build a polished mobile-first prototype called:



“SANCHARI – Hyperlocal Companion & On-Demand Guidance Platform”



This is an AI hackathon project.



CORE PROBLEM:

People entering an unfamiliar city often struggle with local transportation, language barriers, finding nearby services, and navigating unfamiliar places.



CORE SOLUTION:

Sanchari connects first-time travellers with verified local companions called “Sancharakudus”.



AI understands the traveller’s natural-language request, extracts their requirements, recommends suitable Sancharakudus based on multiple factors, and provides an AI fallback assistant when no suitable companion is available.



IMPORTANT:

This prototype should focus on the CORE EXPERIENCE, not a generic travel planner.



USER ROLES:



1. TRAVELLER

2. SANCHARAKUDU – VERIFIED LOCAL COMPANION



TRAVELLER FLOW:



Landing Screen

→ Choose Traveller

→ Traveller Dashboard

→ Enter travel/help request

→ AI understands request

→ AI extracts requirements

→ Recommended Sancharakudus

→ View companion profile

→ Send assistance request

→ Companion accepts

→ Active assistance

→ Complete assistance

→ Rating/review

→ AI review analysis



AI FALLBACK FLOW:



Traveller request

→ No suitable Sancharakudu available

→ AI Sancharakudu becomes available

→ AI provides:

- transport guidance

- step-by-step navigation

- language assistance

- nearby essential services



MAIN EXAMPLE:



A student travels from Vizag to Hyderabad/Secunderabad for an interview.



They enter:



“I came to Hyderabad for an interview. I don't know Telugu and I need help getting from Secunderabad Railway Station to my interview location for around 2 hours.”



AI should display:



Current Location:

Secunderabad Railway Station



Destination:

Interview Location



Language:

Telugu



Assistance:

Transport + Navigation + Language



Duration:

2 Hours



Then show:



“AI understood your request ✓”



Then show recommended Sancharakudus.



COMPANION CARD:



Ravi Kumar

⭐ 4.8

✓ Verified

📍 1.2 km away

🗣 Telugu • Hindi • English

✅ 128 completed assists



94% Match



Match reasons:

✓ Language compatible

✓ Nearby

✓ Available

✓ Transport assistance



Button:

“Request Assistance”



CREATE THESE MOBILE SCREENS:



1. Splash Screen

2. Landing Page

3. Role Selection

4. Traveller Dashboard

5. AI Request Input

6. AI Understanding Result

7. AI Companion Recommendations

8. Companion Profile

9. Request Sent / Waiting

10. Active Assistance

11. AI Fallback Assistant

12. Assistance Completed

13. Rating & Review

14. AI Review Analysis

15. Sancharakudu Dashboard

16. Incoming Request

17. Active Sancharakudu Assistance

18. Sancharakudu Profile



DESIGN:



Make it look like a premium modern travel-tech startup.



Use:

- Mobile-first responsive design

- Clean layout

- Modern cards

- Rounded components

- Strong visual hierarchy

- Professional typography

- Subtle animations

- Clear location indicators

- Trust/verification badges

- AI indicators

- Real-time status indicators



Avoid:

- Generic templates

- Excessive gradients

- Overcrowded screens

- Too many features

- Generic chatbot appearance



BRAND:



Name:

SANCHARI



Tagline:

“Your local companion, wherever you go.”



Core message:

“Maps show you where to go. Sanchari helps you get there.”



AI SHOULD BE VISUALLY IMPORTANT:



Show AI processing states such as:



“Understanding your request…”

“Finding the best local companion…”

“Analysing language, location and availability…”



Then show the result.



REAL-TIME EXPERIENCE:



Create a visual assistance status:



Request Sent

↓

Waiting

↓

Accepted

↓

Assistance Active

↓

Completed



Include:

🟢 Live Assistance



SANCHARAKUDU DASHBOARD:



Show:

- Availability toggle

- Incoming requests

- Traveller requirement

- Distance

- Language

- Duration

- Accept

- Decline



PROFILE:



Show:

- Verified status

- Languages

- Service area

- Rating

- Completed assists

- Reviews



SAFETY:



Show prototype UI for:

- Verified Sancharakudu

- Report

- Block

- Emergency

- Assistance history



Do NOT implement real government ID verification.

Use a prototype “Verified” status.



DO NOT BUILD:

- Real payment gateway

- Full Uber-style navigation

- Food delivery

- Complex social network

- Full travel itinerary planner

- Complex admin system



FOCUS ON:



Traveller

→ AI Request Understanding

→ AI Matching

→ Verified Sancharakudu

→ Real-time Assistance

→ Completion

→ Review

→ AI Review Analysis



AND:



No Companion Available

→ AI Fallback Assistance



The prototype should be polished enough for a hackathon judge to understand the product within 2–3 minutes.



IMPORTANT:

Keep the prototype architecture visually compatible with our actual development stack:



Next.js

React

Tailwind CSS

Supabase

REST APIs

WebSockets



The prototype does not need to replace our actual implementation. It should serve as the visual and interaction reference for the development team.

This project was built with [Lovable](https://lovable.dev).

**Live app**: https://sanchari-local-guide.lovable.app

## Build with Lovable

Continue developing this project in the [Lovable editor](https://lovable.dev/projects/ffb55718-61a7-47a0-bd80-282d2a726aa0).

- **Ship faster**: describe what you want to build and Lovable handles the code.
- **Stay in sync**: every change made in Lovable is committed straight to this repository.
- **Full ownership**: this code is yours. Push to `main` on GitHub and your changes sync back into Lovable, ready for your next prompt.

## Development

Prefer working locally? You need Node.js and npm — [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating).

```sh
git clone <this-repository-url>
cd <repository-name>
npm i
npm run dev
```
