//
//  SignatureOptionsView.swift
//  BetterthanNGL
//

import SwiftUI

struct SignatureOptionsView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @State private var showCodeInput = false
    @State private var showQRScanner = false
    @State private var showLocationCheck = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        Image(systemName: "pencil.and.scribble")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)

                        VStack(spacing: 8) {
                            Text("Choisir une méthode")
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text("Sélectionnez comment vous souhaitez signer votre présence")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                .listRowBackground(Color.clear)

                Section("Méthodes de signature") {
                    Button(action: { showCodeInput = true }) {
                        Label {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Code à 6 chiffres")
                                    .font(.headline)
                                Text("Saisissez le code affiché par votre formateur")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        } icon: {
                            Image(systemName: "number.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                    }

                    Button(action: { showQRScanner = true }) {
                        Label {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Scanner QR Code")
                                        .font(.headline)
                                    Text("Rapide")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(.orange)
                                        .clipShape(Capsule())
                                }
                                Text("Scannez le QR code affiché à l'écran")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        } icon: {
                            Image(systemName: "qrcode.viewfinder")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                    }

                    Button(action: { showLocationCheck = true }) {
                        Label {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Géolocalisation")
                                        .font(.headline)
                                    Text("Auto")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(.orange)
                                        .clipShape(Capsule())
                                }
                                Text("Vérification automatique de votre position")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        } icon: {
                            Image(systemName: "location.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                    }
                }

                Section("Informations de la session") {
                    LabeledContent {
                        Text(session.title)
                    } label: {
                        Label("Session", systemImage: "book.fill")
                    }

                    LabeledContent {
                        Text("\(session.startTime) - \(session.endTime)")
                    } label: {
                        Label("Horaire", systemImage: "clock.fill")
                    }

                    LabeledContent {
                        Text(session.room)
                    } label: {
                        Label("Salle", systemImage: "location.fill")
                    }

                    LabeledContent {
                        Text(session.instructor)
                    } label: {
                        Label("Formateur", systemImage: "person.fill")
                    }
                }
            }
            .navigationTitle("Signature")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
            }
            .fullScreenCover(isPresented: $showCodeInput) {
                CodeInputView(session: session)
            }
            .fullScreenCover(isPresented: $showQRScanner) {
                QRCodeScannerView(session: session)
            }
            .fullScreenCover(isPresented: $showLocationCheck) {
                LocationView(session: session)
            }
        }
    }
}

#Preview {
    SignatureOptionsView(session: Session.sampleSessions[0])
}
