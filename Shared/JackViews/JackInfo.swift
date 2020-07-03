//
//  JackInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct JackInfo: View {
    @ObservedObject var jack: Jack
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(jack.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    JackStatsView(jack: jack)

                    if let rules = (jack.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (jack.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }

                }
            }
            .navigationBarTitle(Text("\(jack.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: JackInfoDoneButton(jack: jack, isPresented: $isPresented))
        }
    }
}

struct JackStatsView: View {
    var jack: Jack

    var body: some View {
        HStack {
            VStack{
                Text("STR").font(.headline).foregroundColor(.gray)
                Text("\(jack.str)")
            }

            Divider().frame(height: 40)

            StatsView(spd: jack.spd, mat: jack.mat, rat: jack.mat, def: jack.def, arm: jack.arm)

            Divider().frame(height: 40)

            if jack.foc > 0 {
                VStack{
                    Text("FOC").font(.headline).foregroundColor(.gray)
                    Text("\(jack.foc)")
                }
            }

            VStack{
                Text("DMG").font(.headline).foregroundColor(.gray)
                Text("\(jack.dmg)")
            }
        }
    }
}

struct JackInfoDoneButton: View {
    var jack: Jack
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }
    }
}
