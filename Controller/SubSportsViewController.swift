//
//  SubSportsViewController.swift
//  GoNature
//
//  Created by Kullanici on 8.01.2023.
//

import UIKit
import Firebase
class SubSportsViewController: UIViewController {

    @IBOutlet weak var subSportsTableView: UITableView!
    
    var subSportModel : [SubSportModel] = []
    let addPlaceViewControler = AddPlaceViewController()
    let db = Firestore.firestore()
    let lon : Double!
    let lat : Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        subSportsTableView.dataSource = self
        subSportsTableView.delegate = self
        subSportsTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subSportCell")
        subSportsTableView.rowHeight = 230.0
        loadData()
     
       
    }
  
    @IBAction func reloadPressed(_ sender: UIButton) {
//        print("reload Pressed")
//        loadData()
    }
    func loadData()  {

        db.collection("sportData").order(by: "date").addSnapshotListener { QuerySnapshot, Error in
            if let e = Error {
                print(e)
            } else {
                self.subSportModel = []
                if let snapshot = QuerySnapshot?.documents {
                    for i in snapshot {
                        let data = i.data()
                        if let placeGet = data["place"] as? String, let commentGet = data["comment"] as? String, let latGet = data["lat"] as? Double, let lonGet = data["lon"] as? Double{
                            let newPlace = SubSportModel(placeName: placeGet, comment: commentGet,lat: latGet,lon: lonGet)
                            self.subSportModel.append(newPlace)
                            DispatchQueue.main.async {
                                self.subSportsTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }

    }
 
}
extension SubSportsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return     subSportModel.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subCell = tableView.dequeueReusableCell(withIdentifier: "subSportCell", for: indexPath) as! TableViewCell
        subCell.nameLabel.text = subSportModel[indexPath.row].placeName
        subCell.commentLabel.text = subSportModel[indexPath.row].comment
        return subCell
        
    }
    
    
    
}
extension SubSportsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: "http://maps.google.com/maps?z=12&t=m&q=loc:\()+\("lon")")! as URL, options: [:], completionHandler: nil)
        print("delegate calıştı")
    }
}
