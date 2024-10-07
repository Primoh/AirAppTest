//
//  StateInfoView.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

final class StateInfoView: UIView {
    
    private enum Constants {
        enum MainStack {
            static let paddingValue: CGFloat = 12
        }
    }
    
    private var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .horizontal
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = 8
        return mainStackView
    }()
    
    private var stateNameLabel: UILabel = {
        let stateNameLabel = UILabel()
        stateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stateNameLabel.numberOfLines = 1
        stateNameLabel.font = .boldSystemFont(ofSize: 16)
        stateNameLabel.textColor = .systemGray
        
        return stateNameLabel
    }()
    
    private var populationNumberLabel: UILabel = {
        let populationNumberLabel = UILabel()
        populationNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        populationNumberLabel.numberOfLines = 1
        populationNumberLabel.font = .boldSystemFont(ofSize: 16)
        populationNumberLabel.textColor = .black
        return populationNumberLabel
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        title: String,
        info: String
    ) {
        stateNameLabel.text = title
        populationNumberLabel.text = info
    }
    
    func clean() {
        stateNameLabel.text = nil
        populationNumberLabel.text = nil
    }
}

private extension StateInfoView {
    private func setupViews() {
        addSubviewAndPinToEdges(
            mainStackView,
            padding: .all(value: Constants.MainStack.paddingValue)
        )
        mainStackView.addArrangedSubview(stateNameLabel)
        mainStackView.addArrangedSubview(populationNumberLabel)
    }
}
