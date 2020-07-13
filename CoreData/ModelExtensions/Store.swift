//
//  Store.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension Store {

    public var viewModelsArray: [ArmyViewModel] {
        let viewModel = self.viewModels as? Set<ArmyViewModel> ?? []
        return viewModel.sorted{$0.fullName! < $1.fullName!}
    }

}
