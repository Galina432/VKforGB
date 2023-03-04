//
//  ExtensionUIImage.swift
//  L2.1_SavitskayaGalina
//
//  Created by emil kurbanov on 11.08.2022.
//

import UIKit

// загурзка картинок по URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

