//
//  CortexCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CortexCell: View {
    @ObservedObject var cortex: Cortex
    @ObservedObject var jack: Jack
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack{
                Text("\(cortex.name!)")
                Spacer()
                CortexToggle(selected: Binding<Bool>(
                    get: { cortex.selected },
                    set: { cortex.selected = $0 }
                ),
                jack: jack)
            }
        }
        .sheet(isPresented: $isPresented) {
            CortexInfo(cortex: cortex, isPresented: $isPresented)
        }
    }
}
