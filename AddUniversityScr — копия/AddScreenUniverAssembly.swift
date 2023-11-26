
import Foundation
import UIKit

final class AddScreenUniverAssembly
{
    static func make(addUniversHandler: @escaping ((_ name: String) -> Void)) -> UIViewController {
        let vc = AddScreenUniverVC()
        vc.addUniverHanler = addUniversHandler
        return vc
    }
}
