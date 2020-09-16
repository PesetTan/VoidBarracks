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
            .padding(.leading, 2)
            .padding(.trailing, 2)
            .padding(.bottom, -3)
            .padding(.top, -3)
            .shadow(color: Color("ShadowColor").opacity(0.5), radius: 7, x: 3, y: 3)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .background(
                Group {
                    if configuration.isPressed {
                        Rectangle()
                            .fill(Color.white)
                    }
                }
            )
    }
}

extension View {
    func customCell() -> some View {
        self.modifier(CustomCell())
    }
}
