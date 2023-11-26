
import Foundation
import UIKit

final class CustomCell: UITableViewCell
{
    static var key: String {
        return "CustomCell"
    }
    
    private let univerLabel: UILabel = {
       let obj = UILabel()
        obj.textAlignment = .center
        return obj
    }()
    
    private let uuidLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        return obj
    }()
    
    func fill(name: String, number: String){
        self.makeLabelConstraints()
        self.univerLabel.text = name
        self.uuidLabel.text = number
    }
}

private extension CustomCell {
    func makeLabelConstraints(){
        self.contentView.addSubview(self.univerLabel)
        self.contentView.addSubview(self.uuidLabel)
        self.univerLabel.snp.makeConstraints { pin in
            pin.top.equalToSuperview()
            pin.height.equalToSuperview().dividedBy(2)
            pin.left.equalToSuperview()
            pin.width.equalToSuperview()
            self.uuidLabel.snp.makeConstraints { pin in
                pin.top.equalTo(self.univerLabel.snp.bottom)
                pin.left.equalToSuperview()
                pin.height.equalTo(self.univerLabel.snp.height)
                pin.width.equalTo(self.univerLabel.snp.width)
            }
        }
    }
}
