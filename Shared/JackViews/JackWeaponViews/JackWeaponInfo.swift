//
//  WeaponInfo.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponInfo: View {
    var weaponViewModel: WeaponViewModel
    @Binding var isPresented: Bool

    var body: some View {
            ScrollView (showsIndicators: false) {
                VStack {
                    HStack {
                        Spacer()
                        DoneButton(isPresented: $isPresented)
                            .padding()
                    }
                    Text("\(weaponViewModel.name!)")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .padding()

                    WeaponView(weaponId: weaponViewModel.id!)
                }
            }
        }
    }

