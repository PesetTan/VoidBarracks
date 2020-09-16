//
//  UnitCounter.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI
import CoreHaptics

struct UnitCounter: View {
    @ObservedObject var viewModel: UnitViewModel
    @EnvironmentObject var armyViewModel: ArmyViewModel
    var maxCount: Int = 4
//    @State private var engine: CHHapticEngine?

    var body: some View {
        return HStack {
            if let symbol = armyViewModel.symbol {
                ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                    if index >= viewModel.count {
                        Image("\(symbol)").foregroundColor(.gray).opacity(0.5)
                    } else {
                        Image("\(symbol).fill").foregroundColor(.accentColor)
                    }
                }
            } else {
                ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                    if index >= viewModel.count {
                        Image("circle").foregroundColor(.gray).opacity(0.5)
                    } else {
                        Image("circle.fill").foregroundColor(.accentColor)
                    }
                }
            }

        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.count += 1
            if viewModel.count > maxCount {
                viewModel.count = 0
            }

            if viewModel is HeroViewModel {
                var heroCount: Int16 = 0
                armyViewModel.herosViewModelsArray.forEach { hero in
                    heroCount += hero.count
                }
                armyViewModel.heroCount = heroCount
                return
            }

            var unitCount: Int16 = 0

            armyViewModel.solosViewModelsArray.forEach { solo in
                unitCount += solo.count
            }

            armyViewModel.jacksViewModelsArray.forEach { jack in
                jack.customJackViewModelsArray.forEach { custom in
                    unitCount += custom.count
                }
            }

            armyViewModel.squadsViewModelsArray.forEach { squad in
                squad.customSquadViewModelsArray.forEach { custom in
                    unitCount += custom.count
                }
            }
            armyViewModel.unitCount = unitCount

//            complexSuccess()
//            simpleSuccess()
        }
    }

    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
//
//    func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware()
//                .supportsHaptics else { return }
//
//        do {
//            self.engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("error")
//        }
//    }
//
//    func complexSuccess() {
//        var events: [CHHapticEvent] = []
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 3)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 3)
//        let event = CHHapticEvent(eventType: .hapticTransient , parameters: [intensity, sharpness], relativeTime: 0)
//
//        events.append(event)
//
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("error")
//        }
//    }
}
