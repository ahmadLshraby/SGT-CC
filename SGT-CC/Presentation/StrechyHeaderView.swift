//
//  StrechyHeaderView.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/20/24.
//

import SwiftUI

struct StrechyHeaderView: View {
    let imagePath: String?
    var initialHeaderHeight: CGFloat = UIScreen.main.bounds.height * 0.35
    
    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let width = geometry.size.width
            let height = initialHeaderHeight + (minY > 0 ? minY : 0)
            
            if let imagePath = imagePath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .clipped()
                        .offset(y: minY > 0 ? -minY : 0)
                } placeholder: {
                    ProgressView()
                        .frame(width: width, height: height)
                }
            } else {
                ProgressView()
                    .frame(width: width, height: height)
            }
        }
        .frame(height: initialHeaderHeight)
    }
}

#Preview {
    StrechyHeaderView(imagePath: "")
}
