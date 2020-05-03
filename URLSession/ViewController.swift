//
//  ViewController.swift
//  URLSession
//
//  Created by Patryk on 01/05/2020.
//  Copyright © 2020 Patryk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let urlSessionService = URLSessionService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendRequest(_ sender: Any) {
        urlSessionService.sendRequest()
    }
}

