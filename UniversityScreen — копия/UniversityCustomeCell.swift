
import Foundation
import UIKit

final class UniversityCustomeCell: UITableViewCell
{
    static var key: String {
        return "UniversityCustomeCell"
    }
    
    private let universityLabel: UILabel = {
       let obj = UILabel()
        obj.textAlignment = .center
        return obj
    }()
    
    private let UUIDLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        return obj
    }()
    
    func fill(name: String, number: String){
        self.makeLabelConstraints()
        self.universityLabel.text = name
        self.UUIDLabel.text = number
    }
}

private extension UniversityCustomeCell {
    func makeLabelConstraints(){
        self.contentView.addSubview(self.universityLabel)
        self.contentView.addSubview(self.UUIDLabel)
        self.universityLabel.snp.makeConstraints { pin in
            pin.top.equalToSuperview()
            pin.left.equalToSuperview()
            pin.height.equalToSuperview().dividedBy(2)
            pin.width.equalToSuperview()
        }
        self.UUIDLabel.snp.makeConstraints { pin in
            pin.left.equalToSuperview()
            pin.top.equalTo(self.universityLabel.snp.bottom)
            pin.right.equalToSuperview()
        }
    }
}

