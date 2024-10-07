//
//  MainViewController.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Combine

import UIKit

final class MainViewController: UIViewController {
    
    private enum Constants {
        enum NationInfo {
            static let verticalPadding: CGFloat = 8
            static let horizontalPadding: CGFloat = 4
        }
        
        enum TableView {
            static let estimatedHeaderHeight: CGFloat = 50
            static let sectionHeaderTopPadding: CGFloat = 0
        }
        
        enum ActivityIndicator {
            static let width: CGFloat = 50
        }
        
        enum PickerView {
            static let paddingValue: CGFloat = 4
            static let componentsCount: Int = 1
            static let height: CGFloat = 150
            static let animationDuration: CGFloat = 0.4
        }
    }
    
    private var loadingView: UIView = {
        let loadingView = UIView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = .white.withAlphaComponent(0.5)
        loadingView.isHidden = true
        return loadingView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    private var nationInfoView: NationInfoView = {
        let nationInfoView = NationInfoView()
        nationInfoView.translatesAutoresizingMaskIntoConstraints = false
        nationInfoView.backgroundColor = .systemGray6
        nationInfoView.layer.cornerRadius = 10
        nationInfoView.layer.borderWidth = 3
        nationInfoView.layer.borderColor = UIColor.systemGray3.cgColor
        return nationInfoView
    }()
    
    private lazy var filterRightBarButton: UIBarButtonItem = {
        let filterRightBarButton = UIBarButtonItem()
        filterRightBarButton.action = #selector(filterOptionsPressed)
        filterRightBarButton.target = self
        filterRightBarButton.image = viewModel.navigationRightBarButtonImage
        return filterRightBarButton
    }()
    
    private lazy var pickerContainer: UIView = {
        let pickerContainer = UIView()
        pickerContainer.translatesAutoresizingMaskIntoConstraints = false
        pickerContainer.backgroundColor = .clear
        pickerContainer.isHidden = true
        pickerContainer.alpha = 0
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissPicker)
        )
        pickerContainer.addGestureRecognizer(gesture)
        return pickerContainer
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.layer.cornerRadius = 10
        pickerView.layer.borderWidth = 2
        pickerView.layer.borderColor = UIColor.systemGray3.cgColor
        pickerView.backgroundColor = .systemGray6
        return pickerView
    }()
    
    private lazy var populationTableView = UITableView(
        frame: .zero,
        style: .plain
    )
    
    private lazy var settingsTableViewDataSource: UITableViewDiffableDataSource<PopulationInfoSection, StatePopulationInfo> = {
        return UITableViewDiffableDataSource(
            tableView: populationTableView,
            cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
                self?.cellProvider(
                    tableView: tableView,
                    indexPath: indexPath,
                    itemIdentifier: itemIdentifier
                )
            }
        )
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: MainViewModelType
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupNavigationBar()
        setupViews()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

