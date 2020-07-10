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
        if attachment.name != nil {
            return Button {
                isPresented.toggle()
            } label: {
                HStack {
                    Text("\(attachment.name!)")
                    Spacer()
                    UnitSwitch(unit: attachment)
                }
            }
            .sheet(isPresented: $isPresented) {
                UnitInfo(unit: attachment, isPresented: $isPresented)
            }
            .eraseToAnyView()
        } else {
            return Text("No Attachment").eraseToAnyView()
        }

    }
}
