//
//  AttachmentCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentCell: View {
    @ObservedObject var attachment: Attachment
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text("\(attachment.name!)")
                Spacer()
                UnitCounter(unit: attachment, maxCount: 1)
            }
        }
        .sheet(isPresented: $isPresented) {
            UnitInfo(unit: attachment, isPresented: $isPresented)
        }
    }
}
