//
//  NewsTableViewCell1.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 22.10.2022.
//

import UIKit

class NewsTableViewCell1: UITableViewCell {
    
    @IBOutlet weak var newsAvatarPost: UIImageView!
    @IBOutlet weak var newsNamePost: UILabel!
    @IBOutlet weak var newsDatePost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsAvatarPost.layer.cornerRadius = newsAvatarPost.bounds.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

