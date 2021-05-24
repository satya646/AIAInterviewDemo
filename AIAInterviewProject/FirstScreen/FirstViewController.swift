//
//  FirstViewController.swift
//  AIAInterviewProject
//
//  Created by Satya on 23/05/21.
//

import UIKit

class FirstViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var textFieldSearch: UITextField!
    
    @IBOutlet var labelSymbolName: UILabel!
    
    @IBOutlet var imageArrowOpen: UIImageView!
    @IBOutlet var imageArrowHigh: UIImageView!
    @IBOutlet var imageArrowLow: UIImageView!
    @IBOutlet var imageArrowDateTime: UIImageView!
    
    //Activity Indicator
    var viewActivity: UIView!
    var activitySpinner = UIActivityIndicatorView(style: .large)
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    //MARK: - Button Actions
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    @IBAction func openButtonAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    @IBAction func highButtonAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    @IBAction func lowButtonAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    @IBAction func dateTimeAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    //MARK: - Activity Indicator
    
    func showActivityIndicator(){
        
        viewActivity = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        viewActivity.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.addSubview(viewActivity)
        
        activitySpinner.frame = CGRect(x: view.frame.width/2-50/2, y: view.frame.height/2-50/2, width: 50, height: 50)
        activitySpinner.color = UIColor.white
        viewActivity.addSubview(activitySpinner)
        activitySpinner.startAnimating()
        
    }
    
    func stopActivityIndicator(){
        
        activitySpinner.stopAnimating()
        viewActivity.removeFromSuperview()
    }
    
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell_first_screen = tableView.dequeueReusableCell(withIdentifier: "FirstSrcreenCellID") as! FirstSrcreenCell
        
        cell_first_screen.labelOpen.text = "1111440.0"
        cell_first_screen.labelHigh.text = "12323230.0"
        cell_first_screen.labelLow.text = "123220.0"
        cell_first_screen.labelDateTime.text = "28/08/2021"
        
        return cell_first_screen
    }
}

extension FirstViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
