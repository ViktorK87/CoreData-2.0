


import SnapKit
import UIKit
import CoreData

final class UniversityScreenView: UIView
{
    struct Metrix {
        static let cellDefaultHeight: CGFloat = 70
    }
    
    
    private lazy var tableViewDelegat: UITableViewDelegate = self
    private var tableViewDataSource: UITableViewDataSource
    var didSelectUniver: ((_ index: Int) -> Void)?
    
    public init(tableViewDataSource: UITableViewDataSource){
        self.tableViewDataSource = tableViewDataSource
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     lazy var tableView: UITableView = {
        let obj = UITableView()
        obj.register(UniversityCustomeCell.self, forCellReuseIdentifier: "UniversityCustomeCell")
        obj.backgroundColor = .white
        obj.delegate = self
        obj.dataSource = self.tableViewDataSource
        obj.tableFooterView = UIView()
        return obj
    }()
    
}

extension UniversityScreenView {
    func configur(){
        self.backgroundColor = .white
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(40)
            pin.left.equalToSuperview().offset(10)
            pin.right.equalToSuperview().offset(-10)
            pin.bottom.equalToSuperview().offset(-30)
        }
    }
}

extension UniversityScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrix.cellDefaultHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        self.didSelectUniver?(index)
    }
}



