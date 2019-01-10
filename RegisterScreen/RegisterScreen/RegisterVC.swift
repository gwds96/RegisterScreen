import UIKit

protocol UserAndPassDelegate: class {
    func returnUserAndPass(_ userName: String,_ email: String, _ pass: String)
}

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var retypeLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var retypeText: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    var testPassEmpty = false
    var testUserEmpty = false
    var testMailEmpty = false
    var testPassRepeatEmpty = false
    
    weak var userAndPassDelegate: UserAndPassDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterButton.layer.borderWidth = 2
        self.enterButton.layer.borderColor = UIColor.red.cgColor
        self.enterButton.layer.cornerRadius = 10
        self.enterButton.clipsToBounds = true
        passLabel.text = ""
        retypeLabel.text = ""
        nameText.center.x -= view.bounds.width
        mailText.center.x -= view.bounds.width
        passText.center.x -= view.bounds.width
        retypeText.center.x -= view.bounds.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.nameText.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1) {
            self.mailText.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 1) {
            self.passText.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1) {
            self.retypeText.center.x += self.view.bounds.width
        }
    }
    
    func checkPasswordValidation(_ password: String) -> Bool {
        if password.count <= 8 {
            return true
        }
        for i in password.utf8 {
            if (i >= 40 && i <= 57) || (i >= 65 && i <= 90) {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameText {
            let userName: String = nameText.text!
            if userName.isEmpty {
                userLabel.text = "please type user name!"
                testUserEmpty = false
            }else {
                userLabel.text = ""
                testUserEmpty = true
            }
        }
        
        if textField == mailText {
            let userName: String = mailText.text!
            if userName.contains("@") {
                mailLabel.text = ""
                testMailEmpty = true
            }else {
                mailLabel.text = "email is incorrect!"
                testMailEmpty = false
            }
        }
        
        if textField == passText {
            let password: String = passText.text!
            if checkPasswordValidation(password) {
                passLabel.text = "please type valid password!"
                testPassEmpty = false
            } else {
                passLabel.text = ""
                testPassEmpty = true
            }
        }
        
        if textField == retypeText {
            if retypeText.text != passText.text {
                retypeLabel.text = "please retype correct password!"
                testPassRepeatEmpty = false
            }else {
                retypeLabel.text = ""
            }
        }
    }
    
    @IBAction func enterButton(_ sender: Any) {
        if retypeText.text == passText.text {
            testPassRepeatEmpty = true
        }
        if testUserEmpty && testMailEmpty && testPassEmpty && testPassRepeatEmpty {
            userAndPassDelegate?.returnUserAndPass(
                nameText.text!, mailText.text!, passText.text!)
            navigationController?.popViewController(animated: true)
        }
    }
}
