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

            UnitStats(unit: attachment)

            RulesView(rules: attachment.rulesArray)

            WeaponsView(weapons: attachment.weaponsArray)
        }
    }
}
