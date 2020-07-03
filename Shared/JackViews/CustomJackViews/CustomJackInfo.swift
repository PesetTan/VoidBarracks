//
//  CustomJackInfo.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct CustomJackInfo: View {
    @ObservedObject var jack: Jack
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(jack.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    JackStatsView(jack: jack)

                    if let rules = (jack.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (jack.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }

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
            .navigationBarTitle(Text("\(jack.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: JackInfoDoneButton(jack: jack, isPresented: $isPresented))
        }
    }
}
