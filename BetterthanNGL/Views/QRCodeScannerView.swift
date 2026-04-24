//
//  QRCodeScannerView.swift
//  BetterthanNGL
//

import SwiftUI

struct QRCodeScannerView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @State private var isScanning = false
    @State private var showSignature = false
    @State private var animateScanLine = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(3/4, contentMode: .fit)
                        .overlay {
                            if !isScanning {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 120))
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        }
                        .overlay {
                            VStack {
                                Spacer()

                                ZStack {
                                    Rectangle()
                                        .fill(Color.black.opacity(0.5))
                                        .frame(height: 400)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 24)
                                                .frame(width: 280, height: 280)
                                                .blendMode(.destinationOut)
                                        }

                                    ScanFrame()
                                        .frame(width: 280, height: 280)

                                    if isScanning {
                                        Rectangle()
                                            .fill(
                                                LinearGradient(
                                                    colors: [.orange.opacity(0), .orange.opacity(0.8), .orange.opacity(0)],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .frame(width: 280, height: 4)
                                            .offset(y: animateScanLine ? 140 : -140)
                                            .animation(.linear(duration: 2.0).repeatForever(autoreverses: true), value: animateScanLine)
                                    }
                                }

                                Spacer()
                            }
                        }
                        .compositingGroup()

                    VStack(spacing: 24) {
                        Text(isScanning ? "Scannez le QR Code" : "Prêt à scanner")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)

                        Text(isScanning ? "Positionnez le QR Code dans le cadre" : "Appuyez sur le bouton pour commencer")
                            .font(.callout)
                            .foregroundStyle(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        if !isScanning {
                            Button(action: startScanning) {
                                Label("Commencer le scan", systemImage: "camera.fill")
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.white)
                            .foregroundStyle(.blue)
                            .controlSize(.large)
                        } else {
                            Button(action: simulateScan) {
                                Label("Simuler un scan (démo)", systemImage: "checkmark.circle.fill")
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .controlSize(.large)
                        }

                        HStack(spacing: 6) {
                            Circle()
                                .fill(isScanning ? Color.green : Color.gray)
                                .frame(width: 8, height: 8)
                            Text(isScanning ? "Scan actif" : "Scan inactif")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                    .padding(.vertical, 32)
                    .frame(maxWidth: .infinity)
                    .background(.black.gradient)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                        .foregroundStyle(.white)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "flashlight.off.fill")
                            .foregroundStyle(.white)
                    }
                }
            }
            .fullScreenCover(isPresented: $showSignature) {
                SignatureView(session: session, verificationType: "QR Code")
            }
        }
    }

    private func startScanning() {
        withAnimation {
            isScanning = true
            animateScanLine = true
        }
    }

    private func simulateScan() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showSignature = true
        }
    }
}

struct ScanFrame: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    CornerShape(corners: [.topLeft])
                    Spacer()
                    CornerShape(corners: [.topRight])
                }
                Spacer()
                HStack {
                    CornerShape(corners: [.bottomLeft])
                    Spacer()
                    CornerShape(corners: [.bottomRight])
                }
            }
        }
    }
}

struct CornerShape: View {
    let corners: UIRectCorner
    let lineWidth: CGFloat = 4
    let lineLength: CGFloat = 30

    var body: some View {
        ZStack {
            if corners.contains(.topLeft) {
                VStack(spacing: 0) {
                    Rectangle().fill(.orange).frame(width: lineLength, height: lineWidth).offset(x: -lineWidth / 2)
                    HStack(spacing: 0) {
                        Rectangle().fill(.orange).frame(width: lineWidth, height: lineLength)
                        Spacer()
                    }
                    .offset(y: -lineWidth / 2)
                    Spacer()
                }
            } else if corners.contains(.topRight) {
                VStack(spacing: 0) {
                    Rectangle().fill(.orange).frame(width: lineLength, height: lineWidth).offset(x: lineWidth / 2)
                    HStack(spacing: 0) {
                        Spacer()
                        Rectangle().fill(.orange).frame(width: lineWidth, height: lineLength)
                    }
                    .offset(y: -lineWidth / 2)
                    Spacer()
                }
            } else if corners.contains(.bottomLeft) {
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        Rectangle().fill(.orange).frame(width: lineWidth, height: lineLength)
                        Spacer()
                    }
                    .offset(y: lineWidth / 2)
                    Rectangle().fill(.orange).frame(width: lineLength, height: lineWidth).offset(x: -lineWidth / 2)
                }
            } else if corners.contains(.bottomRight) {
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        Spacer()
                        Rectangle().fill(.orange).frame(width: lineWidth, height: lineLength)
                    }
                    .offset(y: lineWidth / 2)
                    Rectangle().fill(.orange).frame(width: lineLength, height: lineWidth).offset(x: lineWidth / 2)
                }
            }
        }
        .frame(width: lineLength, height: lineLength)
    }
}

#Preview {
    QRCodeScannerView(session: Session.sampleSessions[0])
}
