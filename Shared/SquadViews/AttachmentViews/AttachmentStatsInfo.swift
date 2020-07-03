//
//  AttachmentStatsView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct AttachmentStatsView: View {
    var squad: Attachment

    var body: some View {
        HStack {
            StatsView(spd: squad.spd, mat: squad.mat, rat: squad.mat, def: squad.def, arm: squad.arm)

            Divider()

            if squad.foc > 0 {
                VStack{
                    Text("FOC").font(.headline).foregroundColor(.gray)
                    Text("\(squad.foc)")
                }
            }

            VStack{
                Text("DMG").font(.headline).foregroundColor(.gray)
                Text("\(squad.dmg)")
            }
        }
    }
}
