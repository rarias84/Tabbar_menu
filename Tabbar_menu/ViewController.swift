//
//  ViewController.swift
//  Tabbar_menu
//
//  Created by Reinaldo Arias on 2/17/18.
//  Copyright © 2018 Reinaldo Arias. All rights reserved.
//

import UIKit

struct MenuData {
    var icon:UIImage!
    var name:String!
    var bg:UIColor!
    
    init?(icon:UIImage,name:String,bg:UIColor) {
        self.icon = icon
        self.name = name
        self.bg = bg
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    
    let bottomLine = CALayer()
    var items: [MenuData] = []
    var selectedIndexPath: Int = 0 {
        didSet{
            tabBarCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.append(MenuData(icon: UIImage(named:"Girl")!, name: "Girl", bg: UIColor.white)!)
        items.append(MenuData(icon: UIImage(named:"Boy")!, name: "Boy", bg: UIColor.blue)!)
        items.append(MenuData(icon: UIImage(named:"Woman")!, name: "Woman", bg: UIColor.yellow)!)
        items.append(MenuData(icon: UIImage(named:"Man")!, name: "Man", bg: UIColor.green)!)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: tabBarCollectionView.bounds.width / 4, height: tabBarCollectionView.bounds.height)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Tab_Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Tab_Cell
        
        let item = items[indexPath.row]
        cell.configureCell(item)
        
        if indexPath.row == selectedIndexPath {
            bottomLine.frame = CGRect(x: 2.0, y: cell.frame.height - 4, width: (cell.tabBarIcon.image?.size.width)!, height: 4.0)
            bottomLine.backgroundColor = UIColor.red.cgColor
            cell.layer.addSublayer(bottomLine)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        let item = items[indexPath.row]
        view.backgroundColor = item.bg
    }
}

class Tab_Cell: UICollectionViewCell {
    @IBOutlet weak var tabBarIcon: UIImageView!
    @IBOutlet weak var tabBarTitle: UILabel!
    
    func configureCell(_ data: MenuData) {
        tabBarIcon.image = data.icon.withRenderingMode(.alwaysTemplate)
        tabBarTitle.text = data.name
    }
}
