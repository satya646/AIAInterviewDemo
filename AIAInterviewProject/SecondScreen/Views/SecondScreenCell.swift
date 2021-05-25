//
//  SecondScreenCell.swift
//  AIAInterviewProject
//
//  Created by Satya on 23/05/21.
//

import UIKit

class SecondScreenCell: UITableViewCell {

    @IBOutlet var labelOpen: UILabel!
    @IBOutlet var labelLow: UILabel!
    
    @IBOutlet var labelOpenTwo: UILabel!
    @IBOutlet var labelLowTwo: UILabel!
    
    @IBOutlet var labelOpenThree: UILabel!
    @IBOutlet var labelLowThree: UILabel!
    
    @IBOutlet var viewSymbolOne: UIView!
    @IBOutlet var viewSymbolTwo: UIView!
    @IBOutlet var viewSymbolThree: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hideSymbolOne(){
        viewSymbolOne.isHidden = true
    }
    
    func hideSymbolTwo(){
        viewSymbolTwo.isHidden = true
    }
    
    func hideSymbolThree(){
        viewSymbolThree.isHidden = true
    }
    
    func showSymbolOne(){
        viewSymbolOne.isHidden = false
    }
    
    func showSymbolTwo(){
        viewSymbolTwo.isHidden = false
    }
    
    func showSymbolThree(){
        viewSymbolThree.isHidden = false
    }
    

}
