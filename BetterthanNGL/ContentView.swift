//
//  ContentView.swift
//  BetterthanNGL
//
//  Created by Esteban Pagis on 21/04/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                SessionsListView()
            } else {
                LoginView(isAuthenticated: $isAuthenticated)
            }
        }
    }
}

#Preview {
    ContentView()
}
