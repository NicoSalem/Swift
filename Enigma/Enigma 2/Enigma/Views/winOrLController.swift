//
//  winOrLController.swift
//  Enigma
//
//  Created by Salem, Nicholas on 11/26/19.
//  Copyright © 2019 Salem, Nicholas. All rights reserved.
//

import Foundation
import UIKit

class winOrLController: UIViewController
{
    @IBOutlet weak var winLabel: UILabel!
    var labelText = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        winLabel.text = labelText
    }
    
    
    
}
