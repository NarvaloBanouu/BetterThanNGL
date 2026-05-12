//
//  AuthService.swift
//  BetterthanNGL
//
//  Fake authentication service for prototype
//

import Foundation

protocol AuthServiceProtocol {
    func login(username: String, password: String) async throws
    func logout()
    var username: String? { get }
    var isLoggedIn: Bool { get }
}

final class FakeAuthService: AuthServiceProtocol {
    private(set) var username: String?

    func login(username: String, password: String) async throws {
        // Simulate network delay for UX
        try? await Task.sleep(nanoseconds: 150_000_000)
        // Accept any username/password for the fake implementation
        self.username = username
    }

    func logout() {
        username = nil
    }

    var isLoggedIn: Bool { username != nil }
}
