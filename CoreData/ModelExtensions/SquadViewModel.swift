//
//  UnitViewModel.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension SquadViewModel {
    public var attachmentsViewModelsArray: [AttachmentViewModel] {
        let viewModel = self.attachmentViewModels as? Set<AttachmentViewModel> ?? []
        return viewModel.sorted{$0.name! < $1.name!}
    }

    public var customSquadViewModelsArray: [SquadViewModel] {
        let viewModel = self.customSquadViewModels as? Set<SquadViewModel> ?? []
        return viewModel.sorted{$0.name! < $1.name!}
    }
}
