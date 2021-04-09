//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit
import SDWebImage

class PokemonTableViewCell: UITableViewCell {
    
    private let pokeImageView = UIImageView()
    private var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(pokeImageView)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        pokeImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pokeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            pokeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            pokeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokeImageView.widthAnchor.constraint(equalTo: pokeImageView.heightAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: pokeImageView.trailingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(
        with title: String,
        pictureURL: String?
    ) {
        titleLabel.text = title
        
        if let pictureURL = pictureURL, let url = URL(string: pictureURL) {
            pokeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            pokeImageView.image = UIImage(named: "placeholder")
        }
    }
    
}
