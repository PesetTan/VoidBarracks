//
//  CortexInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CortexInfo: View {
    var cortex: Cortex
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    RulesView(rules: cortex.rulesArray)
                        .padding(.top, 10)
                }
            }
            .navigationBarTitle(Text("\(cortex.name!)"))
            .navigationBarItems(trailing: DoneButton(isPresented: $isPresented))
        }
    }
}
