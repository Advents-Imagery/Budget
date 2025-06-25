import SwiftUI
import CoreData

struct AddIncomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @State private var sourceName: String = ""
    @State private var amount: String = ""
    @State private var payFrequency: String = "Weekly"

    private let frequencies = ["Weekly", "Biweekly", "Monthly"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Source Name", text: $sourceName)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Pay Frequency", selection: $payFrequency) {
                    ForEach(frequencies, id: \.self) { freq in
                        Text(freq)
                    }
                }
            }
            .navigationTitle("Add Income")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addItem()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func addItem() {
        guard let value = Double(amount) else { return }
        let newItem = IncomeSource(context: viewContext)
        newItem.sourceName = sourceName
        newItem.payFrequency = payFrequency
        newItem.amount = value
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AddIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        AddIncomeView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
