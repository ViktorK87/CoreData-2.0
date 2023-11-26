

import CoreData
import UIKit

final class UniversityScreenVC: UIViewController {
    
    init(coreDataManager: CoreDataManager){
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var connectionToUniver: ((_ univer: University) -> Void)?
    let coreDataManager: ICoreDataManager
    private var arrayCoreData = [University]()
    private lazy var ui: UniversityScreenView = {
        let ui = UniversityScreenView(tableViewDataSource: self)
        return ui
    }()
    
    override func loadView() {
        super.viewDidLoad()
        self.view = self.ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurBar()
        self.ui.configur()
        self.refreshArray()
        self.ui.didSelectUniver = { [weak self] index in
            guard let self = self else {return}
            let uuid = self.arrayCoreData[index].id
            self.navigationController?.pushViewController(StudentScreenAssembly.make(univerId: uuid), animated: true)
        }
    }
}

extension UniversityScreenVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversityCustomeCell.key) as? UniversityCustomeCell else {
            return UITableViewCell()
        }
        cell.fill(name: self.arrayCoreData[indexPath.row].name, number: "\(self.arrayCoreData[indexPath.row].id)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch (editingStyle) {
        case .delete:
            let removableObject = self.arrayCoreData.remove(at: indexPath.row)
            self.coreDataManager.deleteUniversity(number: removableObject.id)
            self.ui.tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
    
    func configurBar(){
        self.title = "University"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.addUniversityTap))
    }
    
    @objc func addUniversityTap(){
        self.navigationController?.pushViewController(AddScreenUniverAssembly.make(addUniversHandler: {[weak self] name in
            guard let self = self else { return}
            self.coreDataManager.createNewUniversity(with: name)
            self.refreshArray()
            self.navigationController?.popViewController(animated: true)
        }) , animated: true)
    }
}

private extension UniversityScreenVC {
    func refreshArray(){
        if case let .success(university) = self.coreDataManager.fetchAllUniversity() {
            self.arrayCoreData = university
            self.ui.tableView.reloadData()
        }
    }
}

