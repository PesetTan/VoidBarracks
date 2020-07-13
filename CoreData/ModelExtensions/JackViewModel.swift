//
//  JackViewModel.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension JackViewModel {
    public var cortexOptionsArray: [CortexViewModel] {
        let viewModels = self.cortexOptions as? Set<CortexViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var arm1OptionsArray: [WeaponViewModel] {
        let viewModels = self.arm1Options as? Set<WeaponViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var arm2OptionsArray: [WeaponViewModel] {
        let viewModels = self.arm2Options as? Set<WeaponViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var shoulder1OptionsArray: [WeaponViewModel] {
        let viewModels = self.shoulder1Options as? Set<WeaponViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var shoulder2OptionsArray: [WeaponViewModel] {
        let viewModels = self.shoulder2Options as? Set<WeaponViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }

    public var customJackViewModelsArray: [JackViewModel] {
        let viewModels = self.customJackViewModels as? Set<JackViewModel> ?? []
        return viewModels.sorted{$0.name! < $1.name!}
    }
}
