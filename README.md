# Main Street Dental — attendance site

One page. Players tap the link, tap their name once, then tap **I'm in / Maybe / I'm out**.
No app, no login. Anyone with the link can change anything.

## Setup (about 10 minutes)

1. **Create the database** — sign in at supabase.com → New project (free plan).
   Open **SQL Editor → New query**, paste all of `schema.sql`, click **Run**.
2. **Connect the page** — in Supabase go to **Project Settings → API** and copy the
   **Project URL** and the **anon / publishable key**. Paste them at the top of the
   `<script>` in `index.html` (`SUPABASE_URL` and `SUPABASE_KEY`).
3. **Put it online (free)** — easiest is Netlify Drop: go to app.netlify.com/drop and
   drag the `msd-attendance` folder onto the page. You get a link like
   `https://something.netlify.app` (you can rename it in Site settings).
   GitHub Pages, Cloudflare Pages or Vercel work too — it's a single static file.
4. Open the link, go to **Manage**, add your players (with roles: starting goalie,
   backup goalie, regular, sub) and the schedule. Share the link in the team chat.

## How it works

- **My games**: each phone remembers who you are. Tap a status; tap it again to clear it.
- **Team**: everyone's status for each game, grouped goalies / regulars / subs, with
  tap-to-call and tap-to-text phone numbers. Anyone can set anyone's status.
- **Header**: next game — goal light is red until a goalie (starting or backup) is In,
  then shows skaters in vs. needed and how many subs to find.
- Changes show up live on everyone's screen.

## Good to know

- Free Supabase projects pause after a week with no activity (e.g. a bye week or
  the off-season). If the page stops loading, open the Supabase dashboard and click
  **Restore project**.
- The anon key in `index.html` is meant to be public, but combined with the open
  database rules it means anyone who finds the link can see and edit the roster,
  including phone numbers. Only share the link with the team.
