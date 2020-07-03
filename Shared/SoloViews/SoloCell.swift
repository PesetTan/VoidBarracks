//
//  SoloCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SoloCell: View {
    @ObservedObject var solo: Solo
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                CounterView(count: solo.count)
                Stepper {
                    solo.count += 1
                } onDecrement: {
                    solo.count -= 1
                } label: {
                    Text("\(solo.name!)")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            SoloInfo(solo: solo, isPresented: $isPresented)
        }
    }
}
