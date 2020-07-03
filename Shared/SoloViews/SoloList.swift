//
//  SoloList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct SoloList: View {
    var solos: [Solo]

    var body: some View {
        ForEach(solos, id:\.id) { solo in
            UnitCell(unit: solo)
        }
    }
}
