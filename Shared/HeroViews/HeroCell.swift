//
//  HeroCell.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct HeroCell: View {
    @ObservedObject var hero: Hero
    @State var isPresented: Bool = false

    var body: some View {

        Button {
            isPresented.toggle()
        } label: {
            HStack {
                HeroCounterView(count: hero.count)
                Stepper {
                    hero.count += 1
                } onDecrement: {
                    hero.count -= 1
                } label: {
                    Text("\(hero.name!)")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            HeroInfo(hero: hero, isPresented: $isPresented)
        }
    }
}

