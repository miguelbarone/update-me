//
//  ContentView.swift
//  UpdateMe
//
//  Created by Miguel Barone on 19/12/24.
//

import SwiftUI
import CoreData

struct ListContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ListViewModel

    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ListViewModel(viewContext: viewContext))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        DetailsContentView(viewModel: viewModel, item: item)
                    } label: {
                        Text(item.todoAction ?? "Action not saved")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        viewModel.showAddItemAlert = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .alert("Write a ToDo action below", isPresented: $viewModel.showAddItemAlert) {
                        TextField("ToDo Action", text: $viewModel.todoAction)
                        Button("Ok", action: viewModel.addItem)
                    }
                }
            }
            .alert("Something went wrong", isPresented: $viewModel.showErrorAlert) {
                Button("Ok", action: {})
            }
            .navigationTitle("Update Me")
            .toolbarTitleDisplayMode(.inline)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteItems(offsets: offsets)
    }
}

#Preview {
    ListContentView(viewContext: PersistenceController.preview.container.viewContext)
}
