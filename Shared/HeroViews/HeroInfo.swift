//
//  HeroInfo.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct HeroInfo: View {
    @ObservedObject var hero: Hero
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")

                    HStack {
                        Spacer()
                        Text("\(hero.title!)").font(.title).foregroundColor(.gray)
                        Spacer()
                    }

                    HeroStatsView(hero: hero)

                    if let rules = (hero.rules as! Set<Rule>) {
                        RulesView(rules: rules)
                    }

                    if let weapons = (hero.weapons as! Set<Weapon>) {
                        WeaponsView(weapons: weapons)
                    }
                    
                }
            }
            .navigationBarTitle(Text("\(hero.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: HeroInfoDoneButton(isPresented: $isPresented))
        }
    }
}

struct HeroStatsView: View {
    var hero: Hero

    var body: some View {
        HStack {
            StatsView(spd: hero.spd, mat: hero.mat, rat: hero.mat, def: hero.def, arm: hero.arm)

            Divider().frame(height: 40)

            if hero.foc > 0 {
                VStack{
                    Text("FOC").font(.headline).foregroundColor(.gray)
                    Text("\(hero.foc)")
                }
            }

            VStack{
                Text("DMG").font(.headline).foregroundColor(.gray)
                Text("\(hero.dmg)")
            }
        }
    }
}

struct HeroInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }

    }
}
