//
//  SessionsListView.swift
//  BetterthanNGL
//

import SwiftUI

struct SessionsListView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var sessions = Session.sampleSessions
    @State private var selectedSession: Session?
    @State private var selectedFilter = 0

    private let filters = ["Aujourd'hui", "Cette semaine", "Toutes"]

    private var filteredSessions: [Session] {
        let cal = Calendar.current
        switch selectedFilter {
        case 0: // Today
            return sessions.filter { cal.isDateInToday($0.date) }
        case 1: // This week
            if let interval = cal.dateInterval(of: .weekOfYear, for: Date()) {
                return sessions.filter { $0.date >= interval.start && $0.date <= interval.end }
            }
            return sessions
        default:
            return sessions
        }
    }

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
                                Text(auth.username.isEmpty ? "Étudiant M1" : auth.username)
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
                    .padding(.all, 16)
                    // Use a white card for the greeting/stats block to keep visual consistency
                    .background(AnyView(RoundedRectangle(cornerRadius: 12).fill(Color.white)))
                    .cornerRadius(12)
                    .listRowInsets(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
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
                    ForEach(filteredSessions) { session in
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
                    Menu {
                        Button("Déconnexion", role: .destructive) {
                            auth.logout()
                        }
                    } label: {
                        Image(systemName: "person.circle")
                    }
                }
            }
            .sheet(item: $selectedSession) { session in
                SignatureOptionsView(session: session)
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteSignature)) { _ in
                // Close the sheet and any child fullScreenCovers by clearing the selected session
                selectedSession = nil
            }
            .onReceive(NotificationCenter.default.publisher(for: .didSignSession)) { note in
                guard let info = note.userInfo,
                      let idString = info["sessionID"] as? String,
                      let id = UUID(uuidString: idString),
                      let idx = sessions.firstIndex(where: { $0.id == id })
                else { return }

                // Simple strategy: mark the first notSigned slot (morning then afternoon) as signed
                if sessions[idx].morningStatus == .notSigned {
                    sessions[idx].morningStatus = .signed
                } else if sessions[idx].afternoonStatus == .notSigned {
                    sessions[idx].afternoonStatus = .signed
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteSignature)) { _ in
                // Close the sheet and any child fullScreenCovers by clearing the selected session
                selectedSession = nil
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteSignature)) { _ in
                // Close the sheet and any child fullScreenCovers by clearing the selected session
                selectedSession = nil
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
        .environmentObject(AuthViewModel())
}
