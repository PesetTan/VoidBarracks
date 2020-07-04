//
//  ViewModifiers.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/4/20.
//

import SwiftUI

struct CustomCell: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .shadow(color: Color.primary.opacity(0.2), radius: 7, x: 3, y: 3)
    }
}

extension View {
    func customCell() -> some View {
        self.modifier(CustomCell())
    }
}
