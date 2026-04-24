//
//  SessionsListView.swift
//  BetterthanNGL
//

import SwiftUI

struct SessionsListView: View {
    @State private var sessions = Session.sampleSessions
    @State private var selectedSession: Session?
    @State private var selectedFilter = 0

    private let filters = ["Aujourd'hui", "Cette semaine", "Toutes"]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Bonjour,")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text("Étudiant M1")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            Image(systemName: "graduationcap.circle.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(.blue)
                        }

                        Divider()

                        HStack(spacing: 24) {
                            StatItem(value: "3", label: "Sessions", icon: "calendar")
                            Spacer()
                            StatItem(value: "4", label: "Signées", icon: "checkmark.circle.fill", color: .green)
                            Spacer()
                            StatItem(value: "2", label: "En attente", icon: "clock.circle", color: .orange)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    Picker("Période", selection: $selectedFilter) {
                        ForEach(0..<filters.count, id: \.self) { index in
                            Text(filters[index]).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Sessions") {
                    ForEach(sessions) { session in
                        Button(action: { selectedSession = session }) {
                            SessionRow(session: session)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Mes sessions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "person.circle")
                    }
                }
            }
            .sheet(item: $selectedSession) { session in
                SignatureOptionsView(session: session)
            }
        }
    }
}

struct StatItem: View {
    let value: String
    let label: String
    let icon: String
    var color: Color = .blue

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SessionsListView()
}
