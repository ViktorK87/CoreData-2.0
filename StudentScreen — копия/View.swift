


import SnapKit
import UIKit

final class CoreDataView: UIView {
    struct Metrix {
        static let cellDefaultHeight: CGFloat = 40
    }
    
    private lazy var tableViewDelegat: UITableViewDelegate = self
    private var tableViewDataSource: UITableViewDataSource
    
    public init(tableViewDataSource: UITableViewDataSource){
        self.tableViewDataSource = tableViewDataSource
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     lazy var tableView: UITableView = {
        let obj = UITableView()
        obj.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        obj.backgroundColor = .white
        obj.delegate = self
        obj.dataSource = self.tableViewDataSource
        obj.tableFooterView = UIView()
        return obj
    }()
    
   
    
    
}

extension CoreDataView {
    func configur(){
        self.backgroundColor = .white
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(30)
            pin.left.equalToSuperview().offset(10)
            pin.right.equalToSuperview().offset(-10)
            pin.bottom.equalToSuperview().offset(-30)
        }
    }
}

extension CoreDataView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrix.cellDefaultHeight
    }

}

