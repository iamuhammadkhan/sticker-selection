//
//  StickersViewController.swift
//  StickerSelection
//
//  Created by Muhammad Khan on 1/18/22.
//

import UIKit
import SnapKit

final class StickersViewController: UIViewController {

    // MARK: - UI Properties
    private let stickersView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        return sv
    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    private let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.axis = .vertical
        sv.spacing = 0
        return sv
    }()
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - UI Helper Methods
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainStackView.addArrangedSubview(stickersView)
        mainStackView.addArrangedSubview(collectionView)
        stickersView.addInteraction(UIDropInteraction(delegate: self))
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.identifier)
    }
}

// MARK: - CollectionView DataSource and Delegates
extension StickersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StickerManager.getStickers().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StickerCollectionViewCell = collectionView.dequeReusableCell(for: indexPath)
        cell.configure(with: StickerManager.getStickers()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

// MARK: - UICollectionView Drag Delegates
extension StickersViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = StickerManager.getStickers()[indexPath.row]
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

// MARK: - UI Drop Interaction Delegates
extension StickersViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]
            let imageView = UIImageView(image: images.first)
            self.stickersView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(30)
            }
        }
        stickersView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: stickersView)
        let operation: UIDropOperation

        if stickersView.frame.contains(dropLocation) {
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            operation = .cancel
        }
        return UIDropProposal(operation: operation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.items.count == 1
    }
}
