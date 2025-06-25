import SwiftUI
import CoreData

struct IncomeListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \IncomeSource.sourceName, ascending: true)],
        animation: .default)
    private var items: FetchedResults<IncomeSource>

    @State private var showingAddIncome = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.sourceName ?? "").font(.headline)
                            Text(item.payFrequency ?? "").font(.subheadline)
                        }
                        Spacer()
                        Text(String(format: "$%.2f", item.amount))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Income Sources")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddIncome.toggle() }) {
                        Label("Add", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddIncome) {
                AddIncomeView()
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct IncomeListView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeListView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
