//
//  ThirdViewController.swift
//  AIAInterviewProject
//
//  Created by Satya on 24/05/21.
//

import UIKit

class ThirdViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var textFieldAPIKey: UITextField!
    @IBOutlet var textFieldInterval: UITextField!
    @IBOutlet var textFieldOutput: UITextField!
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - Button Actions
    
    @IBAction func saveAction(_ sender: Any) {
        
        textFieldAPIKey.resignFirstResponder()
        textFieldInterval.resignFirstResponder()
        textFieldOutput.resignFirstResponder()
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textFieldAPIKey.resignFirstResponder()
        textFieldInterval.resignFirstResponder()
        textFieldOutput.resignFirstResponder()
    }
    
}

extension ThirdViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldAPIKey.resignFirstResponder()
        textFieldInterval.resignFirstResponder()
        textFieldOutput.resignFirstResponder()
        
        return true
    }
    
}
