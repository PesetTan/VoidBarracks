//
//  GamePicker.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import SwiftUI

struct GamePicker: View {
    @ObservedObject var army: Army
    @State private var isActive: Bool = false

    var body: some View {
        NavigationLink(destination: picker, isActive: $isActive) {
            HStack {
                Text("Game Type")
                Spacer()
                if let gameType = army.gameType {
                    Text("\(gameType)").font(.caption).foregroundColor(.gray)
                }

            }
        }
    }

    var picker: some View {
        Form {
            ForEach(["Normal Game", "Skirmish Game"], id:\.self) { type in
                Button {
                    army.gameType = type
                    if type == "Skirmish Game" {
                        army.heroMax = 0
                        army.unitMax = 8
                        (army.heros as! Set<Hero>).forEach { hero in
                            hero.count = 0
                        }
                    } else {
                        army.heroMax = 3
                        army.unitMax = 15
                    }
                    isActive = false
                } label: {
                    Text(type)
                }
            }
        }

    }
}
