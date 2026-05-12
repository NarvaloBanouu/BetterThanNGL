//
//  BetterthanNGLApp.swift
//  BetterthanNGL
//
//  Created by Esteban Pagis on 21/04/2026.
//

import SwiftUI

@main
@MainActor
struct BetterthanNGLApp: App {
    @StateObject private var auth = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
        }
    }
}
