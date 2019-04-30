//
//  CartViewController.swift
//  MoltinDemo
//
//  Created by Rahul  Belekar on 30/04/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import moltin

class CartViewController: UIViewController {
    
    private var items: [CartItem]?
    
    @IBOutlet private weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCart()
        self.title = "Cart"
    }
    
    //MARK:- Methods
    func fetchCart() {
        moltin.cart.items(forCartID: "77777") { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.items = response.data
                DispatchQueue.main.async { [weak self] in
                    self?.tableView?.reloadData()
                }
            case .failure(let error):
                print("Got failure: \(error)")
            }
        }
    }
    
    func removeCartItem(id: String) {
        moltin.cart.removeItem(id, fromCart: "77777") { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.items = response
                DispatchQueue.main.async { [weak self] in
                    self?.tableView?.reloadData()
                }
            case .failure(let error):
                print("Got failure: \(error)")
            }
        }
    }

}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItem", for: indexPath) as! ProductTableViewCell
        cell.updateValues(cartItem: items?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ID = items?[indexPath.row].id ?? ""
            removeCartItem(id: ID)
        }
    }
}
