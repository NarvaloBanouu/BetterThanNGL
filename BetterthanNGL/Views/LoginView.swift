//
//  LoginView.swift
//  BetterthanNGL
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color(.systemIndigo), Color(.systemBlue)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                Form {
                Section {
                    VStack(spacing: 24) {
                        Image(systemName: "signature")
                            .font(.system(size: 80))
                            .foregroundStyle(.blue)

                        VStack(spacing: 8) {
                            Text("BetterThanNGL")
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
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                // use the reusable glass card to get a more authentic liquid glass appearance
                .glassCard(cornerRadius: 16)
                .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 8)

                Section(header: Text("Connexion").font(.headline).foregroundStyle(.white)) {
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
                    .buttonStyle(GlassButtonStyle())
                    .controlSize(.large)

                    Button(action: {}) {
                        Label("Connexion par lien magique", systemImage: "envelope.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GlassButtonStyle())
                    .controlSize(.large)
                }

                Section {
                    VStack(spacing: 4) {
                        Text("Version 1.0.0")
                            .font(.caption)
                        Text("Esteban PAGIS - Paul MONTAGNAC - Corentin ALLALOU")
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
                // Info block should also be white to match the rest of the login card blocks
                .listRowBackground(AnyView(RoundedRectangle(cornerRadius: 12).fill(Color.white)))
            }
            .scrollContentBackground(.hidden)
            }
        }
    }

    private func login() {
        // Use the AuthViewModel to perform a fake login - accepts any credentials.
        auth.login(username: email.isEmpty ? "Utilisateur" : email, password: password)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
