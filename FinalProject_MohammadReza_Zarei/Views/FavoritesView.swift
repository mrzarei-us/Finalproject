import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: HeritageViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.favorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Text("No favorites yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Tap the heart on a place you like to add it here.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    List(viewModel.favorites) { site in
                        NavigationLink {
                            SiteDetailView(site: site)
                        } label: {
                            HStack {
                                Image(site.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)

                                VStack(alignment: .leading) {
                                    Text(site.name)
                                        .font(.headline)
                                    Text(site.location)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.inset)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(HeritageViewModel())
}
