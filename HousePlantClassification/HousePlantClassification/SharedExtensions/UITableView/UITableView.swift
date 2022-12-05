//
//  UITableView.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 2.12.2022.
//

import Foundation

import UIKit

extension UITableView {
    func register(with commonId: String) {
        register(UINib(nibName: commonId, bundle: nil), forCellReuseIdentifier: commonId)
    }
}

