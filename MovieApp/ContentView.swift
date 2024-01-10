//
//  ContentView.swift
//  MovieApp
//
//  Created by FEKRANE on 22/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeScreen().configureView()
                .tabItem {
                    
                    Label("Home", systemImage: "house")
                }
            Text("Search")
                .tabItem {
                    
                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Notification")
                .tabItem {
                    
                    Label("Notification", systemImage: "bell")
                }
            Text("Settings")
                .tabItem {
                    
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .accentColor(Color(.lightGray))
        .preferredColorScheme(.dark)
    }
    
}


#Preview {
    ContentView()
}
