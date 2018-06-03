//
//  SearchViewController.swift
//  TokoPedia
//
//  Created by Mukesh mac on 02/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift
import JGProgressHUD
class SearchViewController: UIViewController {
    
    @IBOutlet weak var filterBtn: UIButton!
    
    let progressHUD = JGProgressHUD(style: .dark)
    @IBOutlet weak var collectionView: UICollectionView!
    var q = ""
    let rows = "10"
    var start = 0
    var fshop = ""
    var official = true
    var wholesale = true
    var pmax = 80000
    var pmin = 100
    var searchProvider = MoyaProvider<SearchServices>()
    var searchViewModel = SearchViewModel(with: [])
    var total_data: Int?
    var disposeBag = DisposeBag()
    var shopTypes:[ShopType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResult()
        
        filterBtn.rx.controlEvent(.touchUpInside).subscribe { [weak self] (_) in
            guard let strongSelf = self else {return}
            let vc = UIStoryboard.main.instantiate(.filterVC) as! FilterViewController
            
            vc.shops = strongSelf.shopTypes
            vc.maxPrice = Double(strongSelf.pmax)
            vc.minPrice = Double(strongSelf.pmin)
            strongSelf.present(vc, animated: true, completion: nil)
            vc.wholeSale.value = strongSelf.wholesale
            vc.applyBtn.rx.controlEvent(.touchUpInside).subscribe({ (_) in
                vc.dismiss(animated:true , completion: nil)
                strongSelf.pmin = Int(vc.minPrice)
                strongSelf.pmax = Int(vc.maxPrice)
                strongSelf.wholesale = vc.wholeSale.value
                strongSelf.shopTypes = vc.shops
                var official = false
                var fshop = ""
                for shop in vc.shops {
                    if shop.id == 1 {
                        official = true
                    } else if shop.id == 2 {
                        fshop = "2"
                    }
                    
                }
                strongSelf.official = official
                strongSelf.fshop = fshop
                strongSelf.searchViewModel.items = []
                strongSelf.fetchResult()
                
            }).disposed(by: strongSelf.disposeBag)
        }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchResult(){
        progressHUD.show(in: view)
        searchProvider.request(.search(q: q, rows: rows, start: "\(start)", fshop: fshop, official: "\(official)", wholesale: "\(wholesale)", pmax: "\(pmax)", pmin: "\(pmin)")) { [weak self] (result) in
            guard let strongSelf = self else {return}
            strongSelf.progressHUD.dismiss(animated: true)
            switch result {
            case .success(let response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                    guard let jsonObj =  json as? [String: Any], let itemData = jsonObj["data"] as? [[String: Any]] else {return}
//                    print(json)
                    
                    let result = itemData.map({ (item) -> SearchItemViewModel in
                        let name = item["name"] as? String
                        let price = item["price"] as? String
                        let image_uri = item["image_uri"] as? String
                        let image_uri_700 = item["image_uri_700"] as? String
                        return SearchItemViewModel(name: name ?? "", price: price ?? "", image_uri: image_uri ?? "", image_uri_700: image_uri_700 ?? "")
                    })
                    
                    strongSelf.searchViewModel.items.append(contentsOf: result)
                    strongSelf.collectionView.reloadData()
                    
                    if let header = jsonObj["header"] as? [String: Any] {
                        strongSelf.total_data = (header["total_data"] as? Int)
                    }
                    
                    
                } catch {
                    print("\(error.localizedDescription)")
                }
                break
            case .failure(let error):
                
                print("\(error)")
                break
            }
        }
    }
    
    

}



extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! SearchViewCell
        cell.configure(withViewModel: searchViewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-20)/2 - 2
        return CGSize(width: width, height: 255)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == searchViewModel.items.count {
            if searchViewModel.items.count < (total_data ?? 0) {
                start += 10
                fetchResult()
            }
            
        }
    }
    
    
    
}
