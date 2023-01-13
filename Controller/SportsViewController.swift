//
//  SportsViewController.swift
//  GoNature
//
//  Created by Kullanici on 8.01.2023.
//

import UIKit

class SportsViewController: UIViewController {
    @IBOutlet weak var sportTableView: UITableView!
    let sports = SportsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportTableView.dataSource = self
        sportTableView.delegate = self
        // Do any additional setup after loading the view.
        sportTableView.register(UINib(nibName: "SportsTableViewCell", bundle: nil), forCellReuseIdentifier: "sportCellReminder")
    }
    


}
extension SportsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCellReminder", for: indexPath) as! SportsTableViewCell
        cell.sportLabel.text = sports.sports[indexPath.row]
        
        return cell
    }
   
    
    
}

extension SportsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sportToSubSport", sender: self)
    }
}
