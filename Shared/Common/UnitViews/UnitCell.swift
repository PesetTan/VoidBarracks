//
//  UnitCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitCell: View {
    @ObservedObject var unit: Unit
    @State var isPresented: Bool = false

    var body: some View {

        Button {
            isPresented.toggle()
        } label: {
            HStack {
                UnitCounter(unit: unit)
                Stepper {
                    unit.count += 1
                } onDecrement: {
                    unit.count -= 1
                } label: {
                    Text("\(unit.name!)")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            UnitInfo(unit: unit, isPresented: $isPresented)
        }
    }
}
