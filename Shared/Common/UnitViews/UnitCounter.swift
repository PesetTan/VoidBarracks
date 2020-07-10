//
//  UnitCounter.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI
import CoreHaptics

struct UnitCounter: View {
    @ObservedObject var unit: Unit
    @EnvironmentObject var army: Army
    var maxCount: Int = 3
//    @State private var engine: CHHapticEngine?

    var body: some View {
        return HStack {
            if let symbol = unit.symbol {
                ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                    if index >= unit.count {
                        Image("\(symbol)").foregroundColor(.gray).opacity(0.5)
                    } else {
                        Image("\(symbol).fill").foregroundColor(.accentColor)
                    }
                }
            } else {
                ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                    if index >= unit.count {
                        Image("circle").foregroundColor(.gray).opacity(0.5)
                    } else {
                        Image("circle.fill").foregroundColor(.accentColor)
                    }
                }
            }

        }
        .onTapGesture {
            unit.count += 1
            if unit.count > maxCount {
                unit.count = 0
            }

            if unit is Hero {
                var heroCount: Int16 = 0
                (army.heros as! Set<Hero>).forEach { hero in
                    heroCount += hero.count
                }
                army.heroCount = heroCount
                return
            }

            var unitCount: Int16 = 0

            (army.solos as! Set<Solo>).forEach { solo in
                unitCount += solo.count
            }

            (army.jacks as! Set<Jack>).forEach { jack in
                (jack.customJacks as! Set<Jack>).forEach { custom in
                    unitCount += custom.count
                }
            }

            (army.squads as! Set<Squad>).forEach { squad in
                (squad.customSquads as! Set<Squad>).forEach { custom in
                    unitCount += custom.count
                }
            }
            army.unitCount = unitCount

//            complexSuccess()
            simpleSuccess()
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
