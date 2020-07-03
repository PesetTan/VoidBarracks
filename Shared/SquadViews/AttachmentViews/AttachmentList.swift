//
//  AttachmentList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentList: View {
    var attachments: Set<Attachment>

    var body: some View {
        List {
            if let sortedAttachments = attachments.sorted{$0.id! < $1.id!} {
                if sortedAttachments.isEmpty {
                    Text("NONE")
                } else {
                    ForEach(sortedAttachments, id:\.id) { attachment in
                        AttachmentCell(attachment: attachment)
                    }
                }
            }
        }
    }
}
