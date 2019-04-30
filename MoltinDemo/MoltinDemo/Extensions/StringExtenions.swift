//
//  StringExtenions.swift
//  MoltinDemo
//
//  Created by Rahul  Belekar on 30/04/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit

extension String {
    func addDecimalPoint() -> String {
        var str = self
        str.insert(".", at: str.index(str.endIndex, offsetBy: -2))
        return str
    }
}
