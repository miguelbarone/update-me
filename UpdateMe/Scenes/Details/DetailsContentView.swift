//
//  DetailsContentView.swift
//  UpdateMe
//
//  Created by Miguel Barone on 10/04/25.
//

import SwiftUI

struct DetailsContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: ListViewModel
    let item: Item

    init(viewModel: ListViewModel, item: Item) {
        self.viewModel = viewModel
        self.item = item
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("See more about the selected item")
                .font(.title2)
                .bold()

            Text("\(item.todoAction ?? "Action not saved")\nSaved at \(item.timestamp ?? Date(), formatter: itemFormatter)")
                .font(.subheadline)

            Spacer()

            VStack(spacing: 16) {
                ActionCardView(image: "camera", description: "Take a picture and save timestamp")
                ActionCardView(image: "dog", description: "Dog, just a dog")
                ActionCardView(image: "xmark", description: "Delete timestamp")
                    .onTapGesture {
                        viewModel.deleteItem(item)
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .navigationTitle("Details")
        .padding()
    }
}

struct DetailsContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        DetailsContentView(
            viewModel: ListViewModel(viewContext: context),
            item: .init(context: context)
        )
    }
}
