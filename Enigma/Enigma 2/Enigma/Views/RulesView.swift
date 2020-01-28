//
//  RulesView.swift
//  Enigma
//
//  Created by Salem, Nicholas on 11/24/19.
//  Copyright © 2019 Salem, Nicholas. All rights reserved.
//

import Foundation
import UIKit

class RulesView: UIViewController
{
    @IBOutlet weak var rules: UILabel!
    @IBOutlet weak var rules1: UILabel!
    @IBOutlet weak var rules2: UILabel!
    @IBOutlet weak var back: UIButton!    
    @IBOutlet weak var rulesLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        rules.text = NSLocalizedString("rules", comment: "")
        rules1.text = NSLocalizedString("rules1", comment: "")
        rules2.text = NSLocalizedString("rules2", comment: "")
        back.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
        
        
        
    }
    
    
    
    
    
}
