//
//  CypherInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherInfo: View {
    @ObservedObject var cypher: Cypher
    @Binding var isPresented: Bool

    var body: some View {

        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    DoneButton(isPresented: $isPresented)
                        .padding()
                }
                .padding(.bottom, 10)


                Text("\(cypher.name!)")
                    .font(.system(size: 25, weight: .bold, design: .default))


                HStack {
                    Spacer()
                    Text("\(cypher.type!)").font(.headline).foregroundColor(.gray)
                    if (cypher.pow > 0) {
                        Text("POW \(cypher.pow)").font(.headline).foregroundColor(.gray)
                    }
                    Spacer()
                }

                Text("\(cypher.rule!)").padding()

            }
        }

    }
}
