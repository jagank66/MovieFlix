//
//  UnPopularMoviesCell.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import UIKit
import Alamofire

class UnPopularMoviesCell: UICollectionViewCell {
    static let identifer: String = "UnPopularMoviesCell"
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var originalLangauge: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func loaddata(result: Result) {
        titleLabel.text = result.title
        originalTitle.text = result.originalTitle
        originalLangauge.text = "Langauge: \(result.originalLanguage)"
        releaseDate.text = result.releaseDate
        bannerImage.imageFromUrl(urlString: Apis.posterImage+result.posterPath)
    }
    
}
