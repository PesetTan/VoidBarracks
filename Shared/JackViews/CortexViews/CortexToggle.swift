//
//  CortexToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct CortexToggle: View {
    @Binding var count: Int16
    @ObservedObject var jackViewModel: JackViewModel

    var body: some View {
        HStack {
            if count > 0 {
                Image(systemName: "circle.fill").foregroundColor(.accentColor)
            } else {
                Image(systemName: "circle.fill").foregroundColor(.gray).opacity(0.2)
            }
        }
        .onTapGesture {
            jackViewModel.cortexOptionsArray.forEach { item in
                item.count = 0
            }
            count = 1
        }
    }
}
