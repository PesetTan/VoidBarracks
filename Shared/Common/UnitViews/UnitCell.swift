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
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                HStack {
                    unitName
                    cortexName
                }
            }
            .sheet(isPresented: $isPresented) {
                UnitInfo(unit: unit, isPresented: $isPresented)
            }

            Spacer()

            if unit is Hero {
                UnitCounter(unit: unit, maxCount: 1)
            } else {
                UnitCounter(unit: unit, maxCount: 3)
            }
        }
    }

    var unitName: some View {
        if let jack = unit as? Jack {
            if jack.customName! == "" {
                return Text(jack.name!)
            } else {
                return Text(jack.customName!)
            }
        } else if let squad = unit as? Squad {
            if squad.customName! == "" {
                return Text(squad.name!)
            } else {
                return Text(squad.customName!)
            }
        } else {
            return Text("\(unit.name ?? "No Name")")
        }
    }

    var cortexName: some View {
        if let jack = unit as? Jack, let cortexes = (jack.optionsForCortex as! Set<Cortex>?) {
            if let cortex = cortexes.first(where: {$0.selected}) {
                return Text(cortex.name!).font(.caption)
            } else {
                return Text("")
            }
        } else {
            return Text("")
        }
    }
}
