//
//  CustomJackList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct CustomJackList: View {
    var customJacks: Set<Jack>
    @Binding var refresh: Bool
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        let jacks = customJacks.sorted{$0.lastModified! < $1.lastModified!}
        return List {
            ForEach(jacks, id:\.uuid) { jack in
                CustomJackCell(jack: jack)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let jack = jacks[index]
                    context.delete(jack)
                    refresh.toggle()
                }
            }
        }
    }
}
