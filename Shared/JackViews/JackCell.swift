//
//  JackCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct JackCell: View {
    @ObservedObject var viewModel: JackViewModel
    @State private var isPresented: Bool = false
    @Binding var refresh: Bool
    @EnvironmentObject var armyViewModel: ArmyViewModel

    var body: some View {
        NavigationLink(
            destination: LazyLoad(JackBuilder(jackId: viewModel.uuid!, isActive: $isPresented, refresh: $refresh)
                .environmentObject(armyViewModel)
                .accentColor(Color("color.\(armyViewModel.shortName!)")))

            ,
            isActive: $isPresented) {
            Text("\(viewModel.name!)")
                .fixedSize(horizontal: true, vertical: false)

            Spacer(minLength: 5)

            Text("Configure \(self.viewModel.title!)")
                .font(.caption)
                .foregroundColor(.gray)
                .fixedSize(horizontal: true, vertical: false)

        }
    }
}
