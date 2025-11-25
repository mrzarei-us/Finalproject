import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var viewModel: HeritageViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.sites) { site in
                        NavigationLink {
                            SiteDetailView(site: site)
                        } label: {
                            SiteCard(site: site)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Explore")
        }
    }
}

struct SiteCard: View {
    let site: HeritageSite

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(site.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(16)

            LinearGradient(colors: [.clear, .black.opacity(0.7)],
                           startPoint: .center,
                           endPoint: .bottom)
                .cornerRadius(16)

            VStack(alignment: .leading, spacing: 4) {
                Text(site.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(site.location)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
        .shadow(radius: 4)
    }
}

#Preview {
    ExploreView()
        .environmentObject(HeritageViewModel())
}
