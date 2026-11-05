# My Garden — Project Overview

A mobile app for a family fruit garden in Uzbekistan: two homemade
greenhouses, about 11 kinds of tropical and subtropical fruit, one gardener.

*Status: November 2026. Working release APK, used on a real Android phone.*

---

## The problem

My father grows bananas, papayas, mandarins and other fruit in two homemade
greenhouses (10 × 50 m and 15 × 50 m). Everything was kept in his head:

- **Where each tree is.** The greenhouses are not planted in neat rows, so
  "the third banana on the left" only made sense to him.
- **What was done and when.** Watering, feeding and spraying were not written
  down, so nobody could tell when a tree was last treated.
- **Money.** He sells some of the harvest but never tracked sales or spending,
  so there was no way to tell whether the garden pays for itself.
- **Cold nights.** Uzbek winters are cold. One frosty night in an unheated
  greenhouse can kill tropical trees, and the warning has to come in time.
- **Sick trees.** When leaves turn yellow or get spots there is no
  agronomist nearby to ask what's wrong.

## What the app does

| Need | Feature in the app |
|---|---|
| Where each tree is | **Greenhouse map** to scale. Trees are placed anywhere by tapping, not in rows. The screen turns to landscape on its own. |
| What was done when | **Diary.** Watering, feeding, spraying, pruning, flowering, problems and notes, logged for one tree or a whole greenhouse at once. |
| Money | **Records (Учёт).** Harvest in kg, sales and expenses in so'm, profit by month and year. |
| Cold nights | **Frost warning** on the home screen, from a free weather forecast for the chosen Uzbek city. |
| Sick trees | **Plant doctor (🩺 Диагноз).** Take a photo of a leaf or fruit and the AI says what's wrong and what to do this week. |

Other points:

- **Works offline.** All data stays on the phone. Only the weather and the
  plant doctor need internet.
- **Russian by default**, with English. The AI also answers in the app's language.
- **Simple to use.** Big buttons, emoji for fruit types, and common actions
  one tap away.

## What we achieved

### The app

- **Home screen ("Сад"):** weather and frost level, both greenhouses, last
  care done, money this year, trees about to bear fruit, and recent diary entries.
- **Greenhouse map:**
  - Plant a tree: pick a fruit on the side toolbar, then tap where it stands.
  - Move a tree with long-press and drag, or with the "Move" button.
  - Zoom and pan the map. Undo the last planting.
  - Log an action for the whole greenhouse.
- **Tree card:**
  - Growth stage (seedling → growing → flowering → fruiting), variety and planting date.
  - Photos.
  - Quick action buttons.
  - Full history timeline, including saved diagnoses.
- **Trees list** grouped by fruit type. Fruit types can be added and edited in Settings.
- **Records:** harvest, sale and expense forms; summary by period.
- **Weather:** Open-Meteo forecast (free, no key needed), cached for offline
  use, with a choice of Uzbek cities.
- **Plant doctor:**
  - Photo from the camera or gallery, plus an optional "what worries you?" question.
  - Answer: summary, how urgent it is, up to 3 likely problems with
    confidence and steps to take, and care tips.
  - Saved in the tree's history.
  - Clear Russian messages for no internet, bad photo, too many requests, and so on.
- **Settings:** language, city, fruit types.

### The AI: Google Gemini, free tier

- The app calls **Gemini Flash** directly with the key built in. That's fine
  for a single-family app on the free tier.
- **What the AI gets:** the photo plus context: fruit, variety, stage, outside
  temperature, recent care and the father's question.
- **What comes back:** a fixed JSON shape, so the app always gets a clean,
  structured answer.
- **When Gemini is busy:** the app retries, then switches to a backup model.
- **Bad photos:** if the photo is blurry or not a plant, the AI says how to
  retake it instead of guessing.
- **Switching AI later:** the app talks to an `DiagnosisApi` interface, so a
  different AI (or our own server) can replace Gemini without touching the screens.
- **Server mode:** a ready-made Cloudflare Worker exists in `server/` for
  when the key should leave the phone. It is not needed now.

### Engineering

- **Flutter 3.41** for Android and iOS, a single codebase.
- **Feature-first structure with BLoC/Cubit.** Each feature has its own
  `data/`, `cubit/` and `view/`.
- **Drift (SQLite) database** with migrations. It is at schema version 3; a
  real old database upgrades without losing data.
- **Network layer on dio:**
  - one shared client;
  - typed errors (no connection, timeout, rate limit, …);
  - logs that never print keys or photos.
- **49 automated tests:**
  - database and migrations;
  - money summaries and the home screen;
  - weather;
  - the map logic;
  - the plant doctor, both the Gemini client and the screens;
  - an app smoke test.
- **Size:** about 7,500 lines of app code.
- **Tested on real devices:** iOS simulator, Android emulator and a real
  Android phone (release APK, about 63 MB).

## Problems solved along the way

- **Rows didn't fit the real garden.** The first version used rows, but the
  greenhouses are planted freely. It was rebuilt as a map to scale with
  x/y positions in meters, and the migration converts the old data.
- **Dragging a tree moved the whole map.** Moving a tree now needs a short
  long-press (300 ms), and there is a separate Move mode.
- **Gemini was often overloaded (503 errors).** Added retries and a
  fallback model. The user is told a check can take up to a minute.
- **Raw AI error text was reaching the screen.** Errors are now mapped to
  short, friendly Russian messages.
- **Smaller fixes:**
  - Russian plural forms ("сегодня / вчера / N дней назад").
  - Snackbars hiding buttons.
  - Navigation bar padding.
  - The Mac's disk filling up during builds.

## How to use it (short)

1. **Сад** → tap a greenhouse → choose a fruit on the right → tap the map to place trees.
2. Tap a tree to log watering, feeding and so on, or open its card.
3. **🩺 Диагноз** (on the map menu or the tree card): take a photo → **Проверить** → read the advice.
4. **Учёт**: add harvests, sales and expenses; check the profit.
5. Check the home screen in winter for the frost warning.

Build and setup instructions are in the [README](../README.md). The AI request
format is in [diagnosis_api.md](diagnosis_api.md).

## What's next

**Before daily use:**
- Set a real app ID (for example `uz.mygarden.app`) and a permanent signing
  key, so future updates install over the old version without losing data.
- Add the remaining fruit types.

**Ideas:**
- Phone notifications for frosty nights and care reminders
  ("papaya not fed for 3 weeks").
- Backup and export of data (photos plus database), so a lost phone doesn't
  mean lost records.
- Built-in short care guides per fruit.
- Sync between phones, if more family members start using it.
- Move the AI key to the server (`server/`) if the app is ever shared beyond the family.
