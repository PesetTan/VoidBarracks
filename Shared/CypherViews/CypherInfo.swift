//
//  CypherInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherInfo: View {
    var fetchRequest: FetchRequest<Cypher>
    var cypher: Cypher? {
        fetchRequest.wrappedValue.first ?? nil
    }
    @Binding var isPresented: Bool

    init(cypherId: String, isPresented: Binding<Bool>) {
        let predicate = NSPredicate(format: "id == %@", cypherId)
        self.fetchRequest = FetchRequest(entity: Cypher.entity(), sortDescriptors: [], predicate: predicate)
        self._isPresented = isPresented
    }

    var body: some View {
        if let cypher = cypher {
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
}
