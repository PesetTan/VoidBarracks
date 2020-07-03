//
//  CustomSquadInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct CustomSquadInfo: View {
    @ObservedObject var squad: Squad
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(squad.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    SquadStatsView(squad: squad)

                    if let rules = (squad.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (squad.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }

                    if let attachments = (squad.attachments as! Set<Attachment>) {
                        ForEach(attachments.sorted{$0.id! < $1.id!}, id:\.id) { attachment in
                            if (attachment.selected) {
                                AttachmentView(attachment: attachment, headline: "Attachment:")
                            }
                        }
                    }

                }
            }
            .navigationBarTitle(Text("\(squad.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: SquadInfoDoneButton(isPresented: $isPresented))
        }
    }
}
