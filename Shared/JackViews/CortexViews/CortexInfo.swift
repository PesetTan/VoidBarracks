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
                    Text("")
                    if let rules = (cortex.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }
                }
            }
            .navigationBarTitle(Text("\(cortex.name!)"))
            .navigationBarItems(trailing: CortexInfoDoneButton(isPresented: $isPresented))
        }
    }
}

struct CortexInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Text("Done")
        }

    }
}
