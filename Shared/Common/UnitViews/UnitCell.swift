//
//  UnitCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitCell: View {
    @ObservedObject var unit: Unit
    @State private var isPresented: Bool = false

    var body: some View {

        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text("\(unit.name ?? "No Name")")

                Spacer()

                if unit is Hero {
                    UnitCounter(unit: unit, maxCount: 1)
                } else {
                    UnitCounter(unit: unit, maxCount: 3)
                }




            }
        }
        .sheet(isPresented: $isPresented) {
            UnitInfo(unit: unit, isPresented: $isPresented)
        }
    }
}
