//
//  DirectionViewController.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 12/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import UIKit

class DirectionViewController: UIViewController {

    @IBOutlet weak var lblStation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Created for a possible selection in the Station Tab
        lblStation.text = "Blackrock"
    }
    
    @IBAction func btnNorthbound_Touch(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func btnSouthbound_Touch(_ sender: UIButton) {
        
    }
}
