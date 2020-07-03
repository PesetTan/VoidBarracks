//
//  CounterView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct CounterView: View {
    public var count: Int16
    private let imageType: String = "circle"
    private let imageSize: CGFloat = 7
    private let paddingTrailing: CGFloat = 5
    private let paddingLeading: CGFloat = 5


    var body: some View {
        VStack(spacing:2) {
            if count > 2 {
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
            if count > 1 {
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
            if count > 0 {
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
