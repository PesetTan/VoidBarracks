//
//  RackViewModel.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension CypherViewModel {
    public var furiesArray: [CypherViewModel] {
        let cyphers = self.furies as? Set<CypherViewModel> ?? []
        return cyphers.sorted{$0.name! < $1.name!}
    }

    public var geometricsArray: [CypherViewModel] {
        let cyphers = self.geometrics as? Set<CypherViewModel> ?? []
        return cyphers.sorted{$0.name! < $1.name!}
    }

    public var harmonicsArray: [CypherViewModel] {
        let cyphers = self.harmonics as? Set<CypherViewModel> ?? []
        return cyphers.sorted{$0.name! < $1.name!}
    }

    public var overdrivesArray: [CypherViewModel] {
        let cyphers = self.overdrives as? Set<CypherViewModel> ?? []
        return cyphers.sorted{$0.name! < $1.name!}
    }
}
