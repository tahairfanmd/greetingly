# Greetingly - Flutter Greeting Card Creator

A responsive Flutter web application for creating personalized greeting cards.

## Included features

- Home screen with occasion shortcuts
- Eight card templates
- Responsive layouts for mobile, tablet and desktop
- Navigation between Home, Templates, Create, Preview and My Cards
- Form validation for recipient, sender and message
- Stateful occasion selection
- Reusable widgets and Material 3 theme
- Entrance and preview animations
- Save cards to an in-memory list during the current app session

## Run in VS Code

1. Extract the ZIP file.
2. Open the extracted `greeting_card_app` folder in VS Code.
3. Open Terminal > New Terminal.
4. Run:

   ```bash
   flutter pub get
   flutter run -d chrome
   ```

If Chrome is not listed as a device, run `flutter devices` and check that Flutter web is enabled.

## Test

```bash
flutter test
```

## Build for web

```bash
flutter build web --release
```

The deployable website files will be generated in `build/web`.

## Deploy to GitHub Pages

1. Create a GitHub repository and push the project source.
2. In the project terminal, build with the repository path as the base href:

   ```bash
   flutter build web --release --base-href "/YOUR_REPOSITORY_NAME/"
   ```

3. Publish the contents of `build/web` using GitHub Pages. You can use the `gh-pages` branch or GitHub Actions.
4. Open the Pages URL and test it.

For a root-domain or Vercel deployment, use the default base href:

```bash
flutter build web --release
```

Then deploy the contents of `build/web` to Vercel as a static site.

## Important notes

- Saved cards are kept in memory only while the app is running. They reset after refresh/restart. Persistent browser storage can be added as an extension.
- This ZIP contains the Flutter app source and web entry files. Flutter generates platform/build support files on your machine when needed.
