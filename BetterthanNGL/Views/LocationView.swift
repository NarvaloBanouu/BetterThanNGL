//
//  LocationView.swift
//  BetterthanNGL
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @State private var isCheckingLocation = false
    @State private var isRotating = false
    @State private var locationStatus: LocationStatus = .checking
    @State private var showSignature = false
    @State private var region = MKCoordinateRegion(
        // EPITA - Kremlin Bicetre (requested campus base)
        center: CLLocationCoordinate2D(latitude: 48.81570782118537, longitude: 2.36299749714027),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @StateObject private var locationManager = LocationManager()

    enum LocationStatus {
        case checking, verified, failed, tooFar

        var icon: String {
            switch self {
            case .checking: return "location.circle"
            case .verified: return "checkmark.circle.fill"
            case .failed: return "xmark.circle.fill"
            case .tooFar: return "exclamationmark.circle.fill"
            }
        }

        var color: Color {
            switch self {
            case .checking: return .blue
            case .verified: return .green
            case .failed: return .red
            case .tooFar: return .orange
            }
        }

        var title: String {
            switch self {
            case .checking: return "Vérification en cours..."
            case .verified: return "Position vérifiée"
            case .failed: return "Localisation impossible"
            case .tooFar: return "Trop éloigné"
            }
        }

        var message: String {
            switch self {
            case .checking: return "Nous vérifions votre position"
            case .verified: return "Vous êtes bien dans la zone autorisée"
            case .failed: return "Impossible d'accéder à votre position"
            case .tooFar: return "Vous devez être sur le campus"
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Map(coordinateRegion: $region, annotationItems: [LocationMarker(id: 1, coordinate: region.center)]) { marker in
                    MapAnnotation(coordinate: marker.coordinate) {
                        ZStack {
                            Circle().fill(.blue.opacity(0.2)).frame(width: 100, height: 100)
                            Circle().fill(.blue.opacity(0.3)).frame(width: 60, height: 60)
                            Circle().fill(.blue).frame(width: 20, height: 20)
                            Image(systemName: "building.2.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 10))
                        }
                    }
                }
                .frame(height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()

                List {
                    Section {
                        VStack(spacing: 24) {
                            ZStack {
                                Circle()
                                    .fill(locationStatus.color.opacity(0.1))
                                    .frame(width: 100, height: 100)

                                if locationStatus == .checking {
                                    Circle()
                                        .trim(from: 0, to: 0.7)
                                        .stroke(locationStatus.color, lineWidth: 4)
                                        .frame(width: 80, height: 80)
                                        .rotationEffect(.degrees(isRotating ? 360 : 0))
                                        .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isRotating)
                                }

                                Image(systemName: locationStatus.icon)
                                    .font(.system(size: 40))
                                    .foregroundStyle(locationStatus.color)
                            }

                            VStack(spacing: 8) {
                                Text(locationStatus.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text(locationStatus.message)
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }
                    .listRowBackground(Color.clear)

                    if locationStatus == .verified {
                        Section {
                            LabeledContent("Distance", value: "15 m")
                            LabeledContent("Rayon autorisé", value: "50 m")
                        }
                    }

                    Section {
                        if locationStatus == .checking {
                            Button("Vérification...") {}
                                .disabled(true)
                                .frame(maxWidth: .infinity)
                        } else if locationStatus == .verified {
                            Button(action: { showSignature = true }) {
                                Label("Continuer vers la signature", systemImage: "arrow.right.circle.fill")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                        } else {
                            Button(action: checkLocation) {
                                Label("Réessayer", systemImage: "arrow.clockwise")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)

                            Button("Choisir une autre méthode") {
                                dismiss()
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Géolocalisation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Retour") { dismiss() }
                }
            }
            .onAppear {
                checkLocation()
            }
            .onReceive(locationManager.$location) { loc in
                guard let loc = loc else { return }
                // Update region to user position
                withAnimation {
                    region.center = loc.coordinate
                }
                // Evaluate distance to target: use the EPITA campus anchor requested by the user
                let target = CLLocation(latitude: 48.81570782118537, longitude: 2.36299749714027)
                let distance = loc.distance(from: target)
                withAnimation {
                    if distance <= 50 {
                        locationStatus = .verified
                    } else {
                        locationStatus = .tooFar
                    }
                    isCheckingLocation = false
                    isRotating = false
                }
            }
            .fullScreenCover(isPresented: $showSignature) {
                SignatureView(session: session, verificationType: "Géolocalisation")
            }
        }
    }

    private func checkLocation() {
        locationStatus = .checking
        isCheckingLocation = true
        // start rotation animation
        isRotating = true
        // Request a single location update from the helper
        locationManager.requestLocation()

        // Fallback: if no location after 4 seconds, mark as failed
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            if locationManager.location == nil {
                withAnimation {
                    locationStatus = .failed
                    isCheckingLocation = false
                    isRotating = false
                }
            }
        }
    }
}

struct LocationMarker: Identifiable {
    let id: Int
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    LocationView(session: Session.sampleSessions[0])
}
