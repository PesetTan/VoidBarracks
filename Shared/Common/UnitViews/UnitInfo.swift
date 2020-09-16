//
//  UnitInfoView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI
import CoreData

struct UnitInfo: View {
    var unitFetchRequest: FetchRequest<Unit>
    var unit: Unit {
        return unitFetchRequest.wrappedValue.first ?? Unit()
    }

    var viewModelFetchRequest: FetchRequest<UnitViewModel>
    var viewModel: UnitViewModel {
        return viewModelFetchRequest.wrappedValue.first ?? UnitViewModel()
    }



    @Binding var isPresented: Bool

    init(unitId: String, viewModelId: String, isPresented: Binding<Bool>) {
        let predicate = NSPredicate(format: "id == %@", unitId)
        self.unitFetchRequest = FetchRequest(entity: Unit.entity(), sortDescriptors: [], predicate: predicate)

        let viewModelPredicate = NSPredicate(format: "uuid == %@", viewModelId)
        self.viewModelFetchRequest = FetchRequest(entity: UnitViewModel.entity(), sortDescriptors: [], predicate: viewModelPredicate)
        self._isPresented = isPresented
    }
    
    var body: some View {

        ScrollView (showsIndicators: false) {
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

                if let squad = viewModel as? SquadViewModel {
                    ForEach(squad.attachmentViewModelsArray, id:\.id) { attachment in
                        if attachment.count > 0 {
                            AttachmentInfo(attachmentId: attachment.id!)
                        }
                    }
                }

                if let jack = viewModel as? JackViewModel {

                    ForEach(jack.cortexOptionsArray, id:\.id) { cortex in
                        if cortex.count > 0 {
                            CortexView(cortexId: cortex.id!)
                        }
                    }

                    ForEach(jack.arm1OptionsArray, id:\.id) { weapon in
                        if weapon.count > 0 {
                            VStack {
                                Divider()
                                Text("Arm 1").font(.headline).foregroundColor(.gray)
                                WeaponView(weaponId: weapon.id!)
                            }
                        }
                    }

                    ForEach(jack.arm2OptionsArray, id:\.id) { weapon in
                        if weapon.count > 0 {
                            VStack {
                                Divider()
                                Text("Arm 2").font(.headline).foregroundColor(.gray)
                                WeaponView(weaponId: weapon.id!)
                            }
                        }
                    }

                    ForEach(jack.shoulder1OptionsArray, id:\.id) { weapon in
                        if weapon.count > 0 {
                            VStack {
                                Divider()
                                Text("Shoulder 1").font(.headline).foregroundColor(.gray)
                                WeaponView(weaponId: weapon.id!)
                            }
                        }
                    }

                    ForEach(jack.shoulder2OptionsArray, id:\.id) { weapon in
                        if weapon.count > 0 {
                            VStack {
                                Divider()
                                Text("Shoulder 2").font(.headline).foregroundColor(.gray)
                                WeaponView(weaponId: weapon.id!)
                            }
                        }
                    }

                }
            }
        }
    }
}
