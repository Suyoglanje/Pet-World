//
//  ViewController.swift
//  Pet World
//
//  Created by Suyog Lanje on 14/07/25.
//

import UIKit

class ViewController: LoginViewController{
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedVC = FeedViewController()
        navigationController?.pushViewController(feedVC, animated: true)
        setupUI()
    }
}

