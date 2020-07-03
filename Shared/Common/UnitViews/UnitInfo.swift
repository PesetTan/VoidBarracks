//
//  UnitInfoView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitInfo: View {
    @ObservedObject var unit: Unit
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(unit.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    UnitStats(unit: unit)

                    if let rules = (unit.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (unit.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }

                    if let squad = unit as? Squad {
                        if let attachments = (squad.attachments as! Set<Attachment>) {
                            ForEach(attachments.sorted{$0.id! < $1.id!}, id:\.id) { attachment in
                                if (attachment.selected) {
                                    AttachmentView(attachment: attachment, headline: "Attachment:")
                                }
                            }
                        }
                    }

                    if let jack = unit as? Jack {
                        if let cortexes = (jack.optionsForCortex as! Set<Cortex>) {
                            ForEach(cortexes.sorted{$0.id! < $1.id!}, id:\.id) { cortex in
                                if (cortex.selected) {
                                    CortexView(cortex: cortex)
                                }
                            }
                        }

                        if let weapons = (jack.optionsForArm1 as! Set<Weapon>) {
                            ForEach(weapons.sorted{$0.id! < $1.id!}, id:\.id) { weapon in
                                if (weapon.selected) {
                                    JackWeaponView(weapon: weapon, headline: "Arm 1")
                                }
                            }
                        }
                        if let weapons = (jack.optionsForArm2 as! Set<Weapon>) {
                            ForEach(weapons.sorted{$0.id! < $1.id!}, id:\.id) { weapon in
                                if (weapon.selected) {
                                    JackWeaponView(weapon: weapon, headline: "Arm 2")
                                }
                            }
                        }
                        if let weapons = (jack.optionsForShoulder1 as! Set<Weapon>) {
                            ForEach(weapons.sorted{$0.id! < $1.id!}, id:\.id) { weapon in
                                if (weapon.selected) {
                                    JackWeaponView(weapon: weapon, headline: "Shoulder 1")
                                }
                            }
                        }
                        if let weapons = (jack.optionsForShoulder2 as! Set<Weapon>) {
                            ForEach(weapons.sorted{$0.id! < $1.id!}, id:\.id) { weapon in
                                if (weapon.selected) {
                                    JackWeaponView(weapon: weapon, headline: "Shoudler 2")
                                }
                            }
                        }
                    }


                }
            }
            .navigationBarTitle(Text("\(unit.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: DoneButton(isPresented: $isPresented))
        }
    }
}
