//
//  SessionRow.swift
//  BetterthanNGL
//

import SwiftUI

struct SessionRow: View {
    let session: Session

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(session.title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(dateFormatter.string(from: session.date).capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if session.isComplete {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                        .font(.title3)
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 6) {
                Label("\(session.startTime) - \(session.endTime)", systemImage: "clock")
                Label(session.room, systemImage: "location")
                Label(session.instructor, systemImage: "person")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            Divider()

            HStack(spacing: 16) {
                SignatureStatusBadge(period: "Matin", status: session.morningStatus)
                Spacer()
                SignatureStatusBadge(period: "Après-midi", status: session.afternoonStatus)
            }
        }
        .padding(.vertical, 4)
    }
}

struct SignatureStatusBadge: View {
    let period: String
    let status: Session.SignatureStatus

    private var statusColor: Color {
        switch status {
        case .signed: return .green
        case .notSigned: return .gray
        case .pending: return .orange
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: status.icon)
                .foregroundStyle(statusColor)

            VStack(alignment: .leading, spacing: 2) {
                Text(period)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(status.displayText)
                    .font(.caption)
                    .foregroundStyle(statusColor)
                    .fontWeight(.medium)
            }
        }
    }
}

