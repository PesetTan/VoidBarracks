//
//  SoloList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SoloList: View {
    var viewModels: [SoloViewModel]

    var body: some View {
        ForEach(viewModels, id:\.id) { viewModel in
            UnitCell(viewModel: viewModel)
        }
    }
}
