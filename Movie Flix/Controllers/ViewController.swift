//
//  ViewController.swift
//  Movie Flix
//
//  Created by apple on 08/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noDatalabel: UILabel!

    var viewModel = PlayingNowViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        activityView.startAnimating()
        viewModel.callingGetApi()
        setUpCollectionView()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .allEvents)
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayOut()
        collectionView.register(["PopularMoviesCell","UnPopularMoviesCell"])
    }
    
    private func createLayOut() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {[weak self]  (section,_ ) -> NSCollectionLayoutSection? in
           return self?.collectionView.cardView()
        }
    }
}

extension ViewController: PlayingNowViewModelProtocal {
    func onTapDelete(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func onSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.hidingViews()
        }
    }
    
    func apifailure(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.hidingViews()
            self?.presentAlert(error)
        }
    }
    
    func failure(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.hidingViews()
            self?.presentAlert(error)
        }
    }
    
    func hidingViews() {
        self.activityView.stopAnimating()
        if viewModel.results.count == 0 {
            collectionView.isHidden = true
            noDatalabel.isHidden = false
        } else {
            collectionView.isHidden = false
            collectionView.reloadData()
            noDatalabel.isHidden = true
        }
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = viewModel.presentCell(collectionView: collectionView, indexpath: indexPath) {
            return cell
        }
        return UICollectionViewCell()
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems else {return}
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC {
            controller.result = viewModel.results[selectedIndex[0].row]
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension ViewController {
    @objc func textFieldDidChange(sender: UITextField) {
        performSearch(sender.text)
    }
    
    private func performSearch(_ text: String?) {
        if let searchText = text {
            viewModel.searchText = searchText
        }
    }
}
