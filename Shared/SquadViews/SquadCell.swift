//
//  SquadCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SquadCell: View {
    @EnvironmentObject var armyViewModel: ArmyViewModel
    @ObservedObject var squadViewModel: UnitViewModel
    @State var isPresented: Bool = false
    @Binding var refresh: Bool

    var body: some View {
        NavigationLink(
            destination: LazyLoad(
                SquadBuilder(squadId: squadViewModel.uuid!, isActive: $isPresented, refresh: $refresh)
                .accentColor(Color("color.\(armyViewModel.shortName!)"))),
            isActive: $isPresented) {
            Text("\(squadViewModel.name!)")
                .fixedSize(horizontal: true, vertical: false)

            Spacer(minLength: 5)

            Text("Configure Squad")
                .font(.caption)
                .foregroundColor(.gray)
                .fixedSize(horizontal: true, vertical: false)

        }
    }
}
