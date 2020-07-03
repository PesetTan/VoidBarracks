//
//  CypherCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherCell: View {
     var cypher: Cypher
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Toggle(isOn: Binding<Bool>(
                        get: { cypher.selected },
                        set: {
                            cypher.selected = $0
                        })) {
                    Text("\(cypher.name!)")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .sheet(isPresented: $isPresented) {
            CypherInfo(cypher: cypher, isPresented: $isPresented)
        }
    }
}
