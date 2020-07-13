//
//  Barracks.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import SwiftUI

struct Barracks: View {

    var body: some View {
        NavigationView {
            BarrackArmies()
                .navigationTitle("Barracks")
        }

    }
}

struct BarrackArmies: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        List {
            if let user = users.first, let viewModels = user.viewModelsArray {
                if (viewModels.isEmpty) {
                    HStack {
                        Spacer()
                        Text("No Armies Found")
                        Spacer()
                    }
                } else {
                    ForEach(viewModels, id:\.self) { viewModel in
                        LazyLoad(BarracksCell(viewModel: viewModel))
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let vm = viewModels[index]
                            context.delete(vm)
                        }
//                        do {
//                            try context.save()
//                        } catch {
//                            print("error when saving")
//                        }

                    }
                }

            } else {
                VStack {
                    Spacer()
                    Text("No User Found")
                    Spacer()
                }
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct BarracksCell: View {
    @ObservedObject var viewModel: ArmyViewModel
    private let dateFormatter = DateFormatter()
    @State private var isActive: Bool = false

    var body: some View {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if viewModel.id == nil {
            return Text("").eraseToAnyView()
        }
        return NavigationLink(destination: ArmyBuilder(viewModelId: viewModel.id!, factionId: viewModel.factionId!, isActive: $isActive)
                                .accentColor(Color("color.\(viewModel.shortName!)")),
                       isActive: $isActive) {

            if viewModel.customName! == "" {
                HStack {
                    Image("logo.\(viewModel.shortName!)")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(10)

                    VStack(alignment: .leading) {
                        Text("\(viewModel.fullName!)")
                            .font(.title2)
                        Text("\(dateFormatter.string(from: viewModel.lastModified!))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                }
            } else {
                Label {
                    VStack(alignment: .leading) {
                        Text("\(viewModel.customName!)")
                            .font(.title2)
                        Text("\(dateFormatter.string(from: viewModel.lastModified!))")
                            .font(.caption)
                    }

                } icon: {
                    Image("logo.\(viewModel.shortName!)")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(30)
                }
            }
        }.eraseToAnyView()
        
    }
}
