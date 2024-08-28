//
//  FavoritesViewController.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 19.08.2024.
//

import Foundation
import UIKit
import SwiftUI

protocol FavoritesViewControllerProtocol {
    func reloadDataSource()
}

final class FavoritesViewController: UIViewController {
    // MARK: - IBOutlets
    private lazy var backgroundImageView: UIImageView = {
        let result: UIImageView = .init()
        result.image = .init(named: "background")
        result.contentMode = .scaleAspectFill
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
        
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
    
    private lazy var counterContentView: UIView = {
        let result: UIView = .init()
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private var counterView: HostingView<CounterView>!
    
    public var presenter: FavoritesPresenterProtocol!
    public var viewModel: FavoritesViewModel!
    
    private lazy var dataSource: FavoritesDataSource.DiffableDataSource = makeDataSource()
    
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
                        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 172),
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

extension FavoritesViewController {
    func makeDataSource() -> FavoritesDataSource.DiffableDataSource {
        collectionView.registerCell(class: ProductCollectionCell.self)
        
        let result: FavoritesDataSource.DiffableDataSource = .init(for: collectionView) { collectionView, indexPath, cellViewModel in
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

extension FavoritesViewController: FavoritesViewControllerProtocol {
    func reloadDataSource() {
        self.dataSource.apply(viewModel.dataSource.snapshot, animatingDifferences: false)
    }
}

// MARK: - UIScrollViewDelegate
extension FavoritesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let counter = scrollView.contentOffset.x / viewModel.collecitonViewSize.width
         
        let newCounter = Int(counter) + 1
        viewModel.currentPage = newCounter
        if newCounter == viewModel.currentPage {
            updateCounterView()
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        guard let itemViewModel: FavoritesKindCellViewModel =
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

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
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
