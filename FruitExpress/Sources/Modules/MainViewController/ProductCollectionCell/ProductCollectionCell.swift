//
//  ProductCollectionCell.swift
//  FruitExpress
//
//  Created by Андрей Сторожко on 15.08.2024.
//

import UIKit

final class ProductCollectionCell: UICollectionViewCell, Reusable {
    // MARK: - IBOutlets
    private lazy var imageView: UIImageView = {
        let result: UIImageView = .init()
        result.contentMode = .scaleAspectFit
        result.layer.masksToBounds = true
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var favoriteImageView: UIImageView = {
        let result: UIImageView = .init()
        result.contentMode = .scaleAspectFill
        result.layer.masksToBounds = true
        let tapGesture: UITapGestureRecognizer = .init()
        tapGesture.addTarget(self, action: #selector(didTapOnFavoriteButton))
        result.addGestureRecognizer(tapGesture)
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var titleLabel: UILabel = {
        let result: UILabel = .init()
        result.textAlignment = .center
        result.numberOfLines = 1
        result.textColor = .black
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var orderButton: UIButton = {
        let result: UIButton = .init()
        result.backgroundColor = .init(red: 252, green: 199, blue: 0, alpha: 1)
        result.layer.cornerRadius = 10
        result.setTitle("ORDER", for: .normal)
        result.setTitleColor(.black, for: .normal)
        result.addTarget(self, action: #selector(didTapOnOrderButton), for: .touchUpInside)
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private lazy var favoriteButton: UIButton = {
        let result: UIButton = .init()
        result.backgroundColor = .clear
        result.addTarget(self, action: #selector(didTapOnFavoriteButton), for: .touchUpInside)
        
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()


    // MARK: - Output
    var onTap: ((String) -> Void)?
    var onTapFavoriteButton: ((String) -> Void)?
    var onTapOrderButton: ((String) -> Void)?
    
    private(set) var viewModel: ProductCellViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    // MARK: - Setup
    private func initialSetup() {
        backgroundColor = .init(red: 254, green: 248, blue: 234, alpha: 1)
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -52),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            imageView.heightAnchor.constraint(equalToConstant: bounds.height / 2.4)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
                
        addSubview(orderButton)
        NSLayoutConstraint.activate([
            orderButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            orderButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            orderButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            orderButton.heightAnchor.constraint(equalToConstant: bounds.height / 5)
        ])
        
        addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32)
        ])

        let tapGesture: UITapGestureRecognizer = .init()
        tapGesture.addTarget(self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func cellTapped() {
        onTap?(viewModel.id)
    }

    @objc private func didTapOnOrderButton() {
        onTapOrderButton?(viewModel.id)
    }
    
    @objc private func didTapOnFavoriteButton() {
        onTapFavoriteButton?(viewModel.id)
    }
}

// MARK: - ConfigurableCollectionCell
extension ProductCollectionCell: ConfigurableCollectionCell {
    func configure(viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        titleLabel.font = viewModel.layout.titleFont
        orderButton.titleLabel?.font = viewModel.layout.buttonTextFont
        favoriteButton.setImage(viewModel.isFavorite ? .favoriteHeartFill : .favoriteHeart , for: .normal)
    }
}
