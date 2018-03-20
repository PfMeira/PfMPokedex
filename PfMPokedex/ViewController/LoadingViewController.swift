//
//  LoadingViewController.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 12/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import Alamofire

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadActivityIndicator.startAnimating()
        loadActivityIndicator.isHidden = false
        NetworkManager.sharedNetworkManager.delegateNetwork = self

        self.navigationController?.isNavigationBarHidden = true
    }
}

extension LoadingViewController: NetworkReachabilityDelegate {
    
    func isReachability(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .notReachable, .unknown:
            print("")
        default:
            //dismiss
            print("Dismiss")
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.isNavigationBarHidden = false
            dismiss(animated: true, completion: nil)
        }
    }
}
