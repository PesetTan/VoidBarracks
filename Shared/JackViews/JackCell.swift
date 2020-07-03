//
//  JackCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct JackCell: View {
    @ObservedObject var jack: Jack
    @State private var isPresented: Bool = false
    @Binding var refresh: Bool
    
    var body: some View {

            NavigationLink(
                destination: JackBuilder(jackId: jack.uuid!, isActive: $isPresented, refresh: $refresh),
                isActive: $isPresented) {
                Text("\(jack.name!)")
                    .fixedSize(horizontal: true, vertical: false)

                Spacer(minLength: 5)

                Text("Configure \(jack.title!)").foregroundColor(.gray)
                    .fixedSize(horizontal: true, vertical: false)

            }

    }
}
