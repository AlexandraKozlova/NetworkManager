//
//  ViewController.swift
//  Movies
//
//  Created by Aleksandra on 08.12.2022.
//

import UIKit
import SafariServices

extension UIViewController {
    // MARK: - Alert
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            let okayAction = UIAlertAction(title: buttonTitle, style: .cancel)
            alertVC.addAction(okayAction)
            self.present(alertVC, animated: true)
        }
    }
    
    // MARK: - Safari
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
