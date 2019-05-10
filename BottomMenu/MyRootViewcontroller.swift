//
//  ViewController.swift
//  BottomMenu
//
//  Created by Developer2 on 17/04/19.
//  Copyright © 2019 jhoanDevelover. All rights reserved.
//

import UIKit

class MyRootViewcontroller: UIViewController {

    var navMenu: UIBarButtonItem = {
        let icon = UIImage(named: "menu_vertical")?.withRenderingMode(.alwaysTemplate)
        let navItem = UIBarButtonItem(image: icon, style: .plain, target: self , action: #selector(handleMenu))
        navItem.tintColor = .black
        return navItem
    }()
    
    let tapHereLabel: UILabel = {
        let l = UILabel()
        l.text = "Da tap sobre el icono de 3 puntos en la barra de naviagción"
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textAlignment = .center
        return l
    }()
    
     let bottomMenuLaunch = BottomMenuLaunch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navMenu.target = self
        navMenu.action = #selector(handleMenu)
        navigationItem.rightBarButtonItem = navMenu
        navigationItem.title = "Bottom Menu 😊"
        
        view.addSubview(tapHereLabel)
        
        tapHereLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            tapHereLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapHereLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tapHereLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tapHereLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        view.addConstraints(constraints)
        
    }
    
   
    
    @objc func handleMenu(){
        bottomMenuLaunch.showBottomMenu()
    }



}

