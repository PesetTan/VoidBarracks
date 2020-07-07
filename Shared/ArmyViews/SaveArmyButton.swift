//
//  SaveArmyButton.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import SwiftUI

struct SaveArmyButton: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var context

    var army: Army
    @Binding var isActive: Bool

    var body: some View {
        HStack {
            Spacer()

            Button {
                print("Save Clicked")
                if let user = users.first {
                    if (user.armies as! Set<Army>).first(where: {$0.id == army.id}) == nil {
                        user.addToArmies(army.copy())
                    }

                    context.refresh(user, mergeChanges: true)
                    try! context.save()

                    ClipboardController.copyToClipboard(army)
                    isActive.toggle()
                }
            } label: {
                Text("Recruit")
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }

            Spacer()
        }
    }
}
