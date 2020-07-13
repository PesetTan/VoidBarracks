//
//  HeroSection.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import SwiftUI

struct HeroSection: View {
    var viewModel: ArmyViewModel
    
    var body: some View {
        Section(header: heroHeader) {
            heroList
                .environmentObject(viewModel)
                .customCell()

            Spacer()
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }

    var heroList: some View {
        ForEach(viewModel.herosViewModelsArray, id:\.id) { hero in
            UnitCell(viewModel: hero)
        }
    }

    var heroHeader: some View {
        HStack{
            Image(systemName: "star")
            Text("Heros")
            Spacer()
            if viewModel.heroCount > viewModel.heroMax {
                if viewModel.heroCount - viewModel.heroMax == 1 {
                    Text("1 Hero Point Over")
                        .font(.caption)
                } else {
                    Text("\(viewModel.heroCount - viewModel.heroMax) Hero Points Over")
                        .font(.caption)
                }
            } else {
                Text("\(viewModel.heroCount)/\(viewModel.heroMax) Heros")
                    .font(.caption)
            }

        }
    }
}
