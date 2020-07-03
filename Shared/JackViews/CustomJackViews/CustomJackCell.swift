//
//  ConfiguredJackCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CustomJackCell: View {
    @ObservedObject var jack: Jack
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            if let jackName = jack.name {
                HStack {
                    CounterView(count: jack.count)
                    Stepper {
                        jack.count += 1
                    } onDecrement: {
                        jack.count -= 1
                    } label: {
                        Text("\(jackName)")
                    }
                }
            }

        }
        .sheet(isPresented: $isPresented) {
            CustomJackInfo(jack: jack, isPresented: $isPresented)
        }
    }
}
