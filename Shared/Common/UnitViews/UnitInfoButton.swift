//
//  UnitInfoButton.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitInfoButton: View {
    var unit: Unit?
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "info.circle")
        }
        .sheet(isPresented: $isPresented) {
            if unit != nil && unit!.uuid != nil {
                UnitInfo(unit: unit!, isPresented: $isPresented)
            }
        }
    }
}
