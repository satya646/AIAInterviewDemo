//
//  FirstViewController.swift
//  AIAInterviewProject
//
//  Created by Satya on 23/05/21.
//

import UIKit

class FirstViewController: UIViewController, FirstViewProtocol {

    //MARK: - Properties
    @IBOutlet var tableViewSearch: UITableView!
    @IBOutlet var tableViewSymbolsData: UITableView!
    
    @IBOutlet var textFieldSearch: UITextField!
    
    @IBOutlet var labelSymbolName: UILabel!
    
    @IBOutlet var imageArrowOpen: UIImageView!
    var isOpenAscending: Bool = false
    
    @IBOutlet var imageArrowHigh: UIImageView!
    var isHighAscending: Bool = false
    
    @IBOutlet var imageArrowLow: UIImageView!
    var isLowAscending: Bool = false
    
    @IBOutlet var imageArrowDateTime: UIImageView!
    var isDateAscending: Bool = false
    
    @IBOutlet var viewSortOptions: UIView!
    
    //Activity Indicator
    var viewActivity: UIView!
    var activitySpinner = UIActivityIndicatorView(style: .large)
    
    @IBOutlet var viewOverlaySearch: UIView!
    
    var firstPresenter : FirstPresenter?
    
    var current_selected_symbol: String!
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewSearch.rowHeight = UITableView.automaticDimension
        tableViewSearch.estimatedRowHeight = UITableView.automaticDimension
        
