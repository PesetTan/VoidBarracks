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
            if squad.uuid != nil {
                SquadCell(squad: squad, refresh: $refresh)
                    .customCell()
                    .foregroundColor(.primary)

                CustomSquadList(customSquads: squad.customSquadsArray, refresh: $refresh)
                    .frame(height: 70 * CGFloat(squad.customSquadsArray.count)).animation(.default)

            }
        }
    }
}


struct CustomSquadList: View {
    var customSquads: [Squad]
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        List {
            ForEach(customSquads, id:\.uuid) { squad in
                UnitCell(unit: squad)
                    .customCell()
                    .foregroundColor(.accentColor)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let squad = customSquads[index]
                    context.delete(squad)
                    refresh.toggle()
                }
            }
            .listRowBackground(Color("BackgroundColor"))
        }
    }
}