private extension MainViewController {
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = filterRightBarButton
    }

    private func setupViews() {
        view.backgroundColor = .white
        populationTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nationInfoView)
        view.addSubview(populationTableView)
        view.addSubviewAndPinToEdges(loadingView)
        view.addSubviewAndPinToEdges(pickerContainer)
        
        NSLayoutConstraint.activate(
            [
                nationInfoView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: Constants.NationInfo.horizontalPadding
                ),
                nationInfoView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Constants.NationInfo.verticalPadding
                ),
                nationInfoView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -Constants.NationInfo.horizontalPadding
                ),
                nationInfoView.bottomAnchor.constraint(
                    equalTo: populationTableView.topAnchor,
                    constant: -Constants.NationInfo.verticalPadding
                ),
                
                populationTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                populationTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                populationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
        
        setupSpaceXTableView()
        setupLoadingContainer()
        setupPickerContainer()
    }
    
    private func setupSpaceXTableView() {
        populationTableView.backgroundColor = .white
        
        populationTableView.register(PopulationInfoCell.self)
        populationTableView.registerHeaderFooter(PopulationInfoHeaderView.self)

        populationTableView.rowHeight = UITableView.automaticDimension
        populationTableView.separatorStyle = .none
        populationTableView.delegate = self
        populationTableView.backgroundColor = .white
        populationTableView.sectionHeaderHeight = UITableView.automaticDimension
        populationTableView.estimatedSectionHeaderHeight = Constants.TableView.estimatedHeaderHeight
        populationTableView.sectionHeaderTopPadding = Constants.TableView.sectionHeaderTopPadding
    }
    
    private func setupLoadingContainer() {
        loadingView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
                activityIndicator.widthAnchor.constraint(equalToConstant: Constants.ActivityIndicator.width),
                activityIndicator.heightAnchor.constraint(equalTo: activityIndicator.widthAnchor)
            ]
        )
    }
    
    private func setupPickerContainer() {
        pickerContainer.addSubview(pickerView)
        
        NSLayoutConstraint.activate(
            [
                pickerView.leadingAnchor.constraint(
                    equalTo: pickerContainer.leadingAnchor,
                    constant: Constants.PickerView.paddingValue
                ),
                pickerView.trailingAnchor.constraint(
                    equalTo: pickerContainer.trailingAnchor,
                    constant: -Constants.PickerView.paddingValue
                ),
                pickerView.bottomAnchor.constraint(
                    equalTo: pickerContainer.bottomAnchor,
                    constant: -Constants.PickerView.paddingValue
                ),
                pickerView.heightAnchor.constraint(equalToConstant: Constants.PickerView.height)
            ]
        )
    }
    
    private func cellProvider(
        tableView: UITableView,
        indexPath: IndexPath,
        itemIdentifier: AnyHashable
    ) -> UITableViewCell? {
        guard
            let item = viewModel.populationInfoPublisher.value?.cellsInfo?[safe: indexPath.item]
        else { return nil }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as PopulationInfoCell
        cell.configure(
            title: item.name,
            info: item.population
        )
        return cell
    }
    
    private func applySnapshot(item: PopulationInfoSection) {
        var snap = NSDiffableDataSourceSnapshot<PopulationInfoSection, StatePopulationInfo>()
        snap.appendSections([item])
        snap.appendItems(
            item.cellsInfo ?? [],
            toSection: item
        )

        settingsTableViewDataSource.apply(
            snap,
            animatingDifferences: false
        )
    }
    
    private func setupBindings() {
        viewModel
            .navigationBarTitlePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTitle in
                self?.title = newTitle
            }
            .store(in: &cancellables)
        
        viewModel
            .nationInfoPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] info in
                self?.nationInfoView.configure(with: info)
            }
            .store(in: &cancellables)
        
        viewModel
            .populationInfoPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                guard
                    let self,
                    let item
                else { return }
                applySnapshot(item: item)
            }
            .store(in: &cancellables)
        
        viewModel
            .loadingVisiblePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isVisible in
                guard let self else { return }
                if pickerContainer.isHidden {
                    updateFilterOptionButtonAvailability()
                }
                loadingView.isHidden = !isVisible
                
                isVisible
                ? activityIndicator.startAnimating()
                : activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel
            .yearsListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.pickerView.reloadAllComponents()
            }
            .store(in: &cancellables)
    }
    
    private func updateFilterOptionButtonAvailability() {
        filterRightBarButton.isEnabled = viewModel.loadingVisiblePublisher.value == false
        
    }
    
    private func updatePickerContainerVisibility() {
        let isHidden = pickerContainer.isHidden
        UIView.animate(withDuration: Constants.PickerView.animationDuration) { [weak self] in
            guard let self else { return }
            if isHidden {
                pickerContainer.isHidden = false
            }
            pickerContainer.alpha = isHidden ? 1 : 0
        } completion: { [weak self] _ in
            guard let self else { return }
            if !isHidden {
                pickerContainer.isHidden = true
            }
        }

    }
    
    @objc func filterOptionsPressed() {
        updatePickerContainerVisibility()
        if pickerContainer.isHidden {
            updateFilterOptionButtonAvailability()
        }
    }
    
    @objc func dismissPicker() {
        updatePickerContainerVisibility()
        updateFilterOptionButtonAvailability()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard
            let details = viewModel.populationInfoPublisher.value?.info
        else { return nil }
        
        let header = populationTableView.dequeueReusableHeaderFooter(for: section) as PopulationInfoHeaderView
        header.configure(
            title: details.name,
            info: details.population
        )
        return header
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.PickerView.componentsCount
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        viewModel.yearsListPublisher.value.count
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        viewModel.pickerViewDidSelectedIndex(at: row)
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        viewModel.yearsListPublisher.value[safe: row]
    }
}
