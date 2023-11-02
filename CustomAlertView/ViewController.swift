//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Ozan Çiçek on 2.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
   
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let alertView = AlertViewWithButton(title: "Bilgi", messageText: "Plese Take Yourself From Bad People!")
        alertView.showAlert()
    }
    
}

