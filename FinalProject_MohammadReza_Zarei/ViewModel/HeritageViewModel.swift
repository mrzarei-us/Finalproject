import Foundation
import SwiftUI

/// ViewModel that loads site data from JSON and exposes it to the views.
///
/// NOTE:
///  • The main descriptive/history information lives in `heritage_sites.json`.
///  • Favorites are stored in UserDefaults so they persist between launches.
///  • In a future version this can be migrated to SwiftData (Week 16 topic).
class HeritageViewModel: ObservableObject {
    @Published var sites: [HeritageSite] = []

    private let favoritesKey = "favoriteSiteIDs"

    init() {
        loadSitesFromJSON()
        restoreFavorites()
    }

    /// Load initial data from heritage_sites.json in the app bundle.
    private func loadSitesFromJSON() {
        guard let url = Bundle.main.url(forResource: "heritage_sites", withExtension: "json") else {
            print("❌ Could not find heritage_sites.json in bundle.")
            sites = []
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode([HeritageSite].self, from: data)
            self.sites = decoded
        } catch {
            print("❌ Error decoding heritage_sites.json:", error)
            self.sites = []
        }
    }

    /// Toggle favorite flag and persist favorites.
    func toggleFavorite(site: HeritageSite) {
        guard let index = sites.firstIndex(of: site) else { return }
        sites[index].isFavorite.toggle()
        saveFavorites()
    }

    var favorites: [HeritageSite] {
        sites.filter { $0.isFavorite }
    }

    // MARK: - Simple persistence for favorites

    private func saveFavorites() {
        let favoriteIDs = sites.filter { $0.isFavorite }.map { $0.id.uuidString }
        UserDefaults.standard.set(favoriteIDs, forKey: favoritesKey)
    }

    private func restoreFavorites() {
        guard let ids = UserDefaults.standard.array(forKey: favoritesKey) as? [String] else {
            return
        }
        let idSet = Set(ids)
        sites = sites.map { site in
            var copy = site
            if idSet.contains(site.id.uuidString) {
                copy.isFavorite = true
            }
            return copy
        }
    }
}
