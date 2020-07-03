//
//  JackList.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct JackList: View {
    var jacks: [Jack]
    @Binding var refresh: Bool
    
    var body: some View {
        ForEach(jacks, id:\.id) { jack in

            if jack.uuid != nil {
                JackCell(jack: jack, refresh: $refresh)
            }

            if let customJacks = (jack.customJacks as! Set<Jack>) {
                CustomJackList(customJacks: customJacks, refresh: $refresh)
            }
        }
    }
}
