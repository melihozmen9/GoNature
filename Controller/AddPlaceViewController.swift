//
//  AddPlaceViewController.swift
//  GoNature
//
//  Created by Kullanici on 8.01.2023.
//

import UIKit
import Firebase
import CoreLocation
class AddPlaceViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var commentPlace: UITextField!
    @IBOutlet weak var namePlace: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    let dc = Firestore.firestore()
    let sportData : [SubSportModel] = []
    let locationManager = CLLocationManager()
    var lat : Double!
    var lon : Double!
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        navigationItem.hidesBackButton = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addGPS(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    @IBAction func addPhotoPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func addLocationPressed(_ sender: UIButton) {
        if let namePlace = namePlace.text,
           let dataSender = Auth.auth().currentUser?.email,
           let comment = commentPlace.text,
           let lati = lat,
           let long = lon
           {
            dc.collection("sportData").addDocument(data: [
                "place" : namePlace,
                "sender" : dataSender,
                "date" : Date().timeIntervalSince1970,
                "comment" : comment,
                "lat" : lati,
                "lon" : long
                
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("data sent succesfully")
                }
            }
            
        }
        
    }


}
extension AddPlaceViewController : UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        placeImage.image = image
    }
}
extension AddPlaceViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
       if let location = locations.last {
        lat = location.coordinate.latitude
         lon = location.coordinate.longitude
        }
        print("konum alındı.")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
