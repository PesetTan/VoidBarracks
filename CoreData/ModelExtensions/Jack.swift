//
//  Jack.swift
//  iOS
//
//  Created by Peset Tan on 7/10/20.
//

import Foundation

extension Jack {

    public var customJacksArray: [Jack] {
        let jacks = self.customJacks as? Set<Jack> ?? []
        return jacks.sorted{$0.name! < $1.name!}
    }

    public var optionsForCortexArray: [Cortex] {
        let cortex = self.optionsForCortex as? Set<Cortex> ?? []
        return cortex.sorted{$0.name! < $1.name!}
    }

    public var optionsForArm1Array: [Weapon] {
        let weapons = self.optionsForArm1 as? Set<Weapon> ?? []
        return weapons.sorted{$0.name! < $1.name!}
    }

    public var optionsForArm2Array: [Weapon] {
        let weapons = self.optionsForArm2 as? Set<Weapon> ?? []
        return weapons.sorted{$0.name! < $1.name!}
    }

    public var optionsForShoulder1Array: [Weapon] {
        let weapons = self.optionsForShoulder1 as? Set<Weapon> ?? []
        return weapons.sorted{$0.name! < $1.name!}
    }

    public var optionsForShoulder2Array: [Weapon] {
        let weapons = self.optionsForShoulder2 as? Set<Weapon> ?? []
        return weapons.sorted{$0.name! < $1.name!}
    }
}
