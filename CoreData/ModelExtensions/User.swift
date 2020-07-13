//
//  User.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension User {

    public var viewModelsArray: [ArmyViewModel] {
        let viewModels = self.viewModels as? Set<ArmyViewModel> ?? []
        return viewModels.sorted{$0.lastModified! > $1.lastModified!}
    }

}
