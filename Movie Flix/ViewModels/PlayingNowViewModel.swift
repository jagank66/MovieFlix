//
//  PlayingNowViewModel.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import Foundation
import UIKit

protocol PlayingNowViewModelProtocal: AnyObject {
    func onSucess()
    func apifailure(error: String)
    func failure(error: String)
    func onTapDelete(indexPath: IndexPath)
}

class PlayingNowViewModel {
    weak var delegate: PlayingNowViewModelProtocal?
    var searchdata: [Result] = []
    var results: [Result] = []
    
    var searchText: String? {
        didSet {
            searchPerform()
        }
    }
    
   
    func searchPerform() {
        if let text = searchText, text.count > 0 {
            results = searchdata.filter{$0.title.lowercased().contains(text.lowercased())}
            self.delegate?.onSucess()
        } else {
            
            results = searchdata
            self.delegate?.onSucess()
        }
    }
    
    func callingGetApi() {
        NetworkManager.shared().request(Apis.playingNow, PlayingNow.self) { [weak self] response in
            switch response {
            case .sucess(value: let playing):
                if let items = playing as? PlayingNow {
                    self?.results = items.results
                    self?.searchdata = items.results
                    self?.delegate?.onSucess()
                }
                break
            case .Apifaile( let failure):
                if let error = failure as? String {
                    self?.delegate?.apifailure(error: error)
                }
                break
            case .error(value: let error):
                if let error = error as? String {
                    self?.delegate?.failure(error: error)
                }
                break
            }
        }
    }
}

extension PlayingNowViewModel {
    func presentCell(collectionView: UICollectionView, indexpath: IndexPath) -> UICollectionViewCell? {
        if results[indexpath.row].voteAverage > 7 {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: PopularMoviesCell.identifer, for: indexpath) as! PopularMoviesCell
            cell.deleteButton.tag = indexpath.row
            cell.loadData(result: results[indexpath.row])
            cell.deleteButton.addTarget(self, action: #selector(onTapDelete(_:)), for: .touchUpInside)
            return cell
        }
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: UnPopularMoviesCell.identifer, for: indexpath) as! UnPopularMoviesCell
        cell.deleteButton.tag = indexpath.row
        cell.deleteButton.addTarget(self, action: #selector(onTapDelete(_:)), for: .touchUpInside)
        cell.loaddata(result: results[indexpath.row])
        return cell
    }
    
    @objc func onTapDelete(_ sender: UIButton) {
        searchdata.remove(at: sender.tag)
        results.remove(at: sender.tag)
        self.delegate?.onTapDelete(indexPath: IndexPath(item: sender.tag, section: 0))
    }
}
