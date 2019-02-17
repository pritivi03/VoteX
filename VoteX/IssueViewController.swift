//
//  IssueViewController.swift
//  VoteX
//
//  Created by Abhinav Kolli on 2/16/19.
//  Copyright © 2019 Abhinav Kolli. All rights reserved.
//

import UIKit
import Disk

class IssueViewController: UIViewController {
    
    var issue : Issue!

    @IBOutlet weak var issueName: UILabel!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var disagreeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        issueName.text = issue.title
        descriptionTextView.text = issue.description
        issueImageView.downloaded(from: issue.imageUrl)
    }
    @IBAction func backClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        nextViewController.selected = issue.scope
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func agreeClicked(_ sender: Any) {
        var a = ""
        let polArr = issue.yes.characters.split{$0 == ","}.map(String.init)
        print(polArr)
        for politician in polArr {
            a += politician + "\n"
        }
        agreeButton.setTitle(a, for: UIControl.State.normal)
        agreeButton.isEnabled = false
        //Look over politicians and see if needed to be added
        var retrievedPoliticians : [Politician]!
        do {
            retrievedPoliticians = try Disk.retrieve("politicians.json", from: .caches, as: [Politician].self)
        } catch {
            print(error)
        }
        var retrievedPledges : [Pledge]!
        do {
            retrievedPledges = try Disk.retrieve("pledges.json", from: .caches, as: [Pledge].self)
        } catch {
            print(error)
        }
        if (retrievedPoliticians == nil) {
            var list = [Politician]()
            //Dont have anything add them
            for politician in polArr {
                var newPolitician = Politician()
                newPolitician.name = politician
                newPolitician.pledges = 1
                newPolitician.scope = issue.scope
                list.append(newPolitician)
            }
            do {
                try Disk.save(list, to: .caches, as: "politicians.json")
            } catch {
                print(error)
            }
        } else {
            for politician in polArr {
                var found = false
                for i in 0...retrievedPoliticians.count - 1 {
                    if retrievedPoliticians[i].name == politician {
                        retrievedPoliticians[i].pledges = retrievedPoliticians[i].pledges + 1
                        found = true
                    }
                }
                if(!found) {
                    var newPolitician = Politician()
                    newPolitician.name = politician
                    newPolitician.pledges = 1
                    newPolitician.scope = issue.scope
                    retrievedPoliticians.append(newPolitician)
                }
            }
            do {
                try Disk.save(retrievedPoliticians, to: .caches, as: "politicians.json")
            } catch {
                print(error)
            }
        }
        if retrievedPledges == nil {
            var pledgeList = [Pledge]()
            var newPledge = Pledge()
            newPledge.choice = "yes"
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd.yyyy"
            let dateString = formatter.string(from: date)
            newPledge.date = dateString
            newPledge.title = issue.title
            newPledge.imageUrl = issue.imageUrl
            newPledge.scope = issue.scope
            newPledge.politicians = issue.no.replacingOccurrences(of: ",", with: ", ")

            pledgeList.append(newPledge)
            do {
                try Disk.save(pledgeList, to: .caches, as: "pledges.json")
            } catch {
                print(error)
            }
        } else {
            var newPledge = Pledge()
            newPledge.choice = "yes"
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd.yyyy"
            let dateString = formatter.string(from: date)
            newPledge.date = dateString
            newPledge.title = issue.title
            newPledge.imageUrl = issue.imageUrl
            newPledge.scope = issue.scope
            newPledge.politicians = issue.no.replacingOccurrences(of: ",", with: ", ")
            retrievedPledges.append(newPledge)
            do {
                try Disk.save(retrievedPledges, to: .caches, as: "pledges.json")
            } catch {
                print(error)
            }
        }
        
        printOutPledges()
        printOutPolticians()
        
    }
    
    
    @IBAction func disagreeClicked(_ sender: Any) {
        var a = ""
        let polArr = issue.no.characters.split{$0 == ","}.map(String.init)
        print(polArr)
        for politician in polArr {
            a += politician + "\n"
        }
        disagreeButton.setTitle(a, for: UIControl.State.normal)
        disagreeButton.isEnabled = false
        //Look over politicians and see if needed to be added
        var retrievedPoliticians : [Politician]!
        do {
            retrievedPoliticians = try Disk.retrieve("politicians.json", from: .caches, as: [Politician].self)
        } catch {
            print(error)
        }
        var retrievedPledges : [Pledge]!
        do {
            retrievedPledges = try Disk.retrieve("pledges.json", from: .caches, as: [Pledge].self)
        } catch {
            print(error)
        }
        if (retrievedPoliticians == nil) {
            var list = [Politician]()
            //Dont have anything add them
            for politician in polArr {
                var newPolitician = Politician()
                newPolitician.name = politician
                newPolitician.pledges = 1
                newPolitician.scope = issue.scope
                list.append(newPolitician)
            }
            do {
                try Disk.save(list, to: .caches, as: "politicians.json")
            } catch {
                print(error)
            }
        } else {
            for politician in polArr {
                var found = false
                for i in 0...retrievedPoliticians.count - 1 {
                    if retrievedPoliticians[i].name == politician {
                        retrievedPoliticians[i].pledges = retrievedPoliticians[i].pledges + 1
                        found = true
                    }
                }
                if(!found) {
                    var newPolitician = Politician()
                    newPolitician.name = politician
                    newPolitician.pledges = 1
                    newPolitician.scope = issue.scope
                    retrievedPoliticians.append(newPolitician)
                }
            }
            do {
                try Disk.save(retrievedPoliticians, to: .caches, as: "politicians.json")
            } catch {
                print(error)
            }
            
        }
        if retrievedPledges == nil {
            var pledgeList = [Pledge]()
            var newPledge = Pledge()
            newPledge.choice = "no"
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd.yyyy"
            let dateString = formatter.string(from: date)
            newPledge.date = dateString
            newPledge.title = issue.title
            newPledge.imageUrl = issue.imageUrl
            newPledge.scope = issue.scope
            newPledge.politicians = issue.no.replacingOccurrences(of: ",", with: ", ")
            pledgeList.append(newPledge)
            do {
                try Disk.save(pledgeList, to: .caches, as: "pledges.json")
            } catch {
                print(error)
            }
        } else {
            var newPledge = Pledge()
            newPledge.choice = "no"
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd.yyyy"
            let dateString = formatter.string(from: date)
            newPledge.date = dateString
            newPledge.title = issue.title
            newPledge.imageUrl = issue.imageUrl
            newPledge.scope = issue.scope
            newPledge.politicians = issue.no.replacingOccurrences(of: ",", with: ", ")
            retrievedPledges.append(newPledge)
            do {
                try Disk.save(retrievedPledges, to: .caches, as: "pledges.json")
            } catch {
                print(error)
            }
        }
        
        printOutPledges()
        printOutPolticians()
        
    }
    
    func printOutPolticians() {
        print("PRINTING OUT POLITICIANS")
        var what : [Politician]!
        do {
            what = try Disk.retrieve("politicians.json", from: .caches, as: [Politician].self)
        } catch {
            print(error)
        }
        print(what)
    }
    
    func printOutPledges() {
        print("PRINTING OUT PLEDGES")
        var what : [Pledge]!
        do {
            what = try Disk.retrieve("pledges.json", from: .caches, as: [Pledge].self)
        } catch {
            print(error)
        }
        print(what)
    }
    
}




struct Politician : Codable{
    var name : String!
    var pledges: Int!
    var scope: String!
}

struct Pledge : Codable {
    var title : String!
    var date: String!
    var choice : String!
    var imageUrl: String!
    var scope : String!
    var politicians : String!
}
