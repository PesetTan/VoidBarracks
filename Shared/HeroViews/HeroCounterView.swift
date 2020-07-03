//
//  HeroCounterView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct HeroCounterView: View {
    var count: Int16
    
    var body: some View {
        VStack {
            if count > 0 {
                Image(systemName: "hexagon.fill")
                    .font(Font.system(size: 15, weight: .light))
            } else {
                Image(systemName: "hexagon")
                    .font(Font.system(size: 15, weight: .light))
            }
        }
    }
}
