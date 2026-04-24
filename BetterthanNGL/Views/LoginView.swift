//
//  LoginView.swift
//  BetterthanNGL
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(spacing: 24) {
                        Image(systemName: "signature")
                            .font(.system(size: 80))
                            .foregroundStyle(.blue)

                        VStack(spacing: 8) {
                            Text("Signature")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Gestion des émargements")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                } header: {
                    EmptyView()
                }
                .listRowBackground(Color.clear)

                Section("Connexion") {
                    TextField("Identifiant école", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Mot de passe", text: $password)
                        .textContentType(.password)

                    Button("Mot de passe oublié ?") {}
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                Section {
                    Button(action: login) {
                        Label("Se connecter", systemImage: "arrow.right.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(email.isEmpty || password.isEmpty)

                    Button(action: {}) {
                        Label("Connexion par lien magique", systemImage: "envelope.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                .listRowBackground(Color.clear)

                Section {
                    VStack(spacing: 4) {
                        Text("Version 1.0.0")
                            .font(.caption)
                        Text("Projet pédagogique Master 1")
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
        }
    }

    private func login() {
        withAnimation {
            isAuthenticated = true
        }
    }
}

#Preview {
    LoginView(isAuthenticated: .constant(false))
}
