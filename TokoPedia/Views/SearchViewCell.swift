//
//  SearchViewCell.swift
//  TokoPedia
//
//  Created by Mukesh mac on 04/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImgView.layer.cornerRadius = 5
        thumbImgView.layer.masksToBounds = true
    }
    
    func configure(withViewModel viewModel: SearchItemPresentable){
        self.nameLabel.text = viewModel.name
        self.priceLabel.text = viewModel.price
        thumbImgView.sd_setImage(with: URL(string: viewModel.image_uri_700), placeholderImage: #imageLiteral(resourceName: "thumb"))
    }
}
