//
//  QRCodeScannerView.swift
//  BetterthanNGL
//

import SwiftUI
import AVFoundation
import UIKit

struct QRCodeScannerView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @State private var isScanning = false
    @State private var showSignature = false
    @State private var animateScanLine = false
    @State private var torchOn = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    ZStack {
                        // Camera preview when scanning, otherwise placeholder
                        if isScanning {
                            CameraScannerView { code in
                                // Found a QR code -> proceed to signature
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                isScanning = false
                                animateScanLine = false
                                showSignature = true
                            }
                            .aspectRatio(3/4, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .aspectRatio(3/4, contentMode: .fit)
                                .overlay {
                                    Image(systemName: "qrcode")
                                        .font(.system(size: 120))
                                        .foregroundStyle(.white.opacity(0.8))
                                }
                        }

                        // Overlay scan frame + animated line
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
                            .buttonStyle(GlassButtonStyle())
                            .controlSize(.large)
                        } else {
                            Button(action: simulateScan) {
                                Label("Simuler un scan (démo)", systemImage: "checkmark.circle.fill")
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(GlassButtonStyle())
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
                    .background(AnyView(RoundedRectangle(cornerRadius: 12).fill(.ultraThinMaterial)))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                        .foregroundStyle(.white)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: toggleTorch) {
                        Image(systemName: torchOn ? "flashlight.on.fill" : "flashlight.off.fill")
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
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            // If there's no camera (simulator), fallback to demo scan
            if AVCaptureDevice.default(for: .video) == nil {
                simulateScan()
                return
            }

            withAnimation {
                isScanning = true
                animateScanLine = true
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        withAnimation {
                            isScanning = true
                            animateScanLine = true
                        }
                    } else {
                        // Fallback to demo scan if camera access denied
                        simulateScan()
                    }
                }
            }
        default:
            // denied / restricted
            simulateScan()
        }
    }

    private func toggleTorch() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            if torchOn {
                device.torchMode = .off
                torchOn = false
            } else {
                try device.setTorchModeOn(level: 1.0)
                torchOn = true
            }
            device.unlockForConfiguration()
        } catch {
            print("Torch error: \(error)")
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

// MARK: - Camera scanner (AVCapture)
struct CameraScannerView: UIViewRepresentable {
    let onFound: (String) -> Void

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black

        let session = AVCaptureSession()
        session.sessionPreset = .high

        guard let device = AVCaptureDevice.default(for: .video) else {
            // No camera available (simulator) — show a helpful placeholder
            let label = UILabel()
            label.text = "Caméra indisponible — utilisez 'Simuler'"
            label.textColor = .white
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            return view
        }

        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return view
        }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            if output.availableMetadataObjectTypes.contains(.qr) {
                output.metadataObjectTypes = [.qr]
            }
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        previewLayer.connection?.videoOrientation = .portrait
        view.layer.addSublayer(previewLayer)

        context.coordinator.previewLayer = previewLayer
        context.coordinator.session = session

        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.previewLayer?.frame = uiView.bounds
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onFound: onFound)
    }

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let onFound: (String) -> Void
        weak var previewLayer: AVCaptureVideoPreviewLayer?
        var session: AVCaptureSession?

        init(onFound: @escaping (String) -> Void) {
            self.onFound = onFound
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let first = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
                  let string = first.stringValue else { return }

            // stop session and report
            session?.stopRunning()
            DispatchQueue.main.async {
                self.onFound(string)
            }
        }
    }
}

#Preview {
    QRCodeScannerView(session: Session.sampleSessions[0])
}
