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

    var viewModel: ArmyViewModel?
    @Binding var isActive: Bool

    var body: some View {
        HStack {
            Spacer()

            Button {
                print("Save Clicked")
                if let user = users.first, let viewModel = viewModel {
                    if user.viewModelsArray.first(where: {$0.id == viewModel.id}) == nil {
                        user.addToViewModels(viewModel.copy())
                    }

                    context.refresh(user, mergeChanges: true)
                    try! context.save()

                    ClipboardController.copyToClipboard(viewModel)
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
