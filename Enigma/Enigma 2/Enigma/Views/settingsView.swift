//
//  settingsView.swift
//  Enigma
//
//  Created by Salem, Nicholas on 11/25/19.
//  Copyright © 2019 Salem, Nicholas. All rights reserved.
//


import Foundation
import UIKit

struct country: Decodable
{
    let name : String
    let capital : String
    let region : String
}
class settingsView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var pickerView: UIPickerView!
    var  pckrv = Picker()
    var dificulty = "easy"
    let defaults = UserDefaults.standard
    var firstN = ""
    var lastN = ""
    var ccc = ""
    @IBOutlet weak var fn: UILabel!
    @IBOutlet weak var ln: UILabel!
    @IBOutlet weak var dif: UILabel!
    @IBOutlet weak var capital: UILabel!
    
    struct keys
    {
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let dif = "dif"
        static let cap = "cap"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        return pckrv.options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pckrv.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dificulty = pckrv.options[row]
        self.defaults.set(dificulty, forKey: keys.dif)
        self.dif.text = self.defaults.value(forKeyPath: keys.dif) as! String
        performSegue(withIdentifier: "settings-quiz", sender: self)
    }
    
    @IBAction func onGo(_ sender: Any)
    {
        let alert = UIAlertController(title: "set your first and last name", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let titleTextField = alert.textFields?[0],
                let question = titleTextField.text else { return }
            
            
            guard let pwrdTextField = alert.textFields?[1],
                let notes = pwrdTextField.text else { return }
            
            self.defaults.set(question, forKey: keys.firstname)
            self.defaults.set(notes, forKey: keys.lastname)
            self.fn.text = self.defaults.value(forKeyPath: keys.firstname) as! String
            self.ln.text = self.defaults.value(forKeyPath: keys.lastname) as! String
            
            
        }
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "first name"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "last name"
        })
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
        
            
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.fn.text = self.defaults.value(forKeyPath: keys.firstname) as? String
        self.ln.text = self.defaults.value(forKeyPath: keys.lastname) as? String
        self.dif.text = self.defaults.value(forKeyPath: keys.dif) as? String
        self.capital.text = self.defaults.value(forKeyPath: keys.cap) as? String
        
        
    }
    
//    static func getDificulty() -> String
//    {
//        return dificulty
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var quizController = segue.destination as! quizView
        quizController.dif = dificulty
    }
    
    @IBAction func FindC(_ sender: Any)
    {
        print("start")
        let url = "https://restcountries.eu/rest/v2/all"
        let urlObj = URL(string: url)
        URLSession.shared.dataTask(with: urlObj!){(data, response, error) in
            do {
                var countries = try JSONDecoder().decode([country].self, from: data!)
                
                for country in countries {
                    
                    if (country.name == self.defaults.value(forKeyPath: keys.lastname) as? String)
                    {
                        print(country.name)
                        print(country.capital)
                        self.ccc = country.capital
                        self.defaults.set(self.ccc, forKey: keys.cap)
                        print(self.ccc)
                    }
                    
                }
            } catch {
                print("did not work")
            }
            //self.capital.text
        }.resume()
        self.capital.text = self.defaults.value(forKeyPath: keys.cap) as? String
    }
    
}
