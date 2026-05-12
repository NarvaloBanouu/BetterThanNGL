//
//  ContentView.swift
//  BetterthanNGL
//
//  Created by Esteban Pagis on 21/04/2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        Group {
            if auth.isAuthenticated {
                SessionsListView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
