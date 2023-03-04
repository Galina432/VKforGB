//
//  NewsTableViewCell2.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 23.10.2022.
//

import UIKit

class NewsTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var buttonText: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func buttonTextFull(_ sender: UIButton) {
        self.postLabel.numberOfLines = 0
        self.buttonText.isHidden = true
    }
}
