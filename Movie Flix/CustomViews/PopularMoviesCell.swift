//
//  PlayingNowCell.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import UIKit

class PopularMoviesCell: UICollectionViewCell {
    static let identifer: String = "PopularMoviesCell"
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func loadData(result: Result) {
        bannerImage.imageFromUrl(urlString: Apis.posterImage+result.posterPath)
    }

}
