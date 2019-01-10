import UIKit

class LoginSuccessVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var nameUser: String?
    
    override func viewDidLoad() {
        nameLabel.text = "Hello \(nameUser ?? "")" 
    }
}
