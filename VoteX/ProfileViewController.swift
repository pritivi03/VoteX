//
//  ProfileViewController.swift
//  VoteX
//
//  Created by Abhinav Kolli on 2/16/19.
//  Copyright © 2019 Abhinav Kolli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameTextLabel: UILabel!
    @IBOutlet weak var emailTextLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var currentLocTextLabel: UILabel!
    var ref:DatabaseReference!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        profilePictureImageView.layer.cornerRadius = 20
        logOutButton.layer.cornerRadius = 25
        logOutButton.layer.borderColor = UIColor.black.cgColor
        let color = UIColor( red: CGFloat(74.0/255.0), green: CGFloat(231.0/255.0), blue: CGFloat(98.0/255.0), alpha: CGFloat(1.0) )
        logOutButton.tintColor = UIColor.white
        logOutButton.backgroundColor = UIColor.lightGray
        var email = Auth.auth().currentUser?.email
        emailTextLabel.text = email
        email = email?.replacingOccurrences(of: ".", with: "-")
        email = email?.replacingOccurrences(of: "@", with: "-")
        print(email)
        ref.child("users/" + email!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            self.fullNameLabel.text = value["fullName"] as! String
            self.usernameTextLabel.text = value["username"] as! String
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do { try Auth.auth().signOut()}
        catch { print(error) }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        nextViewController.selected = "Local"
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}
