//
//  ProductCell.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import Foundation
import SwiftUI

struct ProductCell: View {
    let product: ProductModel
    @ObservedObject var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let imageUrl = product.image?.url, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 120)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
            }

            Text(product.name)
                .font(.custom(themeManager.fontFamily, size: 16))
                .foregroundColor(.black)
                .lineLimit(2)
                .padding(.horizontal, 4)

            Text("SAR \(product.price, specifier: "%.2f")")
                .font(.custom(themeManager.fontFamily, size: 14))
                .foregroundColor(.black)
                .padding(.horizontal, 4)

            Button(action: {
                // Add to cart logic
            }) {
                Text("أضف للسلة")
                    .font(.custom(themeManager.fontFamily, size: 14))
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 4)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
        .padding(.bottom, 16)
    }
}
