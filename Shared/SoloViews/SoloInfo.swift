//
//  SoloInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SoloInfo: View {
    @ObservedObject var solo: Solo
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(solo.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    SoloStatsView(solo: solo)

                    if let rules = (solo.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (solo.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }

                }
            }
            .navigationBarTitle(Text("\(solo.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: SoloInfoDoneButton(isPresented: $isPresented))
        }
    }
}

struct SoloStatsView: View {
    var solo: Solo

    var body: some View {
        HStack {
            StatsView(spd: solo.spd, mat: solo.mat, rat: solo.mat, def: solo.def, arm: solo.arm)

            Divider().frame(height: 40)

            if solo.foc > 0 {
                VStack{
                    Text("FOC").font(.headline).foregroundColor(.gray)
                    Text("\(solo.foc)")
                }
            }

            VStack{
                Text("DMG").font(.headline).foregroundColor(.gray)
                Text("\(solo.dmg)")
            }
        }
    }
}

struct SoloInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }

    }
}
