//
//  NewsfeedViewController.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 15.01.2023.
//

import UIKit

class NewsfeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NewsfeedService().loadData { data in
            NewsfeedService().parse(data: data) { news in
                print(news)
            }
        }
    }
}

extension NewsfeedViewController {
    func reloadData() {
        
        tableView.reloadData()
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        
        if indexPath.row == 0 { return 40 }
        else if indexPath.row == 1 { return 110 }
        else if indexPath.row == 2 { return 150 }
        else { return 40 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell1", for: indexPath) as! NewsTableViewCell1
            
            //            let object = topPost[indexPath.row]
            //            cell.set(object: object)
            cell.newsAvatarPost.image = UIImage(named: "alba")
            cell.newsNamePost.text = "Petrova Anastasia"
            cell.newsDatePost.text = "16/01/2023"
            
            return cell
        }
        
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell2", for: indexPath) as! NewsTableViewCell2
            
            cell.postLabel.text = "Сегодня 15 января 2023 года(1 из 4). Сегодня 15 января 2023 года(2 из 4). Сегодня 15 января 2023 года(3 из 4). Сегодня 15 января 2023 года(4 из 4)."
            return cell
        }
        
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell3", for: indexPath) as! NewsTableViewCell3
            
            cell.postImage.image = UIImage(named: "alba2")
            
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell4", for: indexPath) as! NewsTableViewCell4
            
            cell.likesLabel.text = "5"
            cell.commentsLabel.text = "4"
            cell.repostLabel.text = "1"
            cell.viewsLabel.text = "25"
            
            return cell
        }
    }
    
}
