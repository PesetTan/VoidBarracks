//
//  SquadCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SquadCell: View {
    @ObservedObject var squad: Squad
    @State var isPresented: Bool = false
    @Binding var refresh: Bool

    var body: some View {
        NavigationLink(
            destination: SquadBuilder(squadId: squad.uuid!, isActive: $isPresented, refresh: $refresh),
            isActive: $isPresented) {
            Text("\(squad.name!)")
                .fixedSize(horizontal: true, vertical: false)

            Spacer(minLength: 5)

            Text("Configure Squad").foregroundColor(.gray)
                .fixedSize(horizontal: true, vertical: false)

        }
    }
}
