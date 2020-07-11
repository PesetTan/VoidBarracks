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

        ScrollView {
            HStack {
                Spacer()
                DoneButton(isPresented: $isPresented)
                    .padding()
            }

            VStack {
                Text("\(unit.name!)").font(.system(size: 25, weight: .bold, design: .default))
                    .padding(.top, 10)

                Text("\(unit.title!)").font(.title2).foregroundColor(.gray)

                Text("Deployment Cost: \(unit.cost)")
                    .padding(.bottom, 10)

                UnitStats(unit: unit)

                RulesView(rules: unit.rulesArray)

                WeaponsView(weapons: unit.weaponsArray)

                if let squad = unit as? Squad {
                    ForEach(squad.attachmentsArray, id:\.id) { attachment in
                        if attachment.count > 0 {
                            AttachmentView(attachment: attachment, headline: "Attachment:")
                        }
                    }
                }

                if let jack = unit as? Jack {

                    ForEach(jack.optionsForCortexArray, id:\.id) { cortex in
                        if cortex.selected {
                            CortexView(cortex: cortex)
                        }
                    }

                    ForEach(jack.optionsForArm1Array, id:\.id) { weapon in
                        if weapon.selected {
                            JackWeaponView(weapon: weapon, headline: "Arm 1")
                        }
                    }

                    ForEach(jack.optionsForArm2Array, id:\.id) { weapon in
                        if weapon.selected {
                            JackWeaponView(weapon: weapon, headline: "Arm 2")
                        }
                    }

                    ForEach(jack.optionsForShoulder1Array, id:\.id) { weapon in
                        if weapon.selected {
                            JackWeaponView(weapon: weapon, headline: "Shoulder 1")
                        }
                    }

                    ForEach(jack.optionsForShoulder2Array, id:\.id) { weapon in
                        if weapon.selected {
                            JackWeaponView(weapon: weapon, headline: "Shoudler 2")
                        }
                    }

                }
            }
        }
    }
}
