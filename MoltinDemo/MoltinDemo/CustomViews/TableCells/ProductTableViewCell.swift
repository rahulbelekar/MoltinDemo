//
//  ProductTableViewCell.swift
//  MoltinDemo
//
//  Created by Rahul  Belekar on 30/04/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import moltin
import Nuke

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleTxt: UILabel?
    @IBOutlet private weak var descTxt: UILabel?
    @IBOutlet private weak var priceTxt: UILabel?
    
    @IBOutlet private weak var coverImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateValues(product: Product?) {
        if let imageData = product?.mainImage, let url = URL(string: imageData.link[""] ?? "") {
            Nuke.loadImage(with: url, options: ImageLoadingOptions.shared, into: coverImg, progress: nil) { (imgResponse, imgError) in
                
            }
        }
        titleTxt?.text = product?.name
        descTxt?.text = product?.description
        if let price = product?.price?[0] {
            priceTxt?.text = "\(price.currency) \(price.amount)"
        }
    }

}
