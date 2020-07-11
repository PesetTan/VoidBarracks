//
//  Squad.swift
//  iOS
//
//  Created by Peset Tan on 7/10/20.
//

import Foundation

extension Squad {

    public var attachmentsArray: [Attachment] {
        let attachments = self.attachments as? Set<Attachment> ?? []
        return attachments.sorted{$0.name! < $1.name!}
    }

    public var customSquadsArray: [Squad] {
        let squads = self.customSquads as? Set<Squad> ?? []
        return squads.sorted{$0.name! < $1.name!}
    }
}
