//
//  AttachmentInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentInfo: View {
    var attachment: Attachment
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")
                    if let rules = (attachment.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (attachment.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }
                }
            }
            .navigationBarTitle(Text("\(attachment.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: AttachmentInfoDoneButton(isPresented: $isPresented))
        }
    }
}

struct AttachmentInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }

    }
}
