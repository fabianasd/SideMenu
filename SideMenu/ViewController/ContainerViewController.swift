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
    //mexer o titulo
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self //atribui o menu delegate ao self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        // mexer o titulo
        self.navVC = navVC
        
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        // animate the menu
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                //com navVC? o list.dash move junto com o menu...com homeVC apenas o menus se move, e o list.dash fica fixo em cima
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            // close it, volta o menu para o canto
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async { //chamar na thread principal
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        
        //para retirar o toque em qualquer lugar da tela o codigo abaixo foi comentado
        //        toggleMenu { [weak self] in //captura o self fraco e o que queremos para ir em frente
        toggleMenu(completion: nil)
        switch menuItem {
        case .home:
            //            self?.resetToHome()
            self.resetToHome()
        case .info:
            //Add infor child
            //            self?.addInfo()
            self.addInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .settings:
            break
            // }
        }
    }
    
    func addInfo() {
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title //atribuir titulo Aboute This App
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
}
