//
//  RackBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct RackBuilder: View {
    @State private var isActive: Bool = false
    @EnvironmentObject var viewModel: ArmyViewModel

    var body: some View {
        if let shortName = viewModel.shortName {
            return NavigationLink(destination: LazyLoad(CypherList().environmentObject(viewModel.rackViewModel!))
                                    .accentColor(Color("color.\(shortName)")),
                                  isActive: $isActive) {
                Text("Configure Your Rack")
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }.eraseToAnyView()
        } else {
            return Text("").eraseToAnyView()
        }

    }
}
