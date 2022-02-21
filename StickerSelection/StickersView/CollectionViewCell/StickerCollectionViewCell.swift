//
//  StickerCollectionViewCell.swift
//  StickerSelection
//
//  Created by Muhammad Khan on 1/18/22.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {
    
    private let stickerImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets up the cell with its views
    private func setupViews() {
        stickerImage.image = UIImage(named: "tibles-logo")
        contentView.addSubview(stickerImage)
        stickerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    /// Configures the cell with image for emoji
    func configure(with image: UIImage) {
        stickerImage.image = image
    }
}
