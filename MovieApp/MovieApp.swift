//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by FEKRANE on 22/11/2023.
//

import SwiftUI
import netfox

@main
struct MovieApp: App {
    init() {
        NFX.sharedInstance().start()
        NFX.sharedInstance().setGesture(.shake)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
