//
//  SquadList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SquadList: View {
    var squads: [Squad]
    @Binding var refresh: Bool
    
    var body: some View {
        ForEach(squads, id:\.id) { squad in
            SquadCell(squad: squad, refresh: $refresh)
                .customCell()

            if let customSquads = (squad.customSquads as! Set<Squad>) {
                CustomSquadList(customSquads: customSquads, refresh: $refresh)
            }
        }
    }
}


struct CustomSquadList: View {
    var customSquads: Set<Squad>
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        let squads = customSquads.sorted{$0.lastModified! < $1.lastModified!}
        return List {
            ForEach(squads, id:\.uuid) { squad in
                UnitCell(unit: squad)
                    .customCell()
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let squad = squads[index]
                    context.delete(squad)
                    refresh.toggle()
                }
            }
        }
    }
}
