//
//  CypherList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherList: View {
    @StateObject var rack: Rack

    var body: some View {
        Form {

            Section(header: furyHeader) {
                if let cyphers = (rack.furies as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher, rack: rack)
                    }
                }
            }

            Section(header: geometricsHeader) {
                if let cyphers = (rack.geometrics as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher, rack: rack)
                    }
                }
            }

            Section(header: harmonicsHeader) {
                if let cyphers = (rack.harmonics as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher, rack: rack)
                    }
                }
            }

            Section(header: overdrivesHeader) {
                if let cyphers = (rack.overdrives as! Set<Cypher>) {
                    ForEach(cyphers.sorted{$0.id! < $1.id!}, id:\.id) { cypher in
                        CypherCell(cypher: cypher, rack: rack)
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

            if rack.furyCount < 3 {
                Text("Select At Least \(3 - rack.furyCount) more")
            }
        }
    }

    var geometricsHeader: some View {
        HStack {
            Image(systemName: "square.grid.3x2")
            Text("Geometrics")

            Spacer()

            if rack.geometricCount < 3 {
                Text("Select At Least \(3 - rack.geometricCount) more")
            }
        }
    }

    var harmonicsHeader: some View {
        HStack {
            Image(systemName: "music.note")
            Text("Harmonics")

            Spacer()

            if rack.harmonicCount < 3 {
                Text("Select At Least \(3 - rack.harmonicCount) more")
            }
        }
    }

    var overdrivesHeader: some View {
        HStack {
            Image(systemName: "bolt")
            Text("Overdrives")

            Spacer()

            if rack.overdriveCount < 3 {
                Text("Select At Least \(3 - rack.overdriveCount) more")
            }
        }
    }
}
