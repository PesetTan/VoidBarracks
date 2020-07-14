//
//  RulesView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct RulesView: View {
    var rules: [Rule]

    var body: some View {

        ForEach(rules, id:\.id) { rule in
            VStack(alignment: .leading) {
                HStack {
                    Text("\(rule.name!)").font(.subheadline).foregroundColor(.gray)
                    Spacer()
                }

                Text("\(rule.text!)")
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
        }

    }
}
