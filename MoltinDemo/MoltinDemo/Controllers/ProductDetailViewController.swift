//
//  ProductDetailViewController.swift
//  MoltinDemo
//
//  Created by Rahul  Belekar on 30/04/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import moltin

class ProductDetailViewController: UIViewController {
    
    var product: Product!
    
    @IBOutlet private weak var titleTxt: UILabel?
    @IBOutlet private weak var descTxt: UITextView?
    @IBOutlet private weak var priceTxt: UILabel?
    
    @IBOutlet private weak var coverImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descTxt?.setContentOffset(.zero, animated: false)
    }
    
    //MARK:- Methods
    func updateUI() {
        titleTxt?.text = product.name
        descTxt?.text = product.description
        if let price = product.price?[0] {
            priceTxt?.text = "\(price.currency) \(price.amount)".addDecimalPoint()
        }
    }
    
    //MARK:- Actions
    @IBAction func addToCart() {
        moltin.cart.addProduct(withID: product.id, ofQuantity: 1, toCart: "77777") { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print("Got error adding a product to the cart: \(error)")
            }
        }
    }

}
