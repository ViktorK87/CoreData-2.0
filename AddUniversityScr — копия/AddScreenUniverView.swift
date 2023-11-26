


import SnapKit

final class AddScreenUniverView: UIView {
    
    lazy var inputName2: UITextField = {
        let obj = UITextField()
        obj.backgroundColor = .cyan
        obj.layer.cornerRadius = 8
        obj.clipsToBounds = true
        obj.placeholder = "Введите название"
        obj.textAlignment = .center
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.black.cgColor
        obj.text = nil
        return obj
    }()
    
    lazy var confirmButton2: UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .systemRed
        obj.layer.cornerRadius = 8
        obj.clipsToBounds = true
        obj.setTitle("Confirm", for: .normal)
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.black.cgColor
        obj.addTarget(self, action: #selector(touchBegan2), for: .touchDown)
        obj.addTarget(self, action: #selector(confirmDidTap2), for: .touchUpInside)
        return obj
    }()
    
  

    @objc func touchBegan2(){
       
        self.confirmButton2.backgroundColor = .systemGreen
    }
    
    var addUnivers: ((_ name: String) -> Void)?
    
    @objc func confirmDidTap2(){
        guard let name = self.inputName2.text else {return}
        self.addUnivers?(name)
        self.confirmButton2.backgroundColor = .systemRed
    }
    
    func configur(){
        self.backgroundColor = .white
        self.addSubview(self.inputName2)
        self.addSubview(self.confirmButton2)
        self.inputName2.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(100)
            pin.height.equalTo(40)
            pin.left.equalToSuperview().offset(10)
            pin.right.equalToSuperview().offset(-10)
        }
        self.confirmButton2.snp.makeConstraints { pin in
            pin.top.equalTo(self.inputName2.snp.bottom).offset(20)
            pin.height.equalTo(self.inputName2.snp.height)
            pin.left.equalToSuperview().offset(10)
            pin.width.equalTo(self.inputName2.snp.width)
        }
    }
}
