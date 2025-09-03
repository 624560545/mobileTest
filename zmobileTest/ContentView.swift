//
//  ContentView.swift
//  zmobileTest
//
//  Created by 天天 on 2025/9/3.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(entity: Pair.entity(), sortDescriptors: [])
       var pairs: FetchedResults<Pair>
    

    var body: some View {
        NavigationView {
            List {
                ForEach(pairs, id: \.self) { pair in
                    NavigationLink {
                        Text("Item at \(pair.origin!.code!)→\(pair.destination!.code!)")
                    } label: {
                        HStack{
                            VStack{
                                //--
                                Text(pair.origin!.code!).font(.system(size: 16, weight: .bold))
                                Text(pair.origin!.displayName!).font(.system(size: 14, weight: .medium))
                                Text(pair.origin!.url!).font(.system(size: 12, weight: .regular))
                                
                            }
                            Text("→").font(.system(size: 16, weight: .bold))
                            VStack{
                                //--
                                Text(pair.destination!.code!).font(.system(size: 16, weight: .bold))
                                Text(pair.destination!.displayName!).font(.system(size: 14, weight: .medium))
                                Text(pair.destination!.url!).font(.system(size: 12, weight: .regular))
                                
                            }
                        }
                       
                    }
                    
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            //--
            let newOrigin = Address(context: viewContext)
            newOrigin.code = "AAA"
            newOrigin.displayName = "AAA DisplayName"
            newOrigin.url = "www.ship.com"
            
            let newDestination = Address(context: viewContext)
            newDestination.code = "BBB"
            newDestination.displayName = "BBB DisplayName"
            newDestination.url = "www.ship.com"
            
            
            let newPair = Pair(context: viewContext)
            newPair.originCity = "BBB"
            newPair.destinationCity = "AAA"
            newPair.origin = newOrigin
            newPair.destination = newDestination

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //offsets.map { items[$0] }.forEach(viewContext.delete)
            offsets.map { pairs[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
