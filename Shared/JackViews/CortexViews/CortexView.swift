//
//  CortexView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct CortexView: View {
    var fetchRequest: FetchRequest<Cortex>
    var cortex: Cortex {
        fetchRequest.wrappedValue.first ?? Cortex()
    }

    init(cortexId: String) {
        let predicate = NSPredicate(format: "id == %@", cortexId)
        self.fetchRequest = FetchRequest(entity: Cortex.entity(), sortDescriptors: [], predicate: predicate)
    }

    var body: some View {
        VStack {
            Divider()
            Text("Cortex: \(cortex.name!)").font(.headline).foregroundColor(.gray)
            RulesView(rules: cortex.rulesArray)
        }
    }
}
