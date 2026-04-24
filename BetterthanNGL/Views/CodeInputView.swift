//
//  CodeInputView.swift
//  BetterthanNGL
//

import SwiftUI

struct CodeInputView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @State private var code = ""
    @State private var showSignature = false
    @FocusState private var isCodeFocused: Bool

    private let codeLength = 6

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                VStack(spacing: 24) {
                    Image(systemName: "keyboard")
                        .font(.system(size: 70))
                        .foregroundStyle(.blue)

                    Text("Saisissez le code")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Entrez le code à 6 chiffres affiché par votre formateur")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                HStack(spacing: 12) {
                    ForEach(0..<codeLength, id: \.self) { index in
                        CodeDigitBox(
                            digit: index < code.count ? String(code[code.index(code.startIndex, offsetBy: index)]) : ""
                        )
                    }
                }

                TextField("", text: $code)
                    .keyboardType(.numberPad)
                    .focused($isCodeFocused)
                    .opacity(0)
                    .frame(height: 0)
                    .onChange(of: code) { _, newValue in
                        if newValue.count > codeLength {
                            code = String(newValue.prefix(codeLength))
                        }
                        if code.count == codeLength {
                            validateCode()
                        }
                    }

                GroupBox {
                    Label("Le code change toutes les 30 secondes", systemImage: "info.circle")
                        .font(.footnote)
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 12) {
                    Button(action: validateCode) {
                        Label("Valider le code", systemImage: "checkmark.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(code.count != codeLength)

                    Button("Effacer", action: { code = "" })
                        .buttonStyle(.borderless)
                }
                .padding()
            }
            .navigationTitle("Code TOTP")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Retour") { dismiss() }
                }
            }
            .onAppear {
                isCodeFocused = true
            }
            .fullScreenCover(isPresented: $showSignature) {
                SignatureView(session: session, verificationType: "Code TOTP")
            }
        }
    }

    private func validateCode() {
        isCodeFocused = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showSignature = true
        }
    }
}

struct CodeDigitBox: View {
    let digit: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .frame(width: 50, height: 65)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(digit.isEmpty ? Color.gray.opacity(0.3) : Color.blue, lineWidth: digit.isEmpty ? 1 : 2)
                )

            Text(digit)
                .font(.system(size: 32, weight: .medium, design: .monospaced))
        }
    }
}

#Preview {
    CodeInputView(session: Session.sampleSessions[0])
}
