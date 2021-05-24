//
//  SecondViewController.swift
//  AIAInterviewProject
//
//  Created by Satya on 23/05/21.
//

import UIKit

class SecondViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var textFieldSearch: UITextField!
    
    @IBOutlet var labelSymbolOne: UILabel!
    @IBOutlet var labelSymbolTwo: UILabel!
    @IBOutlet var labelSymbolThree: UILabel!
    
    @IBOutlet var viewSymbolOne: UIControl!
    @IBOutlet var viewSymbolTwo: UIControl!
    @IBOutlet var viewSymbolThree: UIControl!
    
    //Activity Indicator
    var viewActivity: UIView!
    var activitySpinner = UIActivityIndicatorView(style: .large)
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Button Actions
    
    @IBAction func addAction(_ sender: UIButton) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    @IBAction func clearSymbolOneAction(_ sender: Any) {
        
        viewSymbolOne.isHidden = true
    }
    
    @IBAction func clearSymbolTwoAction(_ sender: Any) {
        
        viewSymbolTwo.isHidden = true
    }
    
    @IBAction func clearSymbolThreeAction(_ sender: Any) {
        
        viewSymbolThree.isHidden = true
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

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell_first_screen = tableView.dequeueReusableCell(withIdentifier: "SecondScreenCellID") as! SecondScreenCell
        
//        cell_first_screen.labelOpen.text = "1111440.0"
//        cell_first_screen.labelHigh.text = "12323230.0"
//        cell_first_screen.labelLow.text = "123220.0"
//        cell_first_screen.labelDateTime.text = "28/08/2021"
        
        return cell_first_screen
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        viewHeader.backgroundColor = UIColor.systemGray5
        
        let viewHeaderBackground = UIView(frame: CGRect(x: 15, y: 5, width: view.frame.width-30, height: 50))
        viewHeaderBackground.backgroundColor = UIColor.systemGray6
//        viewHeaderBackground.layer.cornerRadius = 15
        viewHeader.addSubview(viewHeaderBackground)
        
        let labelTitle = UILabel(frame: CGRect(x: 15, y: 0, width: viewHeaderBackground.frame.width-10, height: viewHeaderBackground.frame.height))
        labelTitle.text = "19/09/2021"
        labelTitle.textColor = UIColor.black
        viewHeaderBackground.addSubview(labelTitle)
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}

extension SecondViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
