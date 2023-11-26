

import UIKit

final class UniversityScrAssembly
{
    static func make() -> UIViewController {
        let coreDataManager = CoreDataManager()
        let vc = UniversityScreenVC(coreDataManager: coreDataManager)
        return vc
    }
}

