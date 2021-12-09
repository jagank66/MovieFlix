//
//  MovieDetailsVC.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import UIKit

class MovieDetailsVC: UIViewController {
    var result: Result?
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let posterpath = result?.posterPath,
           let title = result?.title,
           let overView = result?.overview,
           let releaseDate = result?.releaseDate,
           let voteAvg = result?.voteAverage {
            bannerImage.imageFromUrl(urlString: Apis.posterImage+posterpath)
            titleLabel.text = title
            descriptionLabel.text = overView
            releaseDateLabel.text = "Release Date:  \(releaseDate)"
            ratingLabel.text = "Rating:- \(voteAvg)"
        }
    }
    
    @IBAction func ontapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
