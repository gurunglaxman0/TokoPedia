//
//  ShopTypeViewController.swift
//  TokoPedia
//
//  Created by Mukesh mac on 03/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import UIKit

class ShopTypeViewController: UIViewController {
    
    @IBOutlet weak var applyBtn: UIButton!
    let shops =  [ShopType(id: 2, name: "Gold Merchant"), ShopType(id:1, name: "Official Store")]
    var selectedItems: [ShopType] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for item in selectedItems {
            let index = shops.index { (current) -> Bool in
                return item.id == current.id
            }
            if let index = index {
                tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .bottom)
            }
            
        }
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onReset(_ sender: Any) {
        guard let selectedItems = tableView.indexPathsForSelectedRows else {return}
        for indexPath in selectedItems {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}



extension ShopTypeViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ShopTypeCell
        let item = shops[indexPath.item]
        cell.nameLabel.text = item.name
        
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}


class ShopTypeCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            checkImage.image = isSelected ? UIImage(named: "check-box-checked") : UIImage(named: "check-box-empty")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkImage.image = selected ? UIImage(named: "check-box-checked") : UIImage(named: "check-box-empty")
    }
}
