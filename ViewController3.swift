//
//  ViewController3.swift
//  APIptmilli
//
//  Created by Joshua Barnett on 6/10/20.
//  Copyright © 2020 Joshua Barnett. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    var finalUrll = String()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func butt(_ sender: Any) {
        
        print(finalUrll)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! Collection
        vc.finalUrlll = finalUrll
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
