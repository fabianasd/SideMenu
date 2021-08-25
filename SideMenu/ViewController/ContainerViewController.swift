//
//  ContainerViewController.swift
//  SideMenu
//
//  Created by Fabiana Petrovick on 24/08/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        // animate the menu
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.homeVC.view.frame.origin.x = self.homeVC.view.frame.size.with - 100
            } completion: { done in
                if done {
                    
                }
            }
        case .opened:
            // close it
            break
        }
    }
}

