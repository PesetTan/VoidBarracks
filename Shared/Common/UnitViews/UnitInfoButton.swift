//
//  UnitInfoButton.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitInfoButton: View {
    var unit: Unit?
    @State private var isPresented: Bool = false

    var body: some View {

//        Image(systemName: "info.circle")
//            .font(.system(size: 25))
//            .onTapGesture(perform: {isPresented = true})
//            .sheet(isPresented: $isPresented) {
//                if unit != nil && unit!.uuid != nil {
//                    UnitInfo(unit: unit!, isPresented: $isPresented)
//                }
//            }
//
        Button {
            isPresented = true
        } label: {
            Image(systemName: "info.circle")
                .font(.system(size: 25))
        }
        .sheet(isPresented: $isPresented) {
            if unit != nil && unit!.uuid != nil {
                UnitInfo(unit: unit!, isPresented: $isPresented)
            }
        }
    }
}
