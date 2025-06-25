import Foundation
import CoreData

extension IncomeSource {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeSource> {
        return NSFetchRequest<IncomeSource>(entityName: "IncomeSource")
    }

    @NSManaged public var payFrequency: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var amount: Double
}

extension IncomeSource : Identifiable {
}
