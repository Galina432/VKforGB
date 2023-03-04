//
//  NewsTableViewCell4.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 15.01.2023.
//

import UIKit

class NewsTableViewCell4: UITableViewCell {

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

//    func setToFour(viewModel: FeedCellViewModel) {
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comments
//        repostLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//    }
    
}
