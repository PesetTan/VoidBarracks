//
//  RackBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct RackBuilder: View {
    @State private var isActive: Bool = false
    @EnvironmentObject var army: Army

    var body: some View {
        if let shortName = army.shortName {
            return NavigationLink(destination: LazyLoad(CypherList().environmentObject(army))
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
