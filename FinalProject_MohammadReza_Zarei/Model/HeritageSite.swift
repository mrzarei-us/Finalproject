//
//  HeritageSite.swift
//  FinalProject_MohammadReza_Zarei
//
//  Created by Mohammad Reza Zarei on 11/24/2025.
//  Description: CIS 137 final project – Persian Heritage Explorer app using SwiftUI and MVVM.
//  Note: Data is stored in a JSON file and this project is prepared for future SwiftData (Week 16 database) integration.
//

import Foundation

/// Model for one cultural / historical site.
/// Descriptive data is loaded from the JSON file:
///   heritage_sites.json  (located in the app bundle)
struct HeritageSite: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let location: String
    let era: String
    let description: String

    /// Name of the main image used in cards and as the first image in the gallery.
    let imageName: String

    /// Number of additional photos available for this site (besides the main image).
    /// For example, if imageName = "persepolis" and photoCount = 2, the gallery
    /// will try to load:
    ///   persepolis           (main image)
    ///   persepolis_1         (extra)
    ///   persepolis_2         (extra)
    let photoCount: Int

    var isFavorite: Bool

    init(id: UUID = UUID(),
         name: String,
         location: String,
         era: String,
         description: String,
         imageName: String,
         photoCount: Int = 0,
         isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.location = location
        self.era = era
        self.description = description
        self.imageName = imageName
        self.photoCount = photoCount
        self.isFavorite = isFavorite
    }
}
