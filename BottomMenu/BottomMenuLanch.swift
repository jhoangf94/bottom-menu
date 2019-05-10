//
//  BottomMenuLanch.swift
//  BottomMenu
//
//  Created by Developer2 on 17/04/19.
//  Copyright © 2019 jhoanDevelover. All rights reserved.
//

import UIKit

struct Item {
    let name:String
    let iconName:String
}

class ItemMenuCell: UITableViewCell {
    
    var item:Item! {
        didSet{
            nameLabel.text = item.name
            if let icon = UIImage(named: item.iconName) {
                imgViewIcon.image = icon
            }
        }
    }
    
    let nameLabel = UILabel()
    let imgViewIcon:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override func layoutSubviews() {
//        contentView.backgroundColor = .black
        // Adds views
        contentView.addSubview(nameLabel)
        contentView.addSubview(imgViewIcon)
        
        // Habilitar la modificacion de las constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imgViewIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        let constraints = [
            imgViewIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgViewIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgViewIcon.heightAnchor.constraint(equalToConstant: 16),
            imgViewIcon.widthAnchor.constraint(equalToConstant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imgViewIcon.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ]
        // se activan las constraints
        contentView.addConstraints(constraints)
    }
}

class BottomMenuLaunch: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    let heightRow:CGFloat = 70
    
    
    let itemsMenu:[Item] = {
        return [
            Item(name: "Settings",      iconName: "settings"),
            Item(name: "Account",       iconName: "account"),
            Item(name: "Notifications", iconName: "notifications"),
            Item(name: "Close",         iconName: "close")]
    }()
    
    let backgroundviewalpha: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return v
    }()
    
    let tableView:UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        t.isScrollEnabled = false
        t.allowsMultipleSelection = false
        return t
    }()
    
    override init() {
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemMenuCell.self, forCellReuseIdentifier: cellId)
    }
    
    func showBottomMenu(){
        
        if let window = UIApplication.shared.keyWindow {
            
            // setup bacground view
            backgroundviewalpha.frame = window.frame
            let tapGesture = UITapGestureRecognizer()
            tapGesture.addTarget(self, action: #selector(backgroundviewalphaTapped))
            backgroundviewalpha.addGestureRecognizer(tapGesture)
            
            window.addSubview(backgroundviewalpha)
            window.addSubview(tableView)
            
            let height:CGFloat = CGFloat(itemsMenu.count) * heightRow
            let y = window.frame.height - height
            tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            tableView.backgroundColor = .white
    
            // animation backgroundviewalpha
            backgroundviewalpha.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.backgroundviewalpha.alpha = 1
                self.tableView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }
            
        }
    }
    
    @objc func backgroundviewalphaTapped() {
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundviewalpha.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.tableView.frame = CGRect(x: 0, y: window.frame.height, width: self.tableView.frame.width, height: self.tableView.frame.height)
            }
        }
        
    }
    
    // MARK: Datasource y Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return itemsMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ItemMenuCell
        let item = itemsMenu[indexPath.row]
        cell.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemTapped = itemsMenu[indexPath.row]
        
        if itemTapped.name == "Close" {
            backgroundviewalphaTapped()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
