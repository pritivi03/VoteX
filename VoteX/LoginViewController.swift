import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var ref: DatabaseReference!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loginButton.layer.cornerRadius = 25
        loginButton.layer.borderColor = UIColor.black.cgColor
        let color = UIColor( red: CGFloat(74.0/255.0), green: CGFloat(231.0/255.0), blue: CGFloat(98.0/255.0), alpha: CGFloat(1.0) )
        loginButton.tintColor = UIColor.white
        loginButton.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if (error == nil) {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                nextViewController.selected = "Local"
                self.present(nextViewController, animated:true, completion:nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Unfortunately, there was a problem with logging in. Please try again!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
