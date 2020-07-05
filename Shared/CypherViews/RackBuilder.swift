//
//  RackBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct RackBuilder: View {
    @ObservedObject var rack: Rack
    @State private var isActive: Bool = false

    var body: some View {
        if let army = rack.army {
            return NavigationLink(destination: CypherList(rack: rack)
                            .accentColor(Color("color.\(army.shortName!)")),
                           isActive: $isActive) {
                Text("Configure Your Rack")
            }
            .eraseToAnyView()
        } else {
            return Text("")
                .eraseToAnyView()
        }

    }
}
