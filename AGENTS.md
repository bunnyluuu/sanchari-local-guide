<!-- LOVABLE:BEGIN -->
> [!IMPORTANT]
> This project is connected to [Lovable](https://lovable.dev). Avoid rewriting
> published git history — force pushing, or rebasing/amending/squashing commits
> that are already pushed — as it rewrites history on Lovable's side and the
> user will likely lose their project history.
>
> Commits you push to the connected branch sync back to Lovable and show up in
> the editor, so keep the branch in a working state.
<!-- LOVABLE:END -->

## Project architecture

- Keep `/` as the mobile-first SUMARGA two-sided marketplace app; authenticated devices synchronize through short-lived Cloud records because browser-only state cannot cross physical devices.
- Treat profiles, requests, and reviews as expiring prototype data; never add seeded users, requests, ratings, locations, or assistance history.
