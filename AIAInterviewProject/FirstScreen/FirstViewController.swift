//
//  FirstViewController.swift
//  AIAInterviewProject
//
//  Created by Satya on 23/05/21.
//

import UIKit

class FirstViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var tableViewSearch: UITableView!
    @IBOutlet var tableViewSymbolsData: UITableView!
    
    @IBOutlet var textFieldSearch: UITextField!
    
    @IBOutlet var labelSymbolName: UILabel!
    
    @IBOutlet var imageArrowOpen: UIImageView!
    @IBOutlet var imageArrowHigh: UIImageView!
    @IBOutlet var imageArrowLow: UIImageView!
    @IBOutlet var imageArrowDateTime: UIImageView!
    
    //Activity Indicator
    var viewActivity: UIView!
    var activitySpinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet var viewOverlaySearch: UIView!
    
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewSearch.rowHeight = UITableView.automaticDimension
        tableViewSearch.estimatedRowHeight = UITableView.automaticDimension
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
    
    //MARK: - Touch up inside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == viewOverlaySearch {
                viewOverlaySearch.isHidden = true
                tableViewSearch.isHidden = true
            }
        }
    }
    
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 2{
            return 10
        }
        else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 2{
            
            let cell_first_screen_search = tableView.dequeueReusableCell(withIdentifier: "FirstScreenSearchCellID") as! FirstScreenSearchCell
            
            if indexPath.row == 0{
                cell_first_screen_search.labelSearchResult.text = "IBM - IBM Company IBM CompanyIBM Company IBM Company"
            }
            else{
                cell_first_screen_search.labelSearchResult.text = "IBM - IBM Company IBM"
            }
            
            return cell_first_screen_search
        }
        else{
            let cell_first_screen = tableView.dequeueReusableCell(withIdentifier: "FirstSrcreenCellID") as! FirstSrcreenCell
            
    //        cell_first_screen.labelOpen.text = "1111440.0"
    //        cell_first_screen.labelHigh.text = "12323230.0"
    //        cell_first_screen.labelLow.text = "123220.0"
    //        cell_first_screen.labelDateTime.text = "28/08/2021"
            
            return cell_first_screen
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 2{
            return UITableView.automaticDimension
        }
        else{
            return 46
        }
    }
    
}

extension FirstViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
