//
//  GamePicker.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import SwiftUI

struct GamePicker: View {
    @ObservedObject var viewModel: ArmyViewModel
    @State private var isActive: Bool = false

    var body: some View {
        NavigationLink(destination: picker, isActive: $isActive) {
            HStack {
                Text("Game Type")
                Spacer()
                if let gameType = viewModel.gameType {
                    Text("\(gameType)").font(.caption).foregroundColor(.gray)
                }

            }
        }
    }

    var picker: some View {
        Form {
            ForEach(["Normal Game", "Skirmish Game"], id:\.self) { type in
                Button {
                    viewModel.gameType = type
                    if type == "Skirmish Game" {
                        viewModel.heroMax = 0
                        viewModel.unitMax = 8
                        viewModel.herosViewModelsArray.forEach { hero in
                            hero.count = 0
                        }
                    } else {
                        viewModel.heroMax = 3
                        viewModel.unitMax = 15
                    }
                    isActive = false
                } label: {
                    Text(type)
                }
            }
        }

    }
}
