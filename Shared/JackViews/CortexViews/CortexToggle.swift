//
//  CortexToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct CortexToggle: View {
    @Binding var selected: Bool
    var group: Set<Cortex>

    var body: some View {
        HStack {
            if selected {
                Image(systemName: "circle.fill").foregroundColor(.accentColor)
            } else {
                Image(systemName: "circle.fill").foregroundColor(.gray).opacity(0.2)
            }
        }
        .onTapGesture {
            group.forEach { item in
                item.selected = false
            }
            selected = true
        }
    }
}
