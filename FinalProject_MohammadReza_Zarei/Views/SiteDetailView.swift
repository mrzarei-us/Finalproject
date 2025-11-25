import SwiftUI

struct SiteDetailView: View {
    @EnvironmentObject var viewModel: HeritageViewModel
    let site: HeritageSite

    /// Builds the gallery image name for a given index.
    /// index == 0  → main imageName
    /// index >= 1 → imageName_index  (e.g. persepolis_1, persepolis_2, ...)
    private func galleryImageName(for index: Int) -> String {
        if index == 0 {
            return site.imageName
        } else {
            return "\(site.imageName)_\(index)"
        }
    }

    var totalPhotos: Int {
        // main image + additional ones
        1 + max(0, site.photoCount)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // MARK: - Image gallery
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

                Divider()
                    .padding(.horizontal)

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
        } else {
            Text("No data")
        }
    }
}
