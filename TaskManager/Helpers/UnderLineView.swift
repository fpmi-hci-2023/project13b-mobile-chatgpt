//
//  UnderLinedView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 18.11.23.
//

import SwiftUI

struct UnderlineView: ViewModifier {
    let spacing: CGFloat
    let height: CGFloat
    let color: Color

    func body(content: Content) -> some View {
        VStack(spacing: spacing) {
            content
            Rectangle()
                .frame(height: height)
                .foregroundColor(color)
        }
    }
}

extension View {
    func underlined(spacing: CGFloat = 3,
                    height: CGFloat = 0.8,
                    color: Color = .white) -> some View {
        self.modifier(UnderlineView(spacing: spacing,
                                    height: height,
                                    color: color))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
