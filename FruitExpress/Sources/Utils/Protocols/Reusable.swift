//
//  Reusable.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 14.08.2024.
//

import UIKit

public typealias NibReusable = Reusable & NibLoadable

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

public extension NibLoadable where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self.classForCoder()))
    }
    static func nib(bundle: Bundle) -> UINib {
        return UINib(nibName: String(describing: self), bundle: bundle)
    }
}

public extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        
        return view
    }
    
    static func loadFromNib(bundle: Bundle) -> Self {
        guard let view = nib(bundle: bundle).instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        
        return view
    }
}
