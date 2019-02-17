//
//  TopCollectionViewCell.swift
//  VoteX
//
//  Created by Abhinav Kolli on 2/16/19.
//  Copyright © 2019 Abhinav Kolli. All rights reserved.
//

import UIKit
import Disk

class TopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    var scope: String!
    var retrievedPolticians = [Politician]()
    
    @IBOutlet weak var polLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            self.retrievedPolticians = self.getPoliticians()
            self.tableView.reloadData()
        })
    }
    
    func refresh () {
        self.retrievedPolticians = self.getPoliticians()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay(), execute: {
            print("reloading")
            print(self.retrievedPolticians)
            self.tableView.reloadData()
        })
    }
    
    func getPoliticians () -> [Politician]{
        var retrievedPoliticians = [Politician]()
        do {
            retrievedPoliticians = try Disk.retrieve("politicians.json", from: .caches, as: [Politician].self)
        } catch {
            print(error)
        }
        var newPoliticians = [Politician]()
        if retrievedPoliticians.count > 0 {
            for politician in retrievedPoliticians {
                if politician.scope == scope {
                    newPoliticians.append(politician)
                }
            }
        } else {
            polLabel.text = "No politicians yet. Start pledging now!"
        }
        newPoliticians = newPoliticians.sorted(by: {$0.pledges > $1.pledges})
        print("RERENDERING POLITICIANS")
        print(newPoliticians)
        return newPoliticians
    }

}



extension TopCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(retrievedPolticians.count < 4)
        {
            return retrievedPolticians.count
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as! UITableViewCell
        var a = ""
        var tabCount = 7
        if retrievedPolticians[indexPath.row].name.count > 12 {
            tabCount = tabCount - 1
        }
        for i in 0...tabCount {
            a += "\t"
        }
        if (scope == "National") {
            if indexPath.row != 0{
                a += "\t"
            }
        }
        cell.textLabel?.text = retrievedPolticians[indexPath.row].name + a + String(retrievedPolticians[indexPath.row].pledges)
        
        return cell
    }
    
}

extension TopCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}
