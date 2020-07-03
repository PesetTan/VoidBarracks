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

                    Spacer()

                    HStack {
                        Spacer()
                        Text("\(cypher.type!)").font(.headline).foregroundColor(.gray)
                        Spacer()
                    }

                    HStack {
                        Text("\(cypher.rule!)").padding()
                    }
                }
            }
            .navigationBarTitle(Text("\(cypher.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: CypherInfoDoneButton(isPresented: $isPresented))

        }
    }
}

struct CypherInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }

    }
}
