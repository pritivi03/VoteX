import UIKit
import Disk

class PledgesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var pledges : [Pledge]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        var retrievedPledges : [Pledge]!
        do {
            retrievedPledges = try Disk.retrieve("pledges.json", from: .caches, as: [Pledge].self)
        } catch {
            print(error)
        }
        pledges = retrievedPledges
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            self.tableView.reloadData()
            print(self.pledges)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pledges.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pledgeCell", for: indexPath) as! PledgeTableViewCell
        cell.issueNameLabel.text = pledges[indexPath.row].title
        cell.scopeLabel.text = pledges[indexPath.row].scope
        cell.politiciansLabel.text = pledges[indexPath.row].politicians
        cell.dateLabel.text = pledges[indexPath.row].date
        if pledges[indexPath.row].choice == "yes" {
            cell.pledgeImageView.downloaded(from: pledges[indexPath.row].imageUrl)
        } else if pledges[indexPath.row].choice == "no" {
            cell.pledgeImageView.downloaded(from: pledges[indexPath.row].imageUrl)
        }
        return cell
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        nextViewController.selected = "Local"
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
