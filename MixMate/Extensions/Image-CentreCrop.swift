//
//  Image-CentreCrop.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-07-13.
//

import SwiftUI

extension Image {
    func centreCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
