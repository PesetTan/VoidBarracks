//
//  CypherList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherList: View {
    @EnvironmentObject var army: Army

    var body: some View {
        Form {
            Section(header: furyHeader) {
                if let cyphers = (army.rack!.furies as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }

            Section(header: geometricsHeader) {
                if let cyphers = (army.rack!.geometrics as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }

            Section(header: harmonicsHeader) {
                if let cyphers = (army.rack!.harmonics as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }

            Section(header: overdrivesHeader) {
                if let cyphers = (army.rack!.overdrives as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Choose Cyphers"))
    }

    var furyHeader: some View {
        HStack{
            Image(systemName: "flame")
            Text("Furies")

            Spacer()

            if let rack = army.rack, rack.furyCount < 3 {
                Text("Select At Least \(3 - rack.furyCount) more")
            }
        }
    }

    var geometricsHeader: some View {
        HStack {
            Image(systemName: "square.grid.3x2")
            Text("Geometrics")

            Spacer()

            if let rack = army.rack, rack.geometricCount < 3 {
                Text("Select At Least \(3 - rack.geometricCount) more")
            }
        }
    }

    var harmonicsHeader: some View {
        HStack {
            Image(systemName: "music.note")
            Text("Harmonics")

            Spacer()

            if let rack = army.rack, rack.harmonicCount < 3 {
                Text("Select At Least \(3 - rack.harmonicCount) more")
            }
        }
    }

    var overdrivesHeader: some View {
        HStack {
            Image(systemName: "bolt")
            Text("Overdrives")

            Spacer()

            if let rack = army.rack, rack.overdriveCount < 3 {
                Text("Select At Least \(3 - rack.overdriveCount) more")
            }
        }
    }
}
