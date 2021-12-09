//
//  UIImageView.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import UIKit
import Alamofire

extension UIImageView {
    
    public func imageFromUrl(urlString: String) {
        AF.request(urlString).response { [weak self] (data) in
            guard let data = data.data else {return}
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
    }
}
