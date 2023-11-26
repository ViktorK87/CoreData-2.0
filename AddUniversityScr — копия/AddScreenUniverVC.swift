

import Foundation
import UIKit

final class AddScreenUniverVC: UIViewController {
    
     lazy var ui: AddScreenUniverView = {
        let ui = AddScreenUniverView()
        return ui
    }()
    var addUniverHanler: ((_ name: String) -> Void)? {
        didSet {
            self.ui.addUnivers = self.addUniverHanler
        }
    }
    
    override func loadView() {
        super.loadView()
        self.ui.configur()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Univer"
        self.view = self.ui
        self.ui.configur()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(self.backScreenTap)
        )
    }
    
    @objc func backScreenTap(){
        self.navigationController?.popViewController(animated: true)
    }
}
