//
//  AttachmentList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentList: View {
    var attachments: [AttachmentViewModel]

    var body: some View {
        List {

            if attachments.isEmpty {
                Text("NONE")
            } else {
                ForEach(attachments, id:\.id) { attachment in
                    AttachmentCell(viewModel: attachment)
                }
            }

        }
    }
}
