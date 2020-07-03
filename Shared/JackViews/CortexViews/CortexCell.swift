//
//  CortexCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CortexCell: View {
    @ObservedObject var cortex: Cortex
    var cortexes: Set<Cortex>
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Toggle(isOn: Binding<Bool>(
                        get: { cortex.selected },
                        set: {
                            cortexes.forEach { $0.selected = false }
                            cortex.selected = $0
                        })) {
                    Text("\(cortex.name!)")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .sheet(isPresented: $isPresented) {
            CortexInfo(cortex: cortex, isPresented: $isPresented)
        }
    }
}
