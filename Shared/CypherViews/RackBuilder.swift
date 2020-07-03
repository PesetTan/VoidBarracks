//
//  RackBuilder.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct RackBuilder: View {
    var rack: Rack
    @State private var isActive: Bool = false

    var body: some View {
        NavigationLink(destination: CypherList(rack: rack, isActive: $isActive)
                        .accentColor(Color("color.\(rack.army!.shortName!)")),
                       isActive: $isActive) {
            Text("Configure Your Rack")
        }
    }
}
