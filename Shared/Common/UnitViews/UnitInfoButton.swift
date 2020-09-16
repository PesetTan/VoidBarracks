//
//  UnitInfoButton.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitInfoButton: View {
    var unit: UnitViewModel
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            Image(systemName: "info.circle")
                .font(.system(size: 25))
                .contentShape(Circle())
        }
        .sheet(isPresented: $isPresented) {
            UnitInfo(unitId: unit.id!, viewModelId: unit.uuid!, isPresented: $isPresented)
                .environment(\.managedObjectContext, context)
        }
    }
}
