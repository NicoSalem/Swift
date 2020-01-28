//
//  ViewController.swift
//  Enigma
//
//  Created by Salem, Nicholas on 11/23/19.
//  Copyright © 2019 Salem, Nicholas. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackedButtons: UIStackView!
    @IBOutlet weak var `continue`: UIButton!
    @IBOutlet weak var rules: UIButton!
    @IBOutlet weak var notes: UIButton!
    @IBOutlet weak var settings: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture()
        swipeLeftGesture()
        swipeRightGesture()
        animation1()
        `continue`.setTitle(NSLocalizedString("continue", comment: ""), for: .normal)
        rules.setTitle(NSLocalizedString("rules", comment: ""), for: .normal)
        notes.setTitle(NSLocalizedString("notes", comment: ""), for: .normal)
        settings.setTitle(NSLocalizedString("settings", comment: ""), for: .normal)
    }
    
    
    
    func tapGesture()
    {
        let tap = UITapGestureRecognizer(target: self, action:#selector(tapFunc))
        view.addGestureRecognizer(tap)
    }

    func swipeLeftGesture()
    {
        let sl = UISwipeGestureRecognizer(target: self, action:#selector(left))
        sl.direction = .left
       
        view.addGestureRecognizer(sl)
    }
    
    func swipeRightGesture()
    {
        let sr = UISwipeGestureRecognizer(target: self, action:#selector(right))
        sr.direction = .right
        view.addGestureRecognizer(sr)
    }

    @objc func left()
    {
        view.backgroundColor = UIColor.blue
    }
    
    @objc func right()
    {
        view.backgroundColor = UIColor.black
        //        let rules = RulesView()
        //        present(rules, animated:true, completion: nil)
    }
    
    @objc func tapFunc()
    {
        UIView.animate(withDuration: 1, animations: //1
            {
                let angle = CGFloat(100)
                self.titleLabel.transform = CGAffineTransform(rotationAngle: angle)
        }
            , completion:
            {_ in
                UIView.animate(withDuration: 1, animations: //2
                    {
                        let angle = CGFloat(-50)
                        self.titleLabel.transform = CGAffineTransform(rotationAngle: angle)
                }
                    , completion:
                    {_ in
                        UIView.animate(withDuration: 1, animations: //2
                            {
                                let angle = CGFloat(100)
                                self.titleLabel.transform = CGAffineTransform(rotationAngle: angle)
                        })
                })
        })
    }
    
    func animation1()
    {
        UIView.animate(withDuration: 3, animations: //1
        {
            self.titleLabel.alpha = 1
        }, completion:
            {_ in
                self.animation2()
                UIView.animate(withDuration: 3, animations: //2
                {
                    self.stackedButtons.alpha = 1
                })
            })
    }
    
    func animation2()
    {
        
        UIView.animate(withDuration: 1, animations: //1
        {
                let angle = CGFloat(100)
                self.titleLabel.transform = CGAffineTransform(rotationAngle: angle)
        }
        , completion:
            {_ in
                UIView.animate(withDuration: 1, animations: //2
                {
                        let angle = CGFloat(-50)
                        self.titleLabel.transform = CGAffineTransform(rotationAngle: angle)
                }
                , completion:
                    {_ in
                        UIView.animate(withDuration: 1, animations: //2
                        {
                                let angle = CGFloat(100)
                                self.titleLabel.transform = CGAffineTransform(rotationAngle: angle)
                        })
                })
        })
    }
    
    
}

