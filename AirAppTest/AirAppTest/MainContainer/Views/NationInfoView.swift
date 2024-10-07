//
//  NationInfoView.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

final class NationInfoView: UIView {
    private enum Constants {
        
        enum MainStack {
            static let paddingValue: CGFloat = 8
        }
    }
    
    private var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = 8
        return mainStackView
    }()
    
    private var nationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24)
        return titleLabel
    }()
    
    private var populationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .systemGray
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private var yearLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .systemGray
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .right
        return titleLabel
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with info: NationInfo) {
        nationLabel.text = info.nation
        populationLabel.text = info.population
        yearLabel.text = info.year
    }
}

private extension NationInfoView {
    private func setupViews() {
        addSubviewAndPinToEdges(
            mainStackView,
            padding: .all(value: Constants.MainStack.paddingValue)
        )
        
        mainStackView.addArrangedSubview(nationLabel)
        mainStackView.addArrangedSubview(populationLabel)
        mainStackView.addArrangedSubview(yearLabel)
    }
}
