



import SnapKit

final class AddStudentScreenView: UIView {
    
    lazy var inputName: UITextField = {
        let obj = UITextField()
        obj.backgroundColor = .cyan
        obj.layer.cornerRadius = 8
        obj.clipsToBounds = true
        obj.placeholder = "Введите имя"
        obj.textAlignment = .center
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.black.cgColor
        obj.text = nil
        return obj
    }()
    
   
    lazy var confirmButton: UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .systemRed
        obj.layer.cornerRadius = 8
        obj.clipsToBounds = true
        obj.setTitle("Confirm", for: .normal)
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.black.cgColor
        obj.addTarget(self, action: #selector(touchBegan), for: .touchDown)
        obj.addTarget(self, action: #selector(confirmDidTap), for: .touchUpInside)
        return obj
    }()
    
    @objc func touchBegan(){
       
        self.confirmButton.backgroundColor = .systemGreen
        print("Touch Began")
    }
    
    var addStudent: ((_ name: String) -> Void)?
    var backSkreen: (() -> Void)?
    
    @objc func confirmDidTap(){
        guard let name = self.inputName.text else {return}
        self.addStudent?(name)
        self.confirmButton.backgroundColor = .systemRed
        self.backSkreen?()
    }
    
  
    func configur(){
        self.backgroundColor = .white
        self.addSubview(self.inputName)
        self.addSubview(self.confirmButton)
        self.inputName.snp.makeConstraints { pin in
            pin.top.equalToSuperview().offset(100)
            pin.right.equalToSuperview().offset(-10)
            pin.left.equalToSuperview().offset(10)
            pin.height.equalTo(40)
        }
        self.confirmButton.snp.makeConstraints { pin in
            pin.top.equalTo(self.inputName.snp.bottom).offset(20)
            pin.height.equalTo(self.inputName.snp.height)
            pin.left.equalToSuperview().offset(10)
            pin.width.equalTo(self.inputName.snp.width)
        }
    }
}
