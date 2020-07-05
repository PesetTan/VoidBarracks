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
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(cypher.name!)").font(.title)
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        Text("\(cypher.type!)").font(.headline).foregroundColor(.gray)
                        if (cypher.pow > 0) {
                            Text("POW \(cypher.pow)").font(.headline).foregroundColor(.gray)
                        }
                        Spacer()
                    }

                    HStack {
                        Text("\(cypher.rule!)").padding()
                    }
                }
            }
            .navigationBarItems(trailing: DoneButton(isPresented: $isPresented))

        }
    }
}
