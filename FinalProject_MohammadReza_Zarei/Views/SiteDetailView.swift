//
//  SiteDetailView.swift
//  FinalProject_MohammadReza_Zarei
//
//  Created by Mohammad Reza Zarei on 11/24/2025.
//  Description: CIS 137 final project – Persian Heritage Explorer app using SwiftUI and MVVM.
//  Note: Data is stored in a JSON file and this project is prepared for future SwiftData (Week 16 database) integration.
//

import SwiftUI

struct SiteDetailView: View {
    @EnvironmentObject var viewModel: HeritageViewModel
    let site: HeritageSite

    // Zoom state for the detail image
    @State private var imageScale: CGFloat = 1.0

    private func galleryImageName(for index: Int) -> String {
        if index == 0 {
            return site.imageName
        } else {
            return "\(site.imageName)_\(index)"
        }
    }

    var totalPhotos: Int {
        1 + max(0, site.photoCount)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // MARK: - Gallery with Zoom
                TabView {
                    ForEach(0 ..< totalPhotos, id: \.self) { index in
                        Image(galleryImageName(for: index))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 260)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(radius: 6)
                            .padding(.horizontal)
                    }
                }
                .frame(height: 280)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .scaleEffect(imageScale)
                .onTapGesture(count: 2) {
                    withAnimation(.spring()) {
                        imageScale = (imageScale == 1.0 ? 2.0 : 1.0)
                    }
                }
                .onLongPressGesture {
                    withAnimation(.spring()) {
                        imageScale = 1.0
                    }
                }

                // MARK: - Info Section
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(site.name)
                            .font(.largeTitle.bold())
                        Text(site.location)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(site.era)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Photos: \(totalPhotos)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Button {
                        viewModel.toggleFavorite(site: site)
                    } label: {
                        Image(systemName: site.isFavorite ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    .accessibilityLabel(site.isFavorite ? "Remove from favorites" : "Add to favorites")
                }
                .padding(.horizontal)

                Divider().padding(.horizontal)

                // MARK: - Description
                Text("Description")
                    .font(.title2.bold())
                    .padding(.horizontal)

                Text(site.description)
                    .padding(.horizontal)

                Spacer(minLength: 20)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        if let site = HeritageViewModel().sites.first {
            SiteDetailView(site: site)
                .environmentObject(HeritageViewModel())
        }
    }
}
