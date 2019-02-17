import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var selected : String!
    
    var nationalArr = [Issue]()
    var stateArr = [Issue]()
    var localArr = [Issue]()
    var ref: DatabaseReference!
    var refresher : UIRefreshControl!
    
    @IBOutlet weak var localButton: UIButton!
    var defaults = UserDefaults.standard

    @IBOutlet weak var nationalButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        collectionView.dataSource = self
        collectionView.delegate = self
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refresher.addTarget(self, action: #selector(HomeViewController.populate), for: .valueChanged)
        collectionView.addSubview(refresher)
        if selected == "Local" {
            localButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "State" {
            stateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "National" {
            nationalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        }
        getIssues()
        print("called")
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            self.collectionView.reloadData()
        })
    }
    
    @objc func populate () {
        getIssues()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            self.collectionView.reloadData()
        })
        refresher.endRefreshing()
    }

    @IBAction func nationalButtonClicked(_ sender: Any) {
        selected = "National"
        self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                          at: .top,
                                          animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! TopCollectionViewCell
            cell.scope = self.selected
            cell.refresh()
            self.collectionView.reloadData()
        })
        
        if selected == "Local" {
            localButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "State" {
            stateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "National" {
            nationalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        }
    }
    
    @IBAction func stateButtonClicked(_ sender: Any) {
        selected = "State"
        self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                          at: .top,
                                          animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! TopCollectionViewCell
            cell.scope = self.selected
            cell.refresh()
            self.collectionView.reloadData()
        })
        
        if selected == "Local" {
            localButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "State" {
            stateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "National" {
            nationalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        }
    }
    @IBAction func localButtonClicked(_ sender: Any) {
        selected = "Local"
        self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                          at: .top,
                                          animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! TopCollectionViewCell
            cell.scope = self.selected
            cell.refresh()
            self.collectionView.reloadData()
        })
        
        if selected == "Local" {
            localButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "State" {
            stateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            nationalButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        } else if selected == "National" {
            nationalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            localButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        }
    }
    
    func getIssues () {
        nationalArr.removeAll()
        stateArr.removeAll()
        localArr.removeAll()
        nationalArr.removeAll()
        ref.child("issues").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = (snapshot.value as? NSDictionary)!
            for i in value {
                let name = i.key
                let object = i.value as! NSDictionary
                var issue = Issue()
                issue.title = name as? String
                issue.description = object["description"] as? String
                issue.imageUrl = (object["imageUrl"] as? String)
                issue.no = object["no"] as? String
                issue.scope = object["scope"] as? String
                issue.yes = object["yes"] as? String
                issue.totalPledges = object["totalPledges"] as? Int
                if (object["scope"] as! String == "Local") {
                    self.localArr.append(issue)
                    print(self.localArr)
                } else if (object["scope"] as! String == "State") {
                    self.stateArr.append(issue)
                    print(self.stateArr)
                } else if (object["scope"] as! String == "National") {
                    self.nationalArr.append(issue)
                    print(self.nationalArr)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var issue: Issue!
        if selected == "Local" {
            issue = localArr[indexPath.row - 1]
        } else if selected == "State" {
            issue = stateArr[indexPath.row - 1]
        } else if selected == "National" {
            issue = nationalArr[indexPath.row - 1]
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IssueViewController") as! IssueViewController
        nextViewController.issue = issue
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selected == "Local" {
            return localArr.count + 1
        } else if selected == "State" {
            return stateArr.count + 1
        } else if selected == "National" {
            return nationalArr.count + 1
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if selected == "Local" {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopCollectionViewCell
                print("sending scope")
                cell.scope = selected
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "issueCell", for: indexPath) as! IssueCollectionViewCell
                
                cell.titleLabel.text = localArr[indexPath.row - 1].title
                cell.totalPledgesLabel.text = "Total Pledges: " + String(localArr[indexPath.row - 1].totalPledges)
                cell.imageView.downloaded(from: localArr[indexPath.row - 1].imageUrl)
                return cell
            }
        } else if selected == "State" {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopCollectionViewCell
                cell.scope = selected
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "issueCell", for: indexPath) as! IssueCollectionViewCell
                
                cell.titleLabel.text = stateArr[indexPath.row - 1].title
                cell.totalPledgesLabel.text = "Total Pledges: " + String(stateArr[indexPath.row - 1].totalPledges)
                cell.imageView.downloaded(from: stateArr[indexPath.row - 1].imageUrl)
                return cell
            }
        } else if selected == "National" {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopCollectionViewCell
                cell.scope = selected
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "issueCell", for: indexPath) as! IssueCollectionViewCell
                
                cell.titleLabel.text = nationalArr[indexPath.row - 1].title
                cell.totalPledgesLabel.text = "Total Pledges: " + String(nationalArr[indexPath.row - 1].totalPledges)
                cell.imageView.downloaded(from: nationalArr[indexPath.row - 1].imageUrl)
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "issueCell", for: indexPath) as! IssueCollectionViewCell
        return cell
        
    }
    
}

struct Issue {
    var title: String!
    var description: String!
    var imageUrl : String!
    var no: String!
    var scope: String!
    var yes: String!
    var totalPledges: Int!
}
