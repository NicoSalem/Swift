//
//  quizView.swift
//  Enigma
//
//  Created by Salem, Nicholas on 11/25/19.
//  Copyright © 2019 Salem, Nicholas. All rights reserved.
//

import Foundation
import UIKit

class quizView: UIViewController
{
    
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var userAnswer: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    var dif = "easy"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tapGesture()
        
    }
    
    func tapGesture()
    {
        let tap = UITapGestureRecognizer(target: self, action:#selector(tapFunc))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapFunc()
    {
        if(dif=="easy")
        {
            question.text = "what do you need to break before being useful?"
        }
        else {question.text = "I can run but never walk, I have a mouth but never talk, I have a head but never weep, I have a bed but never sleep, What am I"}
        instruction.alpha = 0
        question.alpha = 1
        
    }
    
//    func rightAnswer()
//    {
//        let tap = UITapGestureRecognizer(target: self, action:#selector(tapFunc))
//        view.addGestureRecognizer(tap)
//    }
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    {
        performSegue(withIdentifier: "WorL", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let wController = segue.destination as! winOrLController
        if(dif == "easy" && userAnswer.text!.contains("egg")){wController.labelText = "YOU WIN!"}
        else if(dif == "hard" && userAnswer.text!.contains("river")){wController.labelText = "YOU WIN!"}
        else{wController.labelText = "YOU LOOSE!"}
    }
    
}
