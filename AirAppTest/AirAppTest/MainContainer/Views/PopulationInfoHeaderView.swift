//
//  PopulationInfoHeaderView.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

final class PopulationInfoHeaderView: UITableViewHeaderFooterView {
    
    private enum Constants {
        enum ContainerView {
            static let paddingValue: CGFloat = 4
        }
    }
    
    private var containerView: StateInfoView = {
        let containerView = StateInfoView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemGray6
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.systemGray3.cgColor
        return containerView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(
        title: String,
        info: String
    ) {
        containerView.configure(
            title: title,
            info: info
        )
    }
}

private extension PopulationInfoHeaderView {
    private func setupViews() {
        contentView.addSubviewAndPinToEdges(
            containerView,
            padding: .all(value: Constants.ContainerView.paddingValue)
        )
    }
}
