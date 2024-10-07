//
//  UITableView+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.className)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
        register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            preconditionFailure("Cell with identifier \(T.className) not found")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(for section: Int) -> T {
        guard let headerOrFooter = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            preconditionFailure("Header or Footer with identifier \(T.className) not found")
        }
        return headerOrFooter
    }
}
