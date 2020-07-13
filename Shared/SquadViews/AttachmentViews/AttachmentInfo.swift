//
//  AttachmentView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentInfo: View {
    var fetchRequest: FetchRequest<Attachment>
    var attachment: Attachment {
        fetchRequest.wrappedValue.first ?? Attachment()
    }

    init(attachmentId: String) {
        let predicate = NSPredicate(format: "id == %@", attachmentId)
        self.fetchRequest = FetchRequest(entity: Attachment.entity(), sortDescriptors: [], predicate: predicate)
    }
    
    var body: some View {
        VStack {
            Divider()

            HStack {
                Spacer()
                Text("\(attachment.title!)").font(.title).foregroundColor(.gray)
                Spacer()
            }

            UnitStats(unit: attachment)

            RulesView(rules: attachment.rulesArray)

            WeaponsView(weapons: attachment.weaponsArray)
        }
    }
}
