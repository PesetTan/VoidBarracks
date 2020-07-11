//
//  JackList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct JackList: View {
    var jacks: [Jack]
    @Binding var refresh: Bool
    
    var body: some View {
        ForEach(jacks, id:\.id) { jack in

            if jack.uuid != nil {
                JackCell(jack: jack, refresh: $refresh)
                    .customCell()
                    .foregroundColor(.primary)

                CustomJackList(customJacks: jack.customJacksArray, refresh: $refresh)
                    .frame(height: 70 * CGFloat(jack.customJacksArray.count)).animation(.default)

            }
        }
    }
}

struct CustomJackList: View {
    var customJacks: [Jack]
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        List {
            ForEach(customJacks, id:\.uuid) { jack in
                UnitCell(unit: jack)
                    .customCell()
                    .foregroundColor(.accentColor)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let jack = customJacks[index]
                    context.delete(jack)
                    refresh.toggle()
                }
            }
            .listRowBackground(Color("BackgroundColor"))
        }
    }
}
