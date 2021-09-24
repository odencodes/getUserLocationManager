//
//  ViewController.swift
//  UserLocationManager
//
//  Created by ODENZA on 14/8/2564 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ToLocationVC", sender: nil)
    }


}

