//
//  SquadCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SquadCell: View {
    @ObservedObject var viewModel: UnitViewModel
    @State var isPresented: Bool = false
    @Binding var refresh: Bool

    var body: some View {
//        if let army = viewModel {
            return NavigationLink(
                destination: LazyLoad(SquadBuilder(squadId: viewModel.uuid!, isActive: $isPresented, refresh: $refresh)),
//                    .accentColor(Color("color.\(army.shortName!)")),
                isActive: $isPresented) {
                Text("\(viewModel.name!)")
                    .fixedSize(horizontal: true, vertical: false)

                Spacer(minLength: 5)

                Text("Configure Squad")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: true, vertical: false)

//            }
//            .eraseToAnyView()
//        } else {
//            return Text("").eraseToAnyView()
//        }
            }
    }
}
