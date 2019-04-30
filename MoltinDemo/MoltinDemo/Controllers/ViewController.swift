//
//  ViewController.swift
//  MoltinDemo
//
//  Created by Rahul  Belekar on 30/04/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import moltin

class ViewController: UIViewController {
    
    private var products: [Product]?
    private var selectedIdx: Int = -1
    
    @IBOutlet private weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestProducts()
    }
    
    //MARK:- Methods
    func requestProducts() {
        moltin.product.all { (result) in
            switch result {
            case .success(let response):
                self.products = response.data
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            case .failure(let error):
                print("Got failure: \(error)")
            }
        }
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToProductDetails" && selectedIdx != -1 {
            (segue.destination as? ProductDetailViewController)?.product = products?[selectedIdx]
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! ProductTableViewCell
        cell.updateValues(product: products?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        self.performSegue(withIdentifier: "ToProductDetails", sender: nil)
    }

}

