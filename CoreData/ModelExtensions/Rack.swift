//
//  Cypher.swift
//  iOS
//
//  Created by Peset Tan on 7/11/20.
//

import Foundation

extension Rack {

    public var furiesArray: [Cypher] {
        let cypher = self.furies as? Set<Cypher> ?? []
        return cypher.sorted{$0.name! < $1.name!}
    }

    public var geometricsArray: [Cypher] {
        let cypher = self.geometrics as? Set<Cypher> ?? []
        return cypher.sorted{$0.name! < $1.name!}
    }

    public var harmonicsArray: [Cypher] {
        let cypher = self.harmonics as? Set<Cypher> ?? []
        return cypher.sorted{$0.name! < $1.name!}
    }

    public var overdrivesArray: [Cypher] {
        let cypher = self.overdrives as? Set<Cypher> ?? []
        return cypher.sorted{$0.name! < $1.name!}
    }

}
