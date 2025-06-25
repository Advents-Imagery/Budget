import SwiftUI

@main
struct IncomeAppApp: App {
    @StateObject private var persistenceController = PersistenceController.shared
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                IncomeListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                LoginView()
            }
        }
    }
}
