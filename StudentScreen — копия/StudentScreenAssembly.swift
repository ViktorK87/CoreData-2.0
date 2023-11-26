

import UIKit

final class StudentScreenAssembly
{
    static func make( univerId: UUID) -> UIViewController {
        let coreDataManager = CoreDataManager()
        let vc = StudentsScreenVC(coreData: coreDataManager, univerId: univerId)
        return vc
    }
}
