//
//  ProductTableViewCell.swift
//  MoltinDemo
//
//  Created by Rahul  Belekar on 30/04/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import moltin

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleTxt: UILabel?
    @IBOutlet private weak var descTxt: UILabel?
    @IBOutlet private weak var priceTxt: UILabel?
    @IBOutlet private weak var quantity: UILabel?
    
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
        titleTxt?.text = product?.name
        descTxt?.text = product?.description
        if let price = product?.price?[0] {
            priceTxt?.text = "\(price.currency) \(price.amount)".addDecimalPoint()
        }
    }
    
    func updateValues(cartItem: CartItem?) {
        titleTxt?.text = cartItem?.name
        descTxt?.text = cartItem?.description
        quantity?.text = "Quantity: \(cartItem?.quantity ?? 0)"
        if let price = cartItem?.value {
            priceTxt?.text = "\(price.currency) \(price.amount)".addDecimalPoint()
        }
    }

}
