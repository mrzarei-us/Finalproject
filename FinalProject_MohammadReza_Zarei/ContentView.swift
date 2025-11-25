//
//  ContentView.swift
//  FinalProject_MohammadReza_Zarei
//
//  Created by Mohammad Reza Zarei on 11/24/2025.
//  Description: CIS 137 final project – Persian Heritage Explorer app using SwiftUI and MVVM.
//  Note: Data is stored in a JSON file and this project is prepared for future SwiftData (Week 16 database) integration.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HeritageViewModel()
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
                }
            
            TimelineView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Timeline")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}

