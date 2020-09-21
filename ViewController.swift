//
//  ViewController.swift
//  APIptmilli
//
//  Created by Joshua Barnett on 5/15/20.
//  Copyright © 2020 Joshua Barnett. All rights reserved.
//

import UIKit
import CoreLocation



//Vegetarian Friendly 10665/American 9908/Vegan Options 10697/Gluten Free Options 10992
//Mexican 5110/Latin 10639/Central American 10760/South American 10749
//Chinese 5379/Asian 10659/Seafood 10643/Sushi 10653/10622 Caribbean
//Italian 4617/Bar 10640/Indian 10346/Fast food 10646/Pizza 10641

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentlocation = CLLocation()
    
    var titleLabel = UILabel()
    var stackView = UIStackView()
   
    @IBOutlet weak var stabView: UIStackView!
    
    var urldietcount: [String: Int] = ["Vegan": 0, "Vegetarian": 0, "Gluten": 0]
    var urldietnames: [String] = ["Vegan", "Vegetarian", "Gluten"]
    var restrictions: [String:String] = ["Vegan": "10697", "Vegetarian": "10665", "Gluten": "10992", "None": ""]
    var locValue = CLLocationCoordinate2D()
    var nextUrl = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        stackConstraints()
        for key in urldietnames{
            var buttoncust = CustomButton()
            buttoncust.frame.size = CGSize(width: 50, height: 50)
            buttoncust.clipsToBounds = true
            buttoncust.layer.cornerRadius = 0.5 * buttoncust.bounds.size.width
            buttoncust.accessibilityLabel = key
            buttoncust.addTarget(self, action: #selector(checkBox), for: .touchUpInside)
            stabView.addArrangedSubview(buttoncust)
        }
        getCurrentLocation()
    }
    //Design
    func stackConstraints(){
        view.addSubview(stabView)
        stabView.distribution = .fillEqually
        stabView.spacing = 20
    }//if ((password.elementsEqual(repeatPassword)) == true)

    @IBAction func checkBox(_ sender: CustomButton){
        if sender.isSelected{
            sender.isSelected = false
            sender.backgroundColor = UIColor.white
            urldietcount[sender.accessibilityLabel!]! += 1
            print(urldietcount)
        }
        else{
            sender.isSelected = true
            sender.backgroundColor = UIColor.systemBlue
            urldietcount[sender.accessibilityLabel!]! += 1
            print(urldietcount)
        }
        
    }
    //End of design
    
    //Getting location
    
    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locValue = manager.location?.coordinate as! CLLocationCoordinate2D
        //print(locValue)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied){
            showLocationDisabledPopUp()
        }
    }
    
    
    func authorizelocationstates(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentlocation = locationManager.location!
        }
        else{
            // Note : This function is overlap permission
            //  locationManager.requestWhenInUseAuthorization()
           //  authorizelocationstates()
        }
    }
    func showLocationDisabledPopUp(){
        let alertControler = UIAlertController(title: "Background location acces disabled", message: "In order to deliver Pizzas we need your address", preferredStyle: .alert)
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertControler.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))

        self.present(alertControler, animated: true, completion: nil)
        
    }
    
    //End of getting location
    
    
    //Url construction
    
    
    @IBAction func nextPage(_ sender: UIButton) {
        nextUrl = ulrSetter(locValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController2
        vc.finalUrl = nextUrl
    }
    func ulrSetter(_ coords: CLLocationCoordinate2D) -> String{
        var get = String()
        let breaker = "%252C"
        var countie = 0
        for (key, value) in urldietcount{
            countie += 1
            if countie > 1{
                if value % 2 != 0 {
                    get += breaker
                    get += restrictions[key]!
                }
            }else{
                if value % 2 != 0 {
                    get += restrictions[key]!
                }
            }
        }
        //print(get)
        if get.contains(breaker){
            let url = "https://tripadvisor1.p.rapidapi.com/restaurants/list-by-latlng?limit=3&currency=USD&distance=1&dietary_restrictions=\(get)&lunit=km&lang=en_US&latitude=\(locValue.latitude)&longitude=\(locValue.longitude)"
            return url
        }
        else{
            return ("https://tripadvisor1.p.rapidapi.com/restaurants/list-by-latlng?limit=3&currency=USD&distance=1&dietary_restrictions=\(get)&lunit=km&lang=en_US&latitude=\(locValue.latitude)&longitude=\(locValue.longitude)")
        }
        
    }
    
    
    
    
    
    
    
    
}








extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}

/*extension ViewController: UITableViewDelegate{
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rt.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = rt[indexPath.row]
        
        return cell
    }
    
}*/

