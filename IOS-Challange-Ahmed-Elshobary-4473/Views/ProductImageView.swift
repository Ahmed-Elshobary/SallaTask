//
//  ProductImageView.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation
import SwiftUI

struct ProductImageView: View {
    let imageUrl: String
    let alt: String?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }

            // Badge using alt text (optional)
            if let altText = alt {
                Text(altText)
                    .padding(6)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(10)
            }
        }
    }
}
