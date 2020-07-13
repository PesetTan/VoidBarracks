//
//  Army.swift
//  iOS
//
//  Created by Peset Tan on 7/10/20.
//

import Foundation

extension Army {

    public var herosArray: [Hero] {
        let heros = self.heros as? Set<Hero> ?? []
        return heros.sorted{$0.name! < $1.name!}
    }

    public var solosArray: [Solo] {
        let solos = self.solos as? Set<Solo> ?? []
        return solos.sorted{$0.name! < $1.name!}
    }

    public var jacksArray: [Jack] {
        let jacks = self.jacks as? Set<Jack> ?? []
        return jacks.sorted{$0.name! < $1.name!}
    }

    public var squadsArray: [Squad] {
        let squads = self.squads as? Set<Squad> ?? []
        return squads.sorted{$0.name! < $1.name!}
    }

    public var rackUnwrapped: Rack {
        return self.rack ?? Rack()
    }
}
