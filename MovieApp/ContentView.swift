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
        .accentColor(Color(.red))
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.tabBar)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .preferredColorScheme(.dark)
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
