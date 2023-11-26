
import UIKit

final class AddStudentScreenVC: UIViewController {
    
    
         lazy var ui: AddStudentScreenView = {
            let ui = AddStudentScreenView()
            return ui
        }()
        
    var addStudentTapHandler: ((_ name: String) -> Void)? {
        didSet {
            self.ui.addStudent = self.addStudentTapHandler
        }
    }
    
        override func loadView() {
            super.loadView()
            
            self.ui.configur()
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.title = "Add Student"
            self.view = self.ui
            self.ui.configur()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                                    style: .plain,
                                                                    target: self,
                                                                    action: #selector(self.backScreenTap)
            )
            self.ui.backSkreen = { [weak self] in
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        @objc func backScreenTap(){
            self.navigationController?.popViewController(animated: true)
        }
    

    
    
    
}
