import SwiftUI

struct TimelineView: View {
    struct Period: Identifiable {
        let id = UUID()
        let name: String
        let years: String
        let color: Color
    }

    let periods: [Period] = [
        .init(name: "Achaemenid Empire", years: "550–330 BC", color: .blue),
        .init(name: "Parthian Empire", years: "247 BC – 224 AD", color: .green),
        .init(name: "Sassanian Empire", years: "224–651 AD", color: .purple)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    ForEach(Array(periods.enumerated()), id: \.element.id) { index, period in
                        HStack(alignment: .top, spacing: 16) {
                            VStack {
                                Circle()
                                    .fill(period.color)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                                    )
                                    .scaleEffect(1.0 + (index == 0 ? 0.1 : 0.0))
                                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true),
                                               value: index)

                                Rectangle()
                                    .fill(Color.secondary.opacity(0.3))
                                    .frame(width: 3, height: 80)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(period.name)
                                    .font(.title3.bold())
                                Text(period.years)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Important developments in Persian history during this era.")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Timeline")
        }
    }
}

#Preview {
    TimelineView()
}
