//
//  SignatureView.swift
//  BetterthanNGL
//

import SwiftUI
import PencilKit

struct SignatureView: View {
    let session: Session
    let verificationType: String
    @Environment(\.dismiss) var dismiss
    @State private var canvas = PKCanvasView()
    @State private var showConfirmation = false
    @State private var isDrawing = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        VStack(spacing: 16) {
                            Image(systemName: "pencil.tip")
                                .font(.system(size: 50))
                                .foregroundStyle(.blue)

                            Text("Signez ici")
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text("Tracez votre signature dans le cadre ci-dessous")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }
                    .listRowBackground(AnyView(Rectangle().fill(.ultraThinMaterial)))

                    Section {
                        Label("Vérifié par \(verificationType)", systemImage: "checkmark.shield.fill")
                            .font(.callout)
                            .foregroundStyle(.green)
                    }
                    .listRowBackground(AnyView(Rectangle().fill(.ultraThinMaterial)))

                    Section("Zone de signature") {
                        ZStack(alignment: .topLeading) {
                            Rectangle().fill(.white)

                            if !isDrawing {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        VStack(spacing: 8) {
                                            Image(systemName: "hand.draw")
                                                .font(.system(size: 40))
                                                .foregroundStyle(.gray.opacity(0.4))
                                            Text("Tracez votre signature")
                                                .font(.callout)
                                                .foregroundStyle(.gray.opacity(0.4))
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }

                            CanvasView(canvas: $canvas, isDrawing: $isDrawing)

                            VStack {
                                Spacer()
                                Rectangle()
                                    .fill(.gray.opacity(0.3))
                                    .frame(height: 1)
                                    .padding(.horizontal, 32)
                                    .padding(.bottom, 60)
                            }
                            }
                            .frame(height: 300)
                            }

                    Section("Informations de signature") {
                        LabeledContent("Session", value: session.title)
                        LabeledContent("Date", value: formatDate(session.date))
                        LabeledContent("Horaire", value: "\(session.startTime) - \(session.endTime)")
                        LabeledContent("Méthode", value: verificationType)
                    }
                    .listRowBackground(AnyView(Rectangle().fill(.ultraThinMaterial)))

                    Section {
                        HStack(spacing: 12) {
                            Button(action: clearSignature) {
                                Label("Effacer", systemImage: "trash")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(GlassButtonStyle())
                            .controlSize(.large)

                            Button(action: validateSignature) {
                                Label("Valider", systemImage: "checkmark.circle.fill")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(GlassButtonStyle())
                            .controlSize(.large)
                            .disabled(!isDrawing)
                        }
                    }
                    .listRowBackground(AnyView(Rectangle().fill(.ultraThinMaterial)))
                }
            }
            .navigationTitle("Signature")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Retour") { dismiss() }
                }
            }
            .fullScreenCover(isPresented: $showConfirmation) {
                ConfirmationView(session: session)
            }
        }
    }

    private func clearSignature() {
        canvas.drawing = PKDrawing()
        isDrawing = false
    }

    private func validateSignature() {
        showConfirmation = true
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM yyyy"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: date).capitalized
    }
}

struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool

    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = PKInkingTool(.pen, color: .black, width: 3)
        canvas.backgroundColor = .clear
        canvas.delegate = context.coordinator
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(isDrawing: $isDrawing)
    }

    class Coordinator: NSObject, PKCanvasViewDelegate {
        @Binding var isDrawing: Bool

        init(isDrawing: Binding<Bool>) {
            _isDrawing = isDrawing
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            isDrawing = !canvasView.drawing.bounds.isEmpty
        }
    }
}

#Preview {
    SignatureView(session: Session.sampleSessions[0], verificationType: "Code TOTP")
}
