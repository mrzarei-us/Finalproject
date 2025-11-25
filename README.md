# PersianHeritageExplorer – Final Project (CIS 137)
Author: **Mohammad Reza Zarei**  
Date: **11/24/2025**

This project implements the **Persian Heritage Explorer** app using **SwiftUI** and the **MVVM** architecture.  
The app lets the user explore key Iranian heritage sites, view a historical timeline, and mark favorite locations.

---

## How the project satisfies the assignment

- Uses **MVVM**:
  - `HeritageSite` in **Model**
  - `HeritageViewModel` in **ViewModel**
  - SwiftUI screens (`ExploreView`, `SiteDetailView`, `TimelineView`, `FavoritesView`) in **Views**
- Implements **navigation** with a `TabView` (Explore / Timeline / Favorites) and `NavigationStack` for detail screens.
- Stores the descriptive and history information in a **JSON file** (`Resources/heritage_sites.json`), as requested in the instructor's comment.
- Supports **persistent state**:
  - Favorite sites are stored in `UserDefaults` so they remain selected between app launches.
- Includes an **app icon** created by the student and wired to the `AppIcon` asset catalog.

---

## Week 16 – Database / SwiftData Connection

The project currently stores data in a JSON file plus `UserDefaults`, but it is designed so it can be migrated to **SwiftData** (Week 16 topic):

- The `HeritageSite` struct can be turned into a `@Model` type.
- On first launch, the app could read `heritage_sites.json` and insert all items into a SwiftData store.
- After migration, `HeritageViewModel` would use a SwiftData `@Query` to read and update sites.
- Favorites would then be stored directly in the database instead of `UserDefaults`.

This design shows an understanding of how to move from simple file-based storage to a real database layer.

---

## Timeline images

The **Timeline** tab shows three major periods:

- Achaemenid Empire  
- Parthian Empire  
- Sassanian Empire  

Each period has:

- A small image on the left
- A colored circle
- A title and years
- A short description

The image assets expected in **Assets.xcassets** are:

- `achaemenid`
- `parthian`
- `sassanian`



---

## Image gallery and `photoCount`

For each site in `heritage_sites.json`:

- `imageName` is the **main image** used:
  - In the Explore card
  - As the first image in the gallery on the detail screen
- `photoCount` is the **number of additional photos** besides the main one.

The gallery in `SiteDetailView` behaves as:

- Always shows at least the main image.
- If `photoCount > 0`, also tries to load:

  - `imageName_1`
  - `imageName_2`
  - ...
  - `imageName_photoCount`

Example – Persepolis:

```json
{
  "imageName": "persepolis",
  "photoCount": 2
}
```

The app will look for:

- `persepolis`   (main)
- `persepolis_1`
- `persepolis_2`


---

## Files (main ones)

- `FinalProject_MohammadReza_ZareiApp.swift` – App entry point
- `ContentView.swift` – Hosts the main `TabView`
- `Model/HeritageSite.swift` – Data model for one heritage site
- `ViewModel/HeritageViewModel.swift` – Loads JSON, exposes data, and handles favorites
- `Views/ExploreView.swift` – Explore tab listing heritage sites
- `Views/SiteDetailView.swift` – Detail screen with a photo gallery and description
- `Views/TimelineView.swift` – Timeline tab with images and colored markers
- `Views/FavoritesView.swift` – Favorites tab
- `Resources/heritage_sites.json` – JSON data file for the sites
- `Assets.xcassets/AppIcon.appiconset` – App icon for the project

---

## How to run


 . Use the tabs at the bottom to explore the app:
   - *Explore* → list of heritage sites, tap to see details.
   - *Timeline* → historical periods with images.
   - *Favorites* → sites you have marked with the heart button.
