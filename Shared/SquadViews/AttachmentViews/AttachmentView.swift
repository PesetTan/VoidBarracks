//
//  AttachmentView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentView: View {
    var attachment: Attachment
    var headline: String
    @State var isPresented: Bool = false

    var body: some View {
        VStack {
            Divider()

            HStack {
                Spacer()
                Text("\(attachment.title!)").font(.title).foregroundColor(.gray)
                Spacer()
            }

            AttachmentStatsView(squad: attachment)

            if let rules = (attachment.rules as! Set<Rule>) {
                RulesView(rules: rules)
            }

            if let weapons = (attachment.weapons as! Set<Weapon>) {
                WeaponsView(weapons: weapons)
            }
        }
    }
}
