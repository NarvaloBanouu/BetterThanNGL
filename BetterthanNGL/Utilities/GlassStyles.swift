//
//  GlassStyles.swift
//  BetterthanNGL
//
//  Reusable glass (liquid) styles for buttons and cards
//

import SwiftUI

struct GlassButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 12

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            // Use the reusable glass effect modifier for consistency
            .glassEffect(cornerRadius: cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.06 : 0.12), radius: configuration.isPressed ? 2 : 8, x: 0, y: configuration.isPressed ? 1 : 4)
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 16) -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
            )
            .cornerRadius(cornerRadius)
    }
}

// MARK: - Glass effect modifier (simplified implementation)
struct GlassEffectModifier: ViewModifier {
    var cornerRadius: CGFloat = 12
    func body(content: Content) -> some View {
        content
            .background(
                // layering a material + subtle gradient to approximate Apple's glass effect
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .background(.thinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(LinearGradient(colors: [Color.white.opacity(0.10), Color.white.opacity(0.02)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            )
            .cornerRadius(cornerRadius)
    }
}

extension View {
    /// Apply a liquid glass style similar to Apple's sample
    func glassEffect(cornerRadius: CGFloat = 12) -> some View {
        modifier(GlassEffectModifier(cornerRadius: cornerRadius))
    }

    /// A convenience hook for matched geometry effects used in Apple's sample. If a namespace is
    /// provided it applies a matchedGeometryEffect, otherwise it's a no-op.
    func glassEffectID(_ id: String, in namespace: Namespace.ID?) -> some View {
        if let ns = namespace {
            return AnyView(self.matchedGeometryEffect(id: id, in: ns))
        } else {
            return AnyView(self)
        }
    }
}

/// A simple container that groups views into a glass-styled layout
struct GlassEffectContainer<Content: View>: View {
    let spacing: CGFloat
    let content: () -> Content

    init(spacing: CGFloat = 12.0, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        HStack(spacing: spacing) {
            content()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .cornerRadius(16)
    }
}
