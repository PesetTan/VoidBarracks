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
            }

            if let customJacks = (jack.customJacks as! Set<Jack>) {
                CustomJackList(customJacks: customJacks, refresh: $refresh)
            }
        }
    }
}
//
//struct CustomJackList: View {
//    var customJacks: Set<Jack>
//    @Binding var refresh: Bool
//    @Environment(\.managedObjectContext) private var context
//
//    var body: some View {
//        let jacks = customJacks.sorted{$0.lastModified! < $1.lastModified!}
//        return List {
//            ForEach(jacks, id:\.uuid) { jack in
//                CustomJackCell(jack: jack)
//            }
//            .onDelete { indexSet in
//                indexSet.forEach { index in
//                    let jack = jacks[index]
//                    context.delete(jack)
//                    refresh.toggle()
//                }
//            }
//        }
//    }
//}
