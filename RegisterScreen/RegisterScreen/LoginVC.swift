import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    
    var mail: [String] = []
    var user: [String] = []
    var password: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterButton.layer.borderWidth = 2
        self.enterButton.layer.borderColor = UIColor.red.cgColor
        self.enterButton.layer.cornerRadius = 10
        self.enterButton.clipsToBounds = true
        userText.center.x -= view.bounds.width
        passText.center.x -= view.bounds.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.userText.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1) {
            self.passText.center.x += self.view.bounds.width
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userText.center.x -= view.bounds.width
        passText.center.x -= view.bounds.width
    }
    
    @IBAction func enterButton(_ sender: Any) {
        if user.isEmpty {
            noticeLabel.text = "user or password is incorrect !"
        }
        for i in 0..<user.count {
            if (userText.text == user[i] && passText.text == password[i]) ||
                (userText.text == mail[i] && passText.text == password[i]) {
                noticeLabel.text = ""
                let cellIdentifier = "LoginSuccessVC"
                let vc = UIStoryboard(name: "Main", bundle: nil)
                let screen = vc.instantiateViewController(
                    withIdentifier: cellIdentifier) as! LoginSuccessVC
                screen.nameUser = user[i]
                navigationController?.pushViewController(screen, animated: true)
                break
            }else {
                noticeLabel.text = "user or password is incorrect !"
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let cellIdentifier = "RegisterVC"
        let vc = UIStoryboard(name: "Main", bundle: nil)
        let screen = vc.instantiateViewController(
            withIdentifier: cellIdentifier) as! RegisterVC
        screen.userAndPassDelegate = self
        navigationController?.pushViewController(screen, animated: true)
    }
    
}

extension LoginVC: UserAndPassDelegate {
    func returnUserAndPass(_ userName: String, _ email: String, _ pass: String) {
        user.append(userName)
        mail.append(email)
        password.append(pass)
    }
}
