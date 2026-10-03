# SUMARGA real two-mobile prototype

## Outcome
Turn the current static story into a real two-sided, mobile-first demo where two authenticated people can exchange one live assistance request across separate phones.

## Build
- Rename the product and interface copy from SANCHARI to SUMARGA.
- Add email/password sign up, login, logout, and post-login role/profile setup for Traveller or Margadarshi.
- Store only minimal temporary profile and assistance data, with automatic expiry and deletion instead of permanent history.
- Replace predefined people and requests with session-derived names, languages, roles, and traveller-entered request details.
- Add the Traveller request form, actual AI extraction from free text, structured confirmation, and live waiting/accepted/active/completed states.
- Add the Margadarshi online toggle, real incoming request feed, accept/decline/start/complete actions, and synchronized status updates.
- Show the authenticated Margadarshi profile only after acceptance; keep safety, rating, review, and AI fallback screens tied to the live request.
- Preserve the established playful wayfinding visual system while removing the presentation-only screen navigator and hardcoded demo story.

## Technical details
- Enable Lovable Cloud for authentication and the shared relay required by two physical devices.
- Use authenticated row-level access and realtime subscriptions for profile presence, requests, status changes, and reviews.
- Add expiry timestamps and server-side cleanup behavior so demo records are short-lived.
- Use a server function for natural-language request extraction and fallback guidance, returning structured request data rather than fixed examples.
- Verify the full primary flow with two independent browser sessions at mobile dimensions, including acceptance, start, completion, and review.
