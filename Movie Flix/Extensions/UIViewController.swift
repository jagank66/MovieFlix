//
//  UIViewController.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import UIKit

extension ViewController {
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title:"Alert🚫", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
