//
//  CustomSquadCell.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct CustomSquadCell: View {
    @ObservedObject var squad: Squad
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            if let squadName = squad.name {
                HStack {
                    CounterView(count: squad.count)
                    Stepper {
                        squad.count += 1
                    } onDecrement: {
                        squad.count -= 1
                    } label: {
                        Text("\(squadName)")
                    }
                }
            }

        }
        .sheet(isPresented: $isPresented) {
            UnitInfo(unit: squad, isPresented: $isPresented)
        }
    }
}
