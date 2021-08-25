//
//  HomeViewController.swift
//  SideMenu
//
//  Created by Fabiana Petrovick on 24/08/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit
//controlador de visualizacao inicial e estendera qualquer objeto e tera uma unica

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}
class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
