//
//  TimelineView.swift
//  FinalProject_MohammadReza_Zarei
//
//  Created by Mohammad Reza Zarei on 11/24/2025.
//  Description: CIS 137 final project – Persian Heritage Explorer app using SwiftUI and MVVM.
//  Note: Data is stored in a JSON file and this project is prepared for future SwiftData (Week 16 database) integration.
//

import SwiftUI

struct TimelineView: View {
    struct Period: Identifiable {
        let id = UUID()
        let name: String
        let years: String
        let description: String
        let color: Color
        let imageName: String   // image used in the timeline row
    }

    let periods: [Period] = [
        .init(
            name: "Achaemenid Empire",
            years: "550–330 BC",
            description: "Important developments in Persian history during this era.",
            color: .blue,
            imageName: "achaemenid"
        ),
        .init(
            name: "Parthian Empire",
            years: "247 BC – 224 AD",
            description: "Important developments in Persian history during this era.",
            color: .green,
            imageName: "parthian"
        ),
        .init(
            name: "Sassanian Empire",
            years: "224–651 AD",
            description: "Important developments in Persian history during this era.",
            color: .purple,
            imageName: "sassanian"
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(periods) { period in
                        HStack(alignment: .top, spacing: 16) {

                            // Image for the period
                            Image(period.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3)

                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Circle()
                                        .fill(period.color)
                                        .frame(width: 10, height: 10)
                                    Text(period.name)
                                        .font(.headline)
                                }

                                Text(period.years)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text(period.description)
                                    .font(.caption)
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
