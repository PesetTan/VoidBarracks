//
//  UnitCounter.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitCounter: View {
    public var unit: Unit
    private let imageType: String = "circle"
    private let imageSize: CGFloat = 7
    private let paddingTrailing: CGFloat = 5
    private let paddingLeading: CGFloat = 5


    var body: some View {
        VStack(spacing:2) {
            if let hero = unit as? Hero {
                if hero.count > 0 {
                    Image(systemName: "hexagon.fill")
                        .font(Font.system(size: 15, weight: .light))
                } else {
                    Image(systemName: "hexagon")
                        .font(Font.system(size: 15, weight: .light))
                }
                
            } else {
                if unit.count > 2 {
                    Image(systemName: "\(imageType).fill")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, paddingTrailing)
                        .padding(.leading, paddingLeading)
                } else {
                    Image(systemName: "\(imageType)")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, paddingTrailing)
                        .padding(.leading, paddingLeading)
                }
                if unit.count > 1 {
                    Image(systemName: "\(imageType).fill")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, paddingTrailing)
                        .padding(.leading, paddingLeading)
                } else {
                    Image(systemName: "\(imageType)")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, paddingTrailing)
                        .padding(.leading, paddingLeading)
                }
                if unit.count > 0 {
                    Image(systemName: "\(imageType).fill")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, paddingTrailing)
                        .padding(.leading, paddingLeading)
                } else {
                    Image(systemName: "\(imageType)")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, paddingTrailing)
                        .padding(.leading, paddingLeading)
                }
            }

        }

    }
}
