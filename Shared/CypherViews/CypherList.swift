//
//  CypherList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherList: View {
    var rack: Rack
    @Binding var isActive: Bool

    var body: some View {
        Form {

            Section {
                if let cyphers = (rack.furies as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }

            Section {
                if let cyphers = (rack.geometrics as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }

            Section {
                if let cyphers = (rack.harmonics as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }

            Section {
                if let cyphers = (rack.overdrives as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Choose Cyphers"))
    }
}
