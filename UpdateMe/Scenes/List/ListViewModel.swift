//
//  ListViewModel.swift
//  UpdateMe
//
//  Created by Miguel Barone on 10/04/25.
//

import CoreData
import Foundation

final class ListViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var showAddItemAlert = false
    @Published var showErrorAlert = false
    @Published var todoAction = String()

    private var viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchItems()
    }

    func fetchItems() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            items = try viewContext.fetch(fetchRequest)
        } catch {
            showErrorAlert = true
        }
    }

    func addItem() {
        guard !todoAction.isEmpty else { return }

        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.todoAction = todoAction

        do {
            try viewContext.save()
            fetchItems()
            todoAction = String()
        } catch {
            showErrorAlert = true
        }
    }

    func deleteItems(offsets: IndexSet ) {
        offsets.map { items[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
            fetchItems()
        } catch {
            showErrorAlert = true
        }
    }

    func deleteItem(_ item: Item) {
        guard let itemToDelete = items.first(where: { $0 == item }) else { return }
        viewContext.delete(itemToDelete)

        do {
            try viewContext.save()
            fetchItems()
        } catch {
            showErrorAlert = true
        }
    }
}
