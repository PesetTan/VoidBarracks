//
//  SquadInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SquadInfo: View {
    @ObservedObject var squad: Squad
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(squad.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    SquadStatsView(squad: squad)

                    if let rules = (squad.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (squad.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }

                }
            }
            .navigationBarTitle(Text("\(squad.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: SquadInfoDoneButton(isPresented: $isPresented))
        }
    }
}

struct SquadStatsView: View {
    var squad: Squad

    var body: some View {
        HStack {
            StatsView(spd: squad.spd, mat: squad.mat, rat: squad.mat, def: squad.def, arm: squad.arm)

            Divider()

            if squad.foc > 0 {
                VStack{
                    Text("FOC").font(.headline).foregroundColor(.gray)
                    Text("\(squad.foc)")
                }
            }

            VStack{
                Text("DMG").font(.headline).foregroundColor(.gray)
                Text("\(squad.dmg)")
            }
        }
    }
}

struct SquadInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }

    }
}
