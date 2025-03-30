//
//  ErrorView.swift
//  SallaTask
//
//  Created by ahmed elshobary on 07/09/2024.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            Text("Error")
                .font(.headline)
                .padding(.top, 4)
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .padding()
    }
}
