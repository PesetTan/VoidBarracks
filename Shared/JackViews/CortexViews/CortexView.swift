//
//  CortexView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct CortexView: View {
    var cortex: Cortex

    var body: some View {
        VStack {
            Divider()
            Text("Cortex: \(cortex.name!)").font(.headline).foregroundColor(.gray)
            RulesView(rules: (cortex.rules as! Set<Rule>))
        }
    }
}
