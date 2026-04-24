//
//  Session.swift
//  BetterthanNGL
//
//  Created by Claude on 21/04/2026.
//

import Foundation

struct Session: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    let startTime: String
    let endTime: String
    let room: String
    let instructor: String
    var morningStatus: SignatureStatus
    var afternoonStatus: SignatureStatus

    enum SignatureStatus {
        case notSigned
        case signed
        case pending

        var displayText: String {
            switch self {
            case .notSigned: return "Non signée"
            case .signed: return "Signée"
            case .pending: return "En attente"
            }
        }

        var icon: String {
            switch self {
            case .notSigned: return "circle"
            case .signed: return "checkmark.circle.fill"
            case .pending: return "clock.circle"
            }
        }
    }

    var isComplete: Bool {
        morningStatus == .signed && afternoonStatus == .signed
    }
}

// MARK: - Sample Data
extension Session {
    static let sampleSessions = [
        Session(
            id: UUID(),
            title: "Développement iOS - SwiftUI",
            date: Date(),
            startTime: "09:00",
            endTime: "17:00",
            room: "Salle A201",
            instructor: "Prof. Martin Dupont",
            morningStatus: .notSigned,
            afternoonStatus: .notSigned
        ),
        Session(
            id: UUID(),
            title: "Architecture Mobile Avancée",
            date: Date().addingTimeInterval(86400),
            startTime: "09:00",
            endTime: "17:00",
            room: "Salle B105",
            instructor: "Prof. Sophie Bernard",
            morningStatus: .signed,
            afternoonStatus: .notSigned
        ),
        Session(
            id: UUID(),
            title: "Conception d'interfaces",
            date: Date().addingTimeInterval(172800),
            startTime: "14:00",
            endTime: "18:00",
            room: "Salle C302",
            instructor: "Prof. Jean Moreau",
            morningStatus: .signed,
            afternoonStatus: .signed
        )
    ]
}
