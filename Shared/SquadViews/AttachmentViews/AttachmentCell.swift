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
                Toggle(isOn: Binding<Bool>(
                        get: { attachment.selected },
                        set: {
                            attachment.selected = $0
                        })) {
                    Text("\(attachment.name!)")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .sheet(isPresented: $isPresented) {
            AttachmentInfo(attachment: attachment, isPresented: $isPresented)
        }
    }
}
