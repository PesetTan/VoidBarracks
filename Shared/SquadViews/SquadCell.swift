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
        if let army = squad.army {
            return NavigationLink(
                destination: LazyLoad(SquadBuilder(squadId: squad.uuid!, isActive: $isPresented, refresh: $refresh))
                    .accentColor(Color("color.\(army.shortName!)")),
                isActive: $isPresented) {
                Text("\(squad.name!)")
                    .fixedSize(horizontal: true, vertical: false)

                Spacer(minLength: 5)

                Text("Configure Squad")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: true, vertical: false)

            }
            .eraseToAnyView()
        } else {
            return Text("").eraseToAnyView()
        }
    }
}
