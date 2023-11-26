

//Написать приложение, в котором есть список компаний. Для каждой компании есть список сотрудников. Сотрудники не могут повторяться для разных компаний. Компании и сотрудники можно добавлять и удалять
//На основе CoreData или SQLite
//
import CoreData
import UIKit

class StudentsScreenVC: UIViewController
{
    init(coreData: CoreDataManager, univerId: UUID){
        self.coreDataManager = coreData
        self.univerId = univerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let univerId: UUID
    private let coreDataManager: ICoreDataManager
    private var arrayCoreData = [Student2]()
    private lazy var ui: CoreDataView = {
        let ui = CoreDataView(tableViewDataSource: self)
        return ui
    }()
    
    override func loadView(){
        super.viewDidLoad()
        self.view = self.ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurBar()
        self.ui.configur()
        self.refreshArray()
    }
}

extension StudentsScreenVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.key) as? CustomCell else {return UITableViewCell()}
        cell.fill(name: self.arrayCoreData[indexPath.row].name, number: "\(self.arrayCoreData[indexPath.row].id)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch (editingStyle) {
        case .delete:
            let removableObject = self.arrayCoreData.remove(at: indexPath.row)
            self.coreDataManager.deleteStudent(number: removableObject.id)
            self.ui.tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
    
    func configurBar(){
        self.title = "Students"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.addStudentTap))
    }
    
    @objc func addStudentTap(){
        self.navigationController?.pushViewController(AddScreenStudentAssembly.make(addStudentHandler: { [weak self] name in
            guard let self = self else {return}
            if case let .success(univer) = self.coreDataManager.fetchUniversity(id: self.univerId) {
                self.coreDataManager.createNewStudent(with: name, university: univer)
            }
            self.refreshArray()
            self.ui.tableView.reloadData()
        }), animated: true)
    }
}

private extension StudentsScreenVC {
    func refreshArray(){
        self.arrayCoreData.removeAll()
        if case let .success(univer) = self.coreDataManager.fetchUniversity(id: self.univerId) {
            univer.students?.forEach({ student in
                guard let stud = (student as? Student2) else {return}
                self.arrayCoreData.append(stud)
            })
        }
        self.ui.tableView.reloadData()
    }
}

