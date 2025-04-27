# portfolio

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 📦 Packages Used

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) — State management (used for forms and scalable app state)
- [url_launcher](https://pub.dev/packages/url_launcher) — Open external links (social, project links, email, etc.)
- [flutter_animate](https://pub.dev/packages/flutter_animate) — Micro animations (fade, slide, scale, shimmer, etc.)
- [carousel_slider](https://pub.dev/packages/carousel_slider) — Project screenshots carousel
- [firebase_core](https://pub.dev/packages/firebase_core), [firebase_auth](https://pub.dev/packages/firebase_auth), [cloud_firestore](https://pub.dev/packages/cloud_firestore), etc. — For backend integration (optional)
- [rive](https://pub.dev/packages/rive) — For advanced vector animations (optional)

## 🚀 Automatic Deployment to GitHub Pages (CI/CD)

This project uses **GitHub Actions** for seamless deployment to GitHub Pages every time you push to the `main` branch.

> **Optional:** You can also deploy to **Firebase Hosting**. Just run `flutter build web --release` and deploy the `build/web` folder using the Firebase CLI. See [Firebase Hosting docs](https://firebase.google.com/docs/hosting) for details.

### How it works
- On every push to `main`, the workflow in `.github/workflows/deploy.yml` will:
  1. Check out your code
  2. Set up Flutter
  3. Install dependencies
  4. Build the web app
  5. Deploy the contents of `build/web` to the `gh-pages` branch using [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages)

### No manual steps needed!
- Just push to `main` and your portfolio will be live at:
  `https://<your-github-username>.github.io/<repo-name>/`

---

## 🛠️ CI/CD & Distribution
- **GitHub Actions**: Automated build and deploy for web (see `.github/workflows/deploy.yml`)
- **Firebase App Distribution**: For distributing mobile builds (optional, not enabled by default)
- **MS App Center**: For advanced mobile CI/CD (optional)

---

## 📝 Manual Deployment (Alternative)
If you want to deploy manually:
1. Build the web app:
   ```sh
   flutter build web --release
   ```
2. Copy the contents of `build/web` to a branch named `gh-pages`.
3. In your GitHub repo, go to Settings > Pages, and set the source to the `gh-pages` branch.

---
