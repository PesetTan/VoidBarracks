//
//  ArmyViewModel.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension ArmyViewModel {
    public var herosViewModelsArray: [HeroViewModel] {
        let viewModels = self.herosViewModels as? Set<HeroViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var solosViewModelsArray: [SoloViewModel] {
        let viewModels = self.solosViewModels as? Set<SoloViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var jacksViewModelsArray: [JackViewModel] {
        let viewModels = self.jacksViewModels as? Set<JackViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var squadsViewModelsArray: [SquadViewModel] {
        let viewModels = self.squadsViewModels as? Set<SquadViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }
}
