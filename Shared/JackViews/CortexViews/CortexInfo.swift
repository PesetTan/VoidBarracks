//
//  CortexInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct CortexInfo: View {
    @Binding var isPresented: Bool
    var fetchRequest: FetchRequest<Cortex>
    var cortex: Cortex {
        fetchRequest.wrappedValue.first ?? Cortex()
    }

    init(cortexId: String, isPresented: Binding<Bool>) {
        let predicate = NSPredicate(format: "id == %@", cortexId)
        self.fetchRequest = FetchRequest(entity: Cortex.entity(), sortDescriptors: [], predicate: predicate)
        self._isPresented = isPresented
    }


    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                DoneButton(isPresented: $isPresented)
                    .font(.headline).foregroundColor(.gray)
                    .padding()
            }
            .padding(.bottom, 10)

            Text("\(cortex.name!)").font(.system(size: 25, weight: .bold, design: .default))

            VStack {
                RulesView(rules: cortex.rulesArray)
                    .padding(.top, 10)
            }
        }
    }
}
