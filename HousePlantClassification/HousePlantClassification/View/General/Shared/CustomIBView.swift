//
//  CustomIBView.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 2.12.2022.
//

import Foundation
import UIKit


protocol CustomIBView: UIView {
    var contentView: UIView! { get }
    var nibName: String { get }
    func commonInit()
    func postInit()
}

extension CustomIBView {
    func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        contentView?.fix(in: self)
        postInit()
    }
    
    func alternativeCommonInitForIBDesignable() {
        let bundle = Bundle(for: Self.self)
        bundle.loadNibNamed(nibName, owner: self, options: nil)
        contentView?.fix(in: self)
        postInit()
    }
    
    var nibName: String {
        let baseStr = String(reflecting: type(of: self))
        return baseStr.replacingOccurrences(of: "Carla.", with: "")
    }
    
    func postInit() { }
}
