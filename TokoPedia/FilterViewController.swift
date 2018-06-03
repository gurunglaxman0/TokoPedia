//
//  FilterViewController.swift
//  TokoPedia
//
//  Created by Mukesh mac on 03/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

typealias ShopType = (id: Int, name: String)

class FilterViewController: UIViewController {

    @IBOutlet weak var shopTypeCollectionView: UICollectionView!
    @IBOutlet weak var shopTypeHolderView: UIView!
    var shops: [ShopType] = []
   
    @IBOutlet weak var minimumPriceLbl: UILabel!
    @IBOutlet weak var maxPriceLbl: UILabel!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var wholeSaleSwitch: UISwitch!
    @IBOutlet weak var applyBtn: UIButton!
    
    var disposeBag = DisposeBag()
    var wholeSale = Variable<Bool>(false)
    
    var maxPrice: Double = 80000
    var minPrice: Double = 100
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapShopType))
        tapGesture.numberOfTapsRequired = 1
        shopTypeHolderView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
//        rangeSlider.rx.
        wholeSaleSwitch.rx.isOn.bind(onNext: { (wholeSale) in
            print("\(wholeSale)")
        }).disposed(by: disposeBag)
        
        wholeSaleSwitch.rx.isOn.bind(to: wholeSale).disposed(by: disposeBag)
        rangeSlider.maximumValue = 100000
        rangeSlider.minimumValue = 100
        
        rangeSlider.lowerValue = minPrice
        rangeSlider.upperValue = maxPrice
        
        minimumPriceLbl.text = "Rp \(Int(minPrice))"
        maxPriceLbl.text = "Rp \(Int(maxPrice))"
        wholeSale.asObservable().bind(to: wholeSaleSwitch.rx.isOn).disposed(by: disposeBag)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onReset(_ sender: Any) {
        wholeSale.value = false
        rangeSlider.lowerValue = 100
        rangeSlider.upperValue = 80000
        shops = []
        shopTypeCollectionView.reloadData()
    }
    
    
    
    @IBAction func onTapShopType(_ sender: UITapGestureRecognizer){
        let vc = UIStoryboard.main.instantiate(.shopTypeVC) as! ShopTypeViewController
        vc.selectedItems = shops
            present(vc, animated: true, completion: nil)
        _ = vc.applyBtn.rx.controlEvent(UIControlEvents.touchUpInside).bind { [weak self] (_) in
            guard let indexPaths = vc.tableView.indexPathsForSelectedRows else {return}
            self?.shops = []
            for indexPath in indexPaths {
                self?.shops.append(vc.shops[indexPath.item])
            }
            
            self?.shopTypeCollectionView.reloadData()
            vc.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        minPrice = rangeSlider.lowerValue
        maxPrice = rangeSlider.upperValue
        minimumPriceLbl.text = "Rp \(Int(rangeSlider.lowerValue))"
        maxPriceLbl.text = "Rp \(Int(rangeSlider.upperValue))"
    }
    

}

extension FilterViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellTagId", for: indexPath) as! TagCell
        cell.titleLabel.text = shops[indexPath.item].name
        cell.onRemvoeAction = { [weak self] in
            self?.shops.remove(at: indexPath.item)
            self?.shopTypeCollectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

class TagCell: UICollectionViewCell {
    @IBOutlet weak var borderImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    var onRemvoeAction:(()->(Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderImg.layer.cornerRadius = 15
        borderImg.layer.masksToBounds = true
        borderImg.layer.borderColor = UIColor.black.cgColor
        borderImg.layer.borderWidth = 1
    }
    
    @IBAction func onRemove(_ sender: Any) {
        onRemvoeAction?()
    }
    
}
