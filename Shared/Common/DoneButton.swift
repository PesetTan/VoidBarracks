//
//  DoneButton.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct DoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented = false
        } label: {
            Image(systemName: "multiply.circle")
                .font(.system(size: 25))
                .contentShape(Circle())
        }

    }

}
