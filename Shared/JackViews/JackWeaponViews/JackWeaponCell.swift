//
//  JackWeaponCell.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponCell: View {
    @ObservedObject var weaponViewModel: WeaponViewModel
    var weaponViewModels: [WeaponViewModel]
    @ObservedObject var jackViewModel: JackViewModel
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("\(weaponViewModel.name!)")
                    .foregroundColor(.accentColor)
            }
            .sheet(isPresented: $isPresented) {
                JackWeaponInfo(weaponViewModel: weaponViewModel, isPresented: $isPresented)
                    .environment(\.managedObjectContext, context)
            }
            Spacer()

            WeaponToggle(count: Binding<Int16>(
                get: { weaponViewModel.count },
                set: {weaponViewModel.count = $0}
            ),
            weaponViewModel: weaponViewModel,
            groupViewModel: weaponViewModels,
            jackViewModel: jackViewModel)

        }

    }
}
