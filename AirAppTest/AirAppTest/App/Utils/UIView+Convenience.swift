//
//  UIView+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

extension UIView {
    
    private static let defaultEdgeInsets: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0
    )
    
    enum SafeAreaLayoutEdges: CaseIterable {
        case top
        case leading
        case trailing
        case bottom
    }
    
    func addSubviewAndPinToEdges(
        _ view: UIView,
        padding: UIEdgeInsets = defaultEdgeInsets,
        safeAreaLayoutEdges: [SafeAreaLayoutEdges] = []
    ) {
        
        var leadingAnchor = self.leadingAnchor
        var topAnchor = self.topAnchor
        var trailingAnchor = self.trailingAnchor
        var bottomAnchor = self.bottomAnchor
        
        safeAreaLayoutEdges.forEach {
            switch $0 {
            case .top:
                topAnchor = safeAreaLayoutGuide.topAnchor
                
            case .leading:
                leadingAnchor = safeAreaLayoutGuide.leadingAnchor
                
            case .trailing:
                trailingAnchor = safeAreaLayoutGuide.trailingAnchor
                
            case .bottom:
                bottomAnchor = safeAreaLayoutGuide.bottomAnchor
            }
        }
        
        addSubview(view, constraints: [
            view.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding.left
            ),
            view.topAnchor.constraint(
                equalTo: topAnchor,
                constant: padding.top
            ),
            view.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding.right
            ),
            view.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -padding.bottom
            )
        ])
    }
    
    func addSubview(
        _ view: UIView,
        constraints: [NSLayoutConstraint]
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate(constraints)
    }
}
