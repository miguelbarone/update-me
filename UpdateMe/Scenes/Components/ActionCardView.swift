//
//  ActionCardView.swift
//  UpdateMe
//
//  Created by Miguel Barone on 10/04/25.
//

import SwiftUI

struct ActionCardView: View {
    let image: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Image(systemName: image)
            }
            .frame(width: 40, height: 40)
            .background(Color(uiColor: .systemGray5))
            .cornerRadius(8)
            .padding(.leading)

            Text(description)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .bottom], 24)

            Image(systemName: "chevron.right")
                .padding(.trailing)
        }
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(8)
    }
}

struct ActionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActionCardView(image: "camera", description: "Take a picture and ")
    }
}
