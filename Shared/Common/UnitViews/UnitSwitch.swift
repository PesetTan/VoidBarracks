//
//  UnitSwitch.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/5/20.
//

import SwiftUI

struct UnitSwitch: View {
    @ObservedObject var viewModel: UnitViewModel
    var maxCount: Int = 1

    var body: some View {
        HStack {
            ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                if index >= viewModel.count {
                    Image(systemName: "circle").foregroundColor(.gray).opacity(0.5)
                } else {
                    Image(systemName: "circle.fill").foregroundColor(.accentColor)
                }
            }
        }
        .onTapGesture {
            viewModel.count += 1
            if viewModel.count > maxCount {
                viewModel.count = 0
            }
        }
    }

}
