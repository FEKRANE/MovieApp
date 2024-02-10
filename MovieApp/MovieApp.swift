//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by FEKRANE on 22/11/2023.
//

import SwiftUI
import netfox

struct MovieApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

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

@main
struct MainEntryPoint {
    static func main() {
        guard isProduction() else {
            TestApp.main()
            return
        }
        MovieApp.main()
    }
    private static func isProduction() -> Bool {
        return NSClassFromString("XCTestCase") == nil
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup {
        }
    }
}
