//
//  UIViewController-EXT.swift
//  GitFollower
//
//  Created by Ali Jafarov on 27.05.22.
//

import UIKit
import SafariServices


fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlert(title: String, message: String, buttonTitle: String ) {
        DispatchQueue.main.async {
            let alert = GFAlertViewController(title: title, message: message, button: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoadingView() {
        containerView  = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        view.addSubview(containerView)
        containerView.alpha = 0
        UIView.animate(withDuration: 0.30) { containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyState(for message: String, for view: UIView){
        let emptyStatusView = GFEmptyStatusView(message: message)
        emptyStatusView.frame = view.bounds
        view.addSubview(emptyStatusView)
        
    }
    
    func presentSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
        
    }
    
}
