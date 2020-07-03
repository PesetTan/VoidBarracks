//
//  RulesView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct RulesView: View {
    var rules: Set<Rule>

    var body: some View {

        ForEach(rules.sorted{$0.id! < $1.id!}, id:\.id) { rule in
            VStack(alignment: .leading) {
                HStack {
                    Text("\(rule.name!)").font(.subheadline).foregroundColor(.gray)
                    Spacer()
                }

                Text("\(rule.text!)")
            }
            .padding()
        }

    }
}
