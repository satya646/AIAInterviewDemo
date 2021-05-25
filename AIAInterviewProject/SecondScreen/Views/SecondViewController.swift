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
    
    @IBOutlet var tableViewSymbols: UITableView!
//    @IBOutlet var tableViewSearch: UITableView!
    
    @IBOutlet var tableViewSearchSymbol: UITableView!
    
    //Activity Indicator
    var viewActivity: UIView!
    var activitySpinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet var viewOverlaySearch: UIView!
    
    var secondPresenter : SecondPresenter?
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        tableViewSearchSymbol.rowHeight = UITableView.automaticDimension
        tableViewSearchSymbol.estimatedRowHeight = UITableView.automaticDimension
        
        //Initialising presenter objects
        secondPresenter = SecondPresenter(view: self)
    }
    
    //MARK: - Button Actions
    
    @IBAction func addAction(_ sender: UIButton) {
        
        textFieldSearch.resignFirstResponder()
    }
    
    @IBAction func clearSymbolOneAction(_ sender: Any) {
        
        viewSymbolOne.isHidden = true
        secondPresenter?.intraDataOne?.removeAll()
        tableViewSymbols.reloadData()
    }
    
    @IBAction func clearSymbolTwoAction(_ sender: Any) {
        
        viewSymbolTwo.isHidden = true
        secondPresenter?.intraDataTwo?.removeAll()
        tableViewSymbols.reloadData()
    }
    
    @IBAction func clearSymbolThreeAction(_ sender: Any) {
        
        viewSymbolThree.isHidden = true
        secondPresenter?.intraDataThree?.removeAll()
        tableViewSymbols.reloadData()
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
    
    func showNotFoundAlert(string_name: String){
        
        let message = "Symbol Data Not Found for Symbol \"\(string_name)\""
        
        let alert = UIAlertController(title: "AIA", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSearchLimitAlert(){
        
        let message = "Comparision limited to only 3 symbols. Please clear a Symol and try again."
        
        let alert = UIAlertController(title: "AIA", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func userLimitReached(string_note: String){
        
        let alert = UIAlertController(title: "AIA", message: string_note, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Touch up inside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == viewOverlaySearch {
                hideSearchElements()
            }
        }
    }
    
    //MARK: - Search Related
    
    func showSearchElements(){
        
        viewOverlaySearch.isHidden = false
        tableViewSearchSymbol.isHidden = false
    }
    
    func hideSearchElements(){
        
        viewOverlaySearch.isHidden = true
        tableViewSearchSymbol.isHidden = true
        textFieldSearch.resignFirstResponder()
    }
    
    func processSearchResults(){
        
        if let best_matches = secondPresenter?.symbol_search_results?.bestMatches{
            if best_matches.count > 0{
                tableViewSearchSymbol.reloadData()
            }
        }
    }
    
    func processSymbolsData(){
        
        
        //Process and add data together
        print("IntraData One: \(String(describing: secondPresenter?.intraDataOne!))")
        print("IntraData Two: \(String(describing: secondPresenter?.intraDataTwo!))")
        print("IntraData Three: \(String(describing: secondPresenter?.intraDataThree!))")
        
        
        if let intra_data_one = secondPresenter?.intraDataOne{
            if intra_data_one.count > 0{
                showSymbolOneResultStack()
                tableViewSymbols.reloadData()
            }
        }
        
        if let intra_data_two = secondPresenter?.intraDataTwo{
            if intra_data_two.count > 0{
                showSymbolTwoResultStack()
                tableViewSymbols.reloadData()
            }
        }
        
        if let intra_data_three = secondPresenter?.intraDataThree{
            if intra_data_three.count > 0{
                showSymbolThreeResultStack()
                tableViewSymbols.reloadData()
            }
        }
        
    }
    
    //MARK: - Manage Symbols
    
    func showSymbolOneResultStack(){
        
        viewSymbolOne.isHidden = false
        
        textFieldSearch.text = ""
        
        //Plot the symbol one data
        if let intra_data_one = secondPresenter?.intraDataOne{
            if intra_data_one.count > 0{
                let intraData = intra_data_one[0]
                labelSymbolOne.text = intraData.name
            }
        }
    }
    
    func showSymbolTwoResultStack(){
        
        viewSymbolTwo.isHidden = false
        
        textFieldSearch.text = ""
        
        //Plot the symbol two data
        if let intra_data_one = secondPresenter?.intraDataTwo{
            if intra_data_one.count > 0{
                let intraData = intra_data_one[0]
                labelSymbolTwo.text = intraData.name
            }
        }
    }
    
    func showSymbolThreeResultStack(){
        
        viewSymbolThree.isHidden = false
        
        textFieldSearch.text = ""
        
        //Plot the symbol three data
        if let intra_data_one = secondPresenter?.intraDataThree{
            if intra_data_one.count > 0{
                let intraData = intra_data_one[0]
                labelSymbolThree.text = intraData.name
            }
        }
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 2{
            
            if let best_matches = secondPresenter?.symbol_search_results?.bestMatches{
                if best_matches.count > 0{
                    return best_matches.count
                }
            }
            return 0
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 2{
            
            let cell_first_screen_search = tableView.dequeueReusableCell(withIdentifier: "FirstScreenSearchCellIDD") as! FirstScreenSearchCell
            
            if let best_matches = secondPresenter?.symbol_search_results?.bestMatches{
                
                let symbol_data = best_matches[indexPath.row]
                if let symbol_ = symbol_data.symbol, let name_ = symbol_data.name{
                    cell_first_screen_search.labelSearchResult.text = symbol_ + " - " + name_
                }
            }
            
            return cell_first_screen_search
        }
        else{
            
            let cell_first_screen = tableView.dequeueReusableCell(withIdentifier: "SecondScreenCellID") as! SecondScreenCell
            
            if !viewSymbolOne.isHidden{
                
                cell_first_screen.viewSymbolOne.isHidden = false
                
                if let data = secondPresenter?.intraDataOne{
                    
                    let intra_data = data[indexPath.section]
                    
                    cell_first_screen.labelOpen.text = intra_data.timeSeriesValue?.open
                    cell_first_screen.labelLow.text = intra_data.timeSeriesValue?.low
                }
            }
            else{
                cell_first_screen.viewSymbolOne.isHidden = true
            }
            
            if !viewSymbolTwo.isHidden{
                
                cell_first_screen.viewSymbolTwo.isHidden = false
                
                if let data = secondPresenter?.intraDataTwo{
                    
                    let intra_data = data[indexPath.section]
                    
                    cell_first_screen.labelOpenTwo.text = intra_data.timeSeriesValue?.open
                    cell_first_screen.labelLowTwo.text = intra_data.timeSeriesValue?.low
                }
            }
            else{
                cell_first_screen.viewSymbolTwo.isHidden = true
            }
            
            if !viewSymbolThree.isHidden{
                
                cell_first_screen.viewSymbolThree.isHidden = false
                
                if let data = secondPresenter?.intraDataThree{
                    
                    let intra_data = data[indexPath.section]
                    
                    cell_first_screen.labelOpenThree.text = intra_data.timeSeriesValue?.open
                    cell_first_screen.labelLowThree.text = intra_data.timeSeriesValue?.low
                }
            }
            else{
                cell_first_screen.viewSymbolThree.isHidden = true
            }
            
            return cell_first_screen
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 2{
            return UITableView.automaticDimension
        }
        else{
            return 116
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 2{
            return 1
        }
        else{
            
            if let data = secondPresenter?.intraDataOne{
                return data.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView.tag != 2{
            
            let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
            viewHeader.backgroundColor = UIColor.systemGray5
            
            let viewHeaderBackground = UIView(frame: CGRect(x: 15, y: 5, width: view.frame.width-30, height: 50))
            viewHeaderBackground.backgroundColor = UIColor.systemGray6
    //        viewHeaderBackground.layer.cornerRadius = 15
            viewHeader.addSubview(viewHeaderBackground)
            
            let labelTitle = UILabel(frame: CGRect(x: 15, y: 0, width: viewHeaderBackground.frame.width-10, height: viewHeaderBackground.frame.height))
            labelTitle.textColor = UIColor.black
            viewHeaderBackground.addSubview(labelTitle)
            
            if let data = secondPresenter?.intraDataOne{
                
                if data.count > 0{
                    let intra_data = data[section]
                    labelTitle.text = intra_data.timeSeriesKey
                }
            }
            
            return viewHeader
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 2{
            return 0
        }
        else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 2{
         
            if let best_matches = secondPresenter?.symbol_search_results?.bestMatches{
                
                let symbol_data = best_matches[indexPath.row]
                if let symbol_ = symbol_data.symbol{
                    
                    hideSearchElements()
                    
                    //Fetch the symbol data and load in the main table
                    secondPresenter?.fetchSymbolData(string_symbol: symbol_)
                }
            }
        }
    }
    
}

extension SecondViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if(textField.text!.count > 0){
            secondPresenter?.searchSymbol(string_symbol: textField.text!)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if(updatedText.count > 0){
                secondPresenter?.searchSymbol(string_symbol: updatedText)
                showSearchElements()
            }
            else{
                hideSearchElements()
            }
            
        }
        
        return true
    }
}
