//
//  ViewController2.swift
//  APIptmilli
//
//  Created by Joshua Barnett on 6/1/20.
//  Copyright © 2020 Joshua Barnett. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    var finalUrl = String()
    var nexttUrl = String()
    var foodNumbers: [String: String] = ["Fast Food": "10646", "Bar": "10640", "Asian": "10659", "Sushi": "10653", "Italian": "4617", "Pizza": "10641", "Seafood": "10643", "Mexican": "5110", "Caribbean": "10622", "Chinese": "5379"]
    var foodTypes: [String] = ["Fast Food", "Bar", "Asian", "Sushi", "Italian", "Pizza", "Seafood", "Mexican", "Caribbean", "Chinese"]
    var foodCount: [String: Int] = ["Fast Food": 0, "Bar": 0, "Asian": 0, "Sushi": 0, "Italian": 0, "Pizza": 0, "Seafood": 0, "Mexican": 0, "Caribbean": 0, "Chinese": 0]
    @IBOutlet weak var starView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackConstraints()
        for key in foodTypes{
                var buttoncust = CustomButton()
                buttoncust.frame.size = CGSize(width: 25, height: 25)
                buttoncust.clipsToBounds = true
                buttoncust.layer.cornerRadius = 0.5 * buttoncust.bounds.size.width
                buttoncust.accessibilityLabel = key
                buttoncust.addTarget(self, action: #selector(checkBox), for: .touchUpInside)
                starView.addArrangedSubview(buttoncust)
            }
    }
        //Design
    func stackConstraints(){
        view.addSubview(starView)
        starView.distribution = .fillEqually
        starView.spacing = 20
    }
    @IBAction func checkBox(_ sender: CustomButton){
           if sender.isSelected{
               sender.isSelected = false
               sender.backgroundColor = UIColor.white
               foodCount[sender.accessibilityLabel!]! += 1
               print(foodCount)
           }
           else{
               sender.isSelected = true
               sender.backgroundColor = UIColor.systemBlue
               foodCount[sender.accessibilityLabel!]! += 1
               print(foodCount)
           }
           
       }
    
    @IBAction func nexttPage(_ sender: Any) {
        finalUrl = ulrSetter()
        print(finalUrl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vp = segue.destination as! ViewController3
        vp.finalUrll = finalUrl
    }
    
    
    func ulrSetter() -> String{
        var get = String()
        let breaker = "%252C"
        var count = 0
        var url = String()
        var count1 = 0
        for (key, value) in foodCount{
            count += 1
            if count > 1{
                if value % 2 != 0 {
                    get += breaker
                    get += foodNumbers[key]!
                }
            }else{
                if value % 2 != 0 {
                    get += foodNumbers[key]!
                }
            }
        }
        //print(get)
        var array = finalUrl.components(separatedBy: "&")
        
        if let i = array.firstIndex(of: "currency=USD") {
            array[i] = "currency=USD&combined_food=\(get)"
        }
        for i in array{
            count1 += 1
            if count1 < array.count{
               url += i + "&"
            }else{
               url += i
            }
        }
        return url
        
    }
        
        

}
