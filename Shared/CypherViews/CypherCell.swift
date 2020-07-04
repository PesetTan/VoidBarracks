//
//  CypherCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherCell: View {
    @ObservedObject var cypher: Cypher
    @ObservedObject var rack: Rack
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text("\(cypher.name!)")
                Spacer()
                CypherToggle(cypher: cypher, rack: rack)
            }
        }
        .sheet(isPresented: $isPresented) {
            CypherInfo(cypher: cypher, isPresented: $isPresented)
        }
    }
}
