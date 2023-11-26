
import Foundation
import UIKit

final class AddScreenStudentAssembly
{
    static func make(addStudentHandler: @escaping ((_ name: String) -> Void)) -> UIViewController {
        let vc = AddStudentScreenVC()
        vc.addStudentTapHandler = addStudentHandler
        return vc
    }
}

