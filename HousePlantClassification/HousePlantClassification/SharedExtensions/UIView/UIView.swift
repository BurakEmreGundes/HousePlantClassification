//
//  UIView.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 2.12.2022.
//

import Foundation
import UIKit


extension UIView {
    
    static let defaultCornerRadius: CGFloat = 12
    
    func addVerticalSpacingConstraint(bottomView: UIView, topView: UIView, spacing: CGFloat) {
        let constraint = NSLayoutConstraint(item: bottomView,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: topView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: spacing)
        constraint.isActive = true
        addConstraint(constraint)
    }
    
    func rotateWithinForRTL(_ view: UIView) {
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft {
            view.transform = CGAffineTransform(rotationAngle: .pi)
        } else {
            view.transform = CGAffineTransform.identity
        }
    }
    
    /// Traverses subviews recursively with breadth first search, returns the first subview that
    /// satisfies the predicate.
    func firstSubview(where predicate: (UIView) -> Bool) -> UIView? {
        var subviewsToTraverse = subviews
        
        while subviewsToTraverse.count > 0 {
            guard !predicate(subviewsToTraverse[0]) else {
                return subviewsToTraverse[0]
            }
            subviewsToTraverse.append(contentsOf: subviewsToTraverse[0].subviews)
            subviewsToTraverse.remove(at: 0)
        }
        
        return nil
    }
    
    
    /// Traverses subviews recursively with breadth first search, returns all subviews that
    /// satisfy the predicate.
    func subviews(where predicate: (UIView) -> Bool) -> [UIView] {
        var subviewsToTraverse = subviews
        var matchingSubviews = [UIView]()
        
        while subviewsToTraverse.count > 0 {
            let currentSubview = subviewsToTraverse[0]
            
            if predicate(currentSubview) {
                matchingSubviews.append(currentSubview)
            }
            
            subviewsToTraverse.append(contentsOf: currentSubview.subviews)
            subviewsToTraverse.remove(at: 0)
        }
        
        return matchingSubviews
    }
    
    func subviews(where predicate: (UIView, String) -> Bool, id: String) -> [UIView] {
        var subviewsToTraverse = subviews
        var matchingSubviews = [UIView]()
        
        while subviewsToTraverse.count > 0 {
            let currentSubview = subviewsToTraverse[0]
            
            if predicate(currentSubview, id) {
                matchingSubviews.append(currentSubview)
            }
            
            subviewsToTraverse.append(contentsOf: currentSubview.subviews)
            subviewsToTraverse.remove(at: 0)
        }
        
        return matchingSubviews
    }
    
    /// Traverses subviews recursively with breadth first search, returns all subviews that
    /// are of the specified UIView subclass.
    func subviews<T>(type: T.Type) -> [T] {
        var subviewsToTraverse = subviews
        var matchingSubviews = [T]()
        
        while subviewsToTraverse.count > 0 {
            let currentSubview = subviewsToTraverse[0]
            
            if let casted = currentSubview as? T {
                matchingSubviews.append(casted)
            }
            
            subviewsToTraverse.append(contentsOf: currentSubview.subviews)
            subviewsToTraverse.remove(at: 0)
        }
        
        return matchingSubviews
    }
    
    /// Applies the method on each subview with type T.
    func applyOnSubviews<T>(method: (T) -> Void) {
        var subviewsToTraverse = subviews
        
        while subviewsToTraverse.count > 0 {
            let currentSubview = subviewsToTraverse[0]
            
            if let casted = currentSubview as? T {
                method(casted)
            }
            
            subviewsToTraverse.append(contentsOf: currentSubview.subviews)
            subviewsToTraverse.remove(at: 0)
        }
    }
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        var borderTags = [Int]()
        // removeProgramaticallyAddedBorders() won't work if the same border is added more than once
        // because of this logic, tags constantly increment but the removing method only checks first 4 (4 for 4 corners)
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            border.tag = borderTags.last ?? 13371
            borderTags.append(border.tag)
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
    /// HACK ALERT: This won't work if the same border is added more than once to this view.
    func removeProgramaticallyAddedBorders() {
        subviews.lazy
            .filter { $0.tag > 13370 && $0.tag < 13375 }
            .forEach { $0.removeFromSuperview() }
    }
    
    func fix(in container: UIView, offset: CGFloat = 0, shouldAddAsSubview: Bool = true) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        if shouldAddAsSubview {
            self.frame = container.frame
            container.addSubview(self)
        }
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: offset).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -offset).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: offset).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: -offset).isActive = true
    }
    
    func fix(in container: UIView, verticalOffset: CGFloat, horizontalOffset: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: horizontalOffset).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -horizontalOffset).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: verticalOffset).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: -verticalOffset).isActive = true
    }
    
    
    func makeZeplinShadow(color: UIColor, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 0, spread: CGFloat = 0, opacity: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = Float(opacity)
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        if spread == 0 {
            layer.shadowPath = nil
        }
        else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}
