# PersianHeritageExplorer – Final Project (CIS 137)

This project implements the **Persian Heritage Explorer** app using **SwiftUI** and **MVVM**.

## Teacher Comment

> Store the description and history information in a JSON file.
> If you want this information to be editable, you may want to use a database (SwiftData).

### How this project follows the comment

- All site information (name, location, era, description, **image name, and number of photos**) is stored in:
  - `Resources/heritage_sites.json`
- The `HeritageViewModel` loads data from this JSON file using `JSONDecoder`.
- Favorites are persisted using `UserDefaults` (simple storage).
- A future version can easily migrate to **SwiftData** by:
  - Creating a SwiftData `@Model` type that mirrors `HeritageSite`
  - Importing the JSON only once into the SwiftData store
  - Replacing the in-memory array with a SwiftData `@Query`.

## Image gallery and `photoCount`

For each site in `heritage_sites.json`:

- `imageName` is the **main image** used:
  - In the Explore cards
  - As the first image in the gallery on the detail screen
- `photoCount` is the **number of additional photos** besides the main image.

The gallery in `SiteDetailView` works like this:

- It always shows at least the main image.
- If `photoCount > 0`, it also tries to load:

  - `imageName_1`
  - `imageName_2`
  - ...
  - `imageName_photoCount`

For example, for Persepolis:

```json
{
  "imageName": "persepolis",
  "photoCount": 2
}
```

The app will look for:

- `persepolis`   (main image)
- `persepolis_1` (extra)
- `persepolis_2` (extra)

Just drag your images into **Assets.xcassets** with these exact names.

## Files

- `PersianHeritageExplorerApp.swift` – App entry
- `ContentView.swift` – TabView with three main tabs
- `Model/HeritageSite.swift` – Model struct (includes `photoCount`)
- `ViewModel/HeritageViewModel.swift` – Loads JSON + handles favorites
- `Views/ExploreView.swift` – List of sites
- `Views/SiteDetailView.swift` – Detail view with:
  - Image gallery using `TabView` and `tabViewStyle(.page)`
  - Favorite button with animation
- `Views/FavoritesView.swift` – Favorites tab
- `Views/TimelineView.swift` – Simple animated historical timeline
- `Resources/heritage_sites.json` – Main data source for the app

## App Icon

Create an app icon in Figma following the instructor's video and add it to the Xcode asset catalog (`Assets.xcassets/AppIcon.appiconset`).
