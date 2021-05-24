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
        restoreValues()
    }

    //MARK: - Button Actions
    
    @IBAction func saveAction(_ sender: Any) {
        
        textFieldAPIKey.resignFirstResponder()
        textFieldInterval.resignFirstResponder()
        textFieldOutput.resignFirstResponder()
        
        //Storing API KEY into keychain
        if let string_key = textFieldAPIKey.text{
            let _ = save(key: "API_KEY", data: Data(string_key.utf8))
        }
        
        //Storing Interval into UserDefaults
        if let string_interval = textFieldInterval.text{
            UserDefaults.standard.setValue(string_interval, forKey: "INTERVAL_VALUE")
        }
        
        //Storing Output into UserDefaults
        if let string_interval = textFieldOutput.text{
            UserDefaults.standard.setValue(string_interval, forKey: "OUTPUT_VALUE")
        }
        
    }
    
    
    //MARK: - KeyChain Methods
    func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
    
    //MARK: - Restore Stored Values
    func restoreValues(){
        
        //Restoring API_KEY, Interval and Output into textfields on viewdidload
        let result = load(key: "API_KEY")
        if let data_result = result{
            if let string_to_data = String(data: data_result, encoding: .utf8){
                textFieldAPIKey.text = string_to_data
            }
        }
        
        if let string_interval = UserDefaults.standard.value(forKey: "INTERVAL_VALUE") as? String{
            textFieldInterval.text = string_interval
        }
        
        if let string_output = UserDefaults.standard.value(forKey: "INTERVAL_VALUE") as? String{
            textFieldOutput.text = string_output
        }
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

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}
