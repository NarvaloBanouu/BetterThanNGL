//
//  AuthViewModel.swift
//  BetterthanNGL
//
//  Simple view model wrapping the fake auth service
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var username: String = ""

    private let service: AuthServiceProtocol

    init(service: AuthServiceProtocol = FakeAuthService()) {
        self.service = service
        if let existing = service.username {
            self.username = existing
            self.isAuthenticated = service.isLoggedIn
        }
    }

    func login(username: String, password: String) {
        Task {
            do {
                try await service.login(username: username, password: password)
                self.username = service.username ?? username
                self.isAuthenticated = true
            } catch {
                // In the fake service we don't throw, but handle gracefully
                self.isAuthenticated = false
            }
        }
    }

    func logout() {
        service.logout()
        username = ""
        isAuthenticated = false
    }
}
