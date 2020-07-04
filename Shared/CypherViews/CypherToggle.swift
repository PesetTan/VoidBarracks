//
//  CypherToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct CypherToggle: View {
    @ObservedObject var cypher: Cypher
    var maxCount: Int = 1

    var body: some View {
        HStack {
            ForEach(0 ..< maxCount) { index in
                if index >= cypher.count {
                    Image(systemName: "circle").foregroundColor(.gray).opacity(0.5)
                } else {
                    Image(systemName: "circle.fill").foregroundColor(.accentColor)
                }
            }

        }
        .onTapGesture {
            cypher.count += 1
            if cypher.count > maxCount {
                cypher.count = 0
            }
        }
    }
}

