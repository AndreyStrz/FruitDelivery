//
//  MainViewController.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import Foundation
import UIKit
import SwiftUI

protocol MainViewControllerProtocol {
    func reloadDataSource()
//    func updateCounterView()
}

final class MainViewController: UIViewController {
    // MARK: - IBOutlets
    private lazy var backgroundImageView: UIImageView = {
        let result: UIImageView = .init()
        result.image = .init(named: "background")
        result.contentMode = .scaleAspectFill
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var containerTextFieldView: UIView = {
        let result: UIView = .init()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = .clear
        
        return result
    }()
    
    private lazy var searchTextField: HostingView<MainTextField> = {
        return .init(
            content: .init(
                text: .init(
                    get: { [weak self] in
                        self?.viewModel.searchText ?? ""
                    },
                    set: { [weak self] newValue in
                        self?.presenter.searchFieldUpdated(text: newValue)
                    }
                ),
                placeholder: "SEARCH..."
            )
        )
    }()

    private var counterView: HostingView<CounterView>!
    
    private lazy var collectionViewLayout: PagingCollectionViewLayout = {
        let result: PagingCollectionViewLayout = .init()
        result.scrollDirection = .horizontal
        
        return result
    }()
        
    private lazy var collectionView: UICollectionView = {
        let result: UICollectionView = .init(frame: .zero, collectionViewLayout: collectionViewLayout)
        result.showsHorizontalScrollIndicator = false
        result.backgroundColor = .init(red: 83, green: 125, blue: 34, alpha: 1)
        result.layer.cornerRadius = 32
        result.layer.borderColor = UIColor.init(red: 83, green: 125, blue: 34, alpha: 1).cgColor
        result.layer.borderWidth = 6
        result.layer.masksToBounds = true
        result.decelerationRate = .fast
        result.translatesAutoresizingMaskIntoConstraints = false

        return result
    }()
    
    private var counterContentView: UIView = {
        let result: UIView = .init()
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    public var presenter: MainPresenterProtocol!
    public var viewModel: MainViewModel!
    
    private lazy var dataSource: MainDataSource.DiffableDataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if viewModel.viewSize != view.bounds.size && viewModel.collecitonViewSize == .zero {
            viewModel.apply(
                collecitonViewSize: .init(
                    width: view.bounds.width - viewModel.contentWidthWithoutCollectionView,
                    height: view.bounds.height - viewModel.contentHeightWithoutCollectionView
                )
            )
            
            collectionViewLayout.itemSize = viewModel.cellSize
            collectionViewLayout.minimumLineSpacing = viewModel.spacingBetweenItems
            
            presenter.viewDidLoad()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup
    private func initialSetup() {
        viewModel.viewSize = view.bounds.size
        collectionView.delegate = self
        
        // MARK: - Constraints
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])

        view.addSubview(containerTextFieldView)
        NSLayoutConstraint.activate([
            containerTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            containerTextFieldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -42),
            containerTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 42),
            containerTextFieldView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        containerTextFieldView.addConstrainted(subview: searchTextField)
                        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerTextFieldView.bottomAnchor, constant: 32),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
        
        view.addSubview(counterContentView)
        NSLayoutConstraint.activate([
            counterContentView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 32),
            counterContentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -122),
            counterContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            counterContentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 122),
            counterContentView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        updateCounterView()
    }
}

extension MainViewController {
    func makeDataSource() -> MainDataSource.DiffableDataSource {
        collectionView.registerCell(class: ProductCollectionCell.self)
        
        let result: MainDataSource.DiffableDataSource = .init(for: collectionView) { collectionView, indexPath, cellViewModel in
            switch cellViewModel {
            case .productCell:
                return collectionView.dequeueReusableCell(
                    type: ProductCollectionCell.self,
                    for: indexPath
                )
            }
        }
        
        return result
    }
    
    func updateCounterView() {
        counterView = .init(
            content: .init(
                text: "\(viewModel.currentPage)/3",
                layout: .counter
            )
        )
        
        counterContentView.subviews.forEach({ $0.removeFromSuperview() })
        counterContentView.addConstrainted(subview: counterView)
    }
}

extension MainViewController: MainViewControllerProtocol {
    func reloadDataSource() {
        self.dataSource.apply(viewModel.dataSource.snapshot, animatingDifferences: false)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        guard let itemViewModel: MainKindCellViewModel =
                dataSource.itemViewModel(at: indexPath) else { return }
        
        switch itemViewModel {
        case .productCell(let viewModel):
            cell.configure(as: ProductCollectionCell.self, with: viewModel) { cell in
                cell.onTap = { [weak self] id in
                    self?.presenter.pushToDetailProduct(id: id)
                }
                
                cell.onTapFavoriteButton = { [weak self] id in
                    self?.presenter.didTapOnFavoriteButton(id: id)
                }
                
                cell.onTapOrderButton = { [weak self] id in
                    self?.presenter.didTapOnOrderButton(id: id)
                }
            }
        }
    }
}
// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let counter = scrollView.contentOffset.x / viewModel.collecitonViewSize.width
        
        let newCounter = Int(counter) + 1
        viewModel.currentPage = newCounter
        if newCounter == viewModel.currentPage {
            updateCounterView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return dataSource.insets(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.itemSize(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.interitemSpacing(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.lineSpacing(for: section)
    }
}
