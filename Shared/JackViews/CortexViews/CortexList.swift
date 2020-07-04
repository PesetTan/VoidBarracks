//
//  CortexList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CortexList: View {
    var cortexes: Set<Cortex>
    @ObservedObject var jack: Jack

    var body: some View {
        ForEach(cortexes.sorted{$0.id! < $1.id!}, id:\.id) { cortex in
            CortexCell(cortex: cortex, jack: jack)
        }
    }
}
