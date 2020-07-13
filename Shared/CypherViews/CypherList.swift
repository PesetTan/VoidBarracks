//
//  CypherList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CypherList: View {
    @EnvironmentObject var viewModel: CypherViewModel

    var body: some View {
        Form {
            Section(header: furyHeader) {
                ForEach(viewModel.furiesArray, id:\.id) { cypher in
                    CypherCell(viewModel: cypher)
                }
            }

            Section(header: geometricsHeader) {
                ForEach(viewModel.geometricsArray, id:\.id) { cypher in
                    CypherCell(viewModel: cypher)
                }
            }

            Section(header: harmonicsHeader) {
                ForEach(viewModel.harmonicsArray, id:\.id) { cypher in
                    CypherCell(viewModel: cypher)
                }
            }

            Section(header: overdrivesHeader) {
                ForEach(viewModel.overdrivesArray, id:\.id) { cypher in
                    CypherCell(viewModel: cypher)
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

            if let rack = viewModel {
                let totalCypherCount = rack.furyCount + rack.geometricCount + rack.harmonicCount + rack.overdriveCount

                if rack.furyCount < 3 {
                    Text("Requires \(3 - rack.furyCount) more Furies")
                        .font(.caption)
                } else if totalCypherCount > 15 {
                    Text("\(totalCypherCount - 15) Cyphers Over")
                        .font(.caption)
                } else {
                    Text("\(totalCypherCount)/\(15) Cyphers")
                        .font(.caption)
                }
            }



        }
    }

    var geometricsHeader: some View {
        HStack {
            Image(systemName: "square.grid.3x2")
            Text("Geometrics")

            Spacer()

            if let rack = viewModel {
                let totalCypherCount = rack.furyCount + rack.geometricCount + rack.harmonicCount + rack.overdriveCount

                if rack.geometricCount < 3 {
                    Text("Requires \(3 - rack.geometricCount) more Geomatrics")
                        .font(.caption)
                } else if totalCypherCount > 15 {
                    Text("\(totalCypherCount - 15) Cyphers Over")
                        .font(.caption)
                } else {
                    Text("\(totalCypherCount)/\(15) Cyphers")
                        .font(.caption)
                }
            }
        }
    }

    var harmonicsHeader: some View {
        HStack {
            Image(systemName: "music.note")
            Text("Harmonics")

            Spacer()

            if let rack = viewModel {
                let totalCypherCount = rack.furyCount + rack.geometricCount + rack.harmonicCount + rack.overdriveCount

                if rack.harmonicCount < 3 {
                    Text("Requires \(3 - rack.harmonicCount) more Harmonics")
                        .font(.caption)
                } else if totalCypherCount > 15 {
                    Text("\(totalCypherCount - 15) Cyphers Over")
                        .font(.caption)
                } else {
                    Text("\(totalCypherCount)/\(15) Cyphers")
                        .font(.caption)
                }
            }
        }
    }

    var overdrivesHeader: some View {
        HStack {
            Image(systemName: "bolt")
            Text("Overdrives")

            Spacer()

            if let rack = viewModel {
                let totalCypherCount = rack.furyCount + rack.geometricCount + rack.harmonicCount + rack.overdriveCount

                if rack.overdriveCount < 3 {
                    Text("Requires \(3 - rack.overdriveCount) more Overdrives")
                        .font(.caption)
                } else if totalCypherCount > 15 {
                    Text("\(totalCypherCount - 15) Cyphers Over")
                        .font(.caption)
                } else {
                    Text("\(totalCypherCount)/\(15) Cyphers")
                        .font(.caption)
                }
            }
        }
    }
}
