//
//  ConfirmationView.swift
//  BetterthanNGL
//

import SwiftUI

struct ConfirmationView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @State private var showCheckmark = false
    @State private var showDetails = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.green, .green.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                ZStack {
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 200, height: 200)
                        .scaleEffect(showCheckmark ? 1.2 : 0.8)
                        .opacity(showCheckmark ? 0 : 1)

                    Circle()
                        .stroke(.white.opacity(0.2), lineWidth: 2)
                        .frame(width: 160, height: 160)
                        .scaleEffect(showCheckmark ? 1.3 : 0.7)
                        .opacity(showCheckmark ? 0 : 1)

                    Circle()
                        .fill(.white)
                        .frame(width: 120, height: 120)
                        .shadow(color: .black.opacity(0.2), radius: 20)

                    Image(systemName: "checkmark")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundStyle(.green)
                        .scaleEffect(showCheckmark ? 1 : 0)
                        .rotationEffect(.degrees(showCheckmark ? 0 : 180))
                }

                VStack(spacing: 12) {
                    Text("Signature enregistrée !")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text("Votre présence a été confirmée")
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .opacity(showDetails ? 1 : 0)
                .offset(y: showDetails ? 0 : 20)

                GroupBox {
                    VStack(spacing: 16) {
                        ConfirmationRow(icon: "book.fill", label: "Session", value: session.title)
                        Divider()
                        ConfirmationRow(icon: "clock.fill", label: "Heure", value: getCurrentTime())
                        Divider()
                        ConfirmationRow(icon: "location.fill", label: "Lieu", value: session.room)
                        Divider()
                        ConfirmationRow(icon: "checkmark.seal.fill", label: "Statut", value: "Validé")
                    }
                }
                .backgroundStyle(.white.opacity(0.2))
                .padding(.horizontal)
                .opacity(showDetails ? 1 : 0)
                .offset(y: showDetails ? 0 : 30)

                Spacer()

                VStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        Label("Retour à l'accueil", systemImage: "house.fill")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .foregroundStyle(.green)
                    .controlSize(.large)

                    Button(action: {}) {
                        Label("Partager la confirmation", systemImage: "square.and.arrow.up")
                    }
                    .foregroundStyle(.white)
                }
                .padding()
                .opacity(showDetails ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                showCheckmark = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showDetails = true
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                dismiss()
            }
        }
    }

    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }
}

struct ConfirmationRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                Text(value)
                    .font(.callout)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
            }

            Spacer()
        }
    }
}

#Preview {
    ConfirmationView(session: Session.sampleSessions[0])
}
