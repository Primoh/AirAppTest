//
//  PopulationInfoCell.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

final class PopulationInfoCell: UITableViewCell {
    
    private enum Constants {
        enum ContainerView {
            static let paddingValue: CGFloat = 4
        }
    }
    
    private var containerView: StateInfoView = {
        let containerView = StateInfoView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray3.cgColor
        return containerView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.clean()
    }
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        isUserInteractionEnabled = false
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

private extension PopulationInfoCell {
    private func setupViews() {
        contentView.addSubviewAndPinToEdges(
            containerView,
            padding: .all(value: Constants.ContainerView.paddingValue)
        )
    }
}
