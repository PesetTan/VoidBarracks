//
//  HeroList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct HeroList: View {
    var heros: [Hero]

    var body: some View {
        ForEach(heros, id:\.id) { hero in
            UnitCell(unit: hero)
        }
    }
}