        //Initialising presenter objects
        firstPresenter = FirstPresenter(view: self)
        firstPresenter?.restoreKeys()
    }
    
    
    
    //MARK: - Button Actions
    
    @IBAction func searchAction(_ sender: UIButton) {

        textFieldSearch.resignFirstResponder()
        if(textFieldSearch.text!.count > 0){
            firstPresenter?.searchSymbol(string_symbol: textFieldSearch.text!)
        }
    }
    
    @IBAction func openButtonAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
        
        if self.isOpenAscending{
            
            self.isOpenAscending = false
            UIView.animate(withDuration: 0.5) {
                self.imageArrowOpen.transform = CGAffineTransform.identity
            }
            
            self.firstPresenter?.intraData?.sort{
                ($0.timeSeriesValue?.open!)! > ($1.timeSeriesValue?.open!)!
            }
        }
        else{
            
            self.isOpenAscending = true
            UIView.animate(withDuration: 0.5) {
                self.imageArrowOpen.transform = CGAffineTransform(rotationAngle: .pi)
            }
            
            self.firstPresenter?.intraData?.sort{
                ($0.timeSeriesValue?.open!)! < ($1.timeSeriesValue?.open!)!
            }
        }
        
        tableViewSymbolsData.reloadData()
    }
    
    @IBAction func highButtonAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
        
        if self.isHighAscending{
            self.isHighAscending = false
            UIView.animate(withDuration: 0.5) {
                self.imageArrowHigh.transform = CGAffineTransform.identity
            }
            self.firstPresenter?.intraData?.sort{
                ($0.timeSeriesValue?.high!)! > ($1.timeSeriesValue?.high!)!
            }
        }
        else{
            self.isHighAscending = true
            UIView.animate(withDuration: 0.5) {
                self.imageArrowHigh.transform = CGAffineTransform(rotationAngle: .pi)
            }
            
            self.firstPresenter?.intraData?.sort{
                ($0.timeSeriesValue?.high!)! < ($1.timeSeriesValue?.high!)!
            }
        }
        
        tableViewSymbolsData.reloadData()
    }
    
    @IBAction func lowButtonAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
        
        if self.isLowAscending{
            self.isLowAscending = false
            
            UIView.animate(withDuration: 0.5) {
                self.imageArrowLow.transform = CGAffineTransform.identity
            }
            
            self.firstPresenter?.intraData?.sort{
                ($0.timeSeriesValue?.low!)! > ($1.timeSeriesValue?.low!)!
            }
            
        }
        else{
            self.isLowAscending = true
            
            UIView.animate(withDuration: 0.5) {
                self.imageArrowLow.transform = CGAffineTransform(rotationAngle: .pi)
            }
            
            self.firstPresenter?.intraData?.sort{
                ($0.timeSeriesValue?.low!)! < ($1.timeSeriesValue?.low!)!
            }
        }
        
        tableViewSymbolsData.reloadData()
    }
    
    @IBAction func dateTimeAction(_ sender: Any) {
        
        textFieldSearch.resignFirstResponder()
        
        
        if self.isDateAscending{
            self.isDateAscending = false
            UIView.animate(withDuration: 0.5) {
                self.imageArrowDateTime.transform = CGAffineTransform.identity
            }
            self.firstPresenter?.intraData?.sort{
                $0.timeSeriesKey! > $1.timeSeriesKey!
            }
        }
        else{
            self.isDateAscending = true
            UIView.animate(withDuration: 0.5) {
                self.imageArrowDateTime.transform = CGAffineTransform(rotationAngle: .pi)
            }
            self.firstPresenter?.intraData?.sort{
                $0.timeSeriesKey! < $1.timeSeriesKey!
            }
        }
        
        tableViewSymbolsData.reloadData()
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
                hideSearchElements()
            }
        }
    }
    
    //MARK: - Search Related
    
    func showSearchElements(){
        
        viewOverlaySearch.isHidden = false
        tableViewSearch.isHidden = false
    }
    
    func hideSearchElements(){
        
        viewOverlaySearch.isHidden = true
        tableViewSearch.isHidden = true
        textFieldSearch.resignFirstResponder()
    }
    
    func processSearchResults(){
        
        if let best_matches = firstPresenter?.symbol_search_results?.bestMatches{
            if best_matches.count > 0{
                tableViewSearch.reloadData()
            }
        }
    }
    
    func processSymbolIntraData(){
        
        if let time_series_ = firstPresenter?.intraData{
            if time_series_.count > 0{
                tableViewSymbolsData.reloadData()
                viewSortOptions.isHidden = false
                textFieldSearch.text = ""
            }
        }
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 2{
            
            if let best_matches = firstPresenter?.symbol_search_results?.bestMatches{
                if best_matches.count > 0{
                    return best_matches.count
                }
            }
            return 0
        }
        else{
            if let time_series_ = firstPresenter?.intraData{
                if time_series_.count > 0{
                    return time_series_.count
                }
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 2{
            
            let cell_first_screen_search = tableView.dequeueReusableCell(withIdentifier: "FirstScreenSearchCellID") as! FirstScreenSearchCell
            
            if let best_matches = firstPresenter?.symbol_search_results?.bestMatches{
                
                let symbol_data = best_matches[indexPath.row]
                if let symbol_ = symbol_data.symbol, let name_ = symbol_data.name{
                    cell_first_screen_search.labelSearchResult.text = symbol_ + " - " + name_
                }
            }
            
            return cell_first_screen_search
        }
        else{
            let cell_first_screen = tableView.dequeueReusableCell(withIdentifier: "FirstSrcreenCellID") as! FirstSrcreenCell
            
            if let time_series_ = firstPresenter?.intraData{

                let timeSeries = time_series_[indexPath.row]
                
                cell_first_screen.labelDateTime.text = timeSeries.timeSeriesKey
                
                let symbolInformation = timeSeries.timeSeriesValue
                cell_first_screen.labelOpen.text = symbolInformation?.open
                cell_first_screen.labelHigh.text = symbolInformation?.high
                cell_first_screen.labelLow.text = symbolInformation?.low
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 2{
         
            if let best_matches = firstPresenter?.symbol_search_results?.bestMatches{
                
                let symbol_data = best_matches[indexPath.row]
                if let symbol_ = symbol_data.symbol, let name_ = symbol_data.name{
                    
                    labelSymbolName.text = symbol_ + " - " + name_
                    
                    current_selected_symbol = symbol_
                    
                    hideSearchElements()
                    
                    //Fetch the symbol data and load in the main table
                    firstPresenter?.fetchSymbolData(string_symbol: symbol_)
                }
            }
        }
    }
    
}

extension FirstViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if(textField.text!.count > 0){
            firstPresenter?.searchSymbol(string_symbol: textField.text!)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if(updatedText.count > 0){
                firstPresenter?.searchSymbol(string_symbol: updatedText)
                showSearchElements()
            }
            else{
                hideSearchElements()
            }
            
        }
        
        return true
    }
    
}
