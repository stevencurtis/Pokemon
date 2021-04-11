//
//  Carousel.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit
import SDWebImage

class Carousel: UIView {
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CarouselLayout()
    )

    var urls: [URL] = []

    public init(frame: CGRect, urls: [URL]) {
        self.urls = urls
        super.init(frame: frame)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Storyboard Instantiation not supported")
    }

    func update(urls: [URL]) {
        self.urls = urls
        collectionView.reloadData()
        scheduleTimerIfNeeded()
    }

    private func setupView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
        collectionView.isPagingEnabled = true

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        scheduleTimerIfNeeded()
    }

    deinit {
        timer?.invalidate()
    }

    private func scheduleTimerIfNeeded() {
        guard urls.count > 1 else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 3.0,
            repeats: true,
            block: { [weak self] _ in
                self?.selectNext()
            }
        )
    }

    var selectedIndex: Int = 0

    private func selectNext() {
        selectItem(at: selectedIndex + 1)
    }

    private func selectItem(at index: Int) {
        let index = urls.count > index ? index : 0
        guard selectedIndex != index else { return }
        selectedIndex = index
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }

    private var timer: Timer?
}

extension Carousel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.size.width
        let cellHeight = self.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension Carousel: UICollectionViewDelegate {}

extension Carousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
        imageView.contentMode = .center
        imageView.sd_setImage(with: urls[indexPath.row], placeholderImage: UIImage(named: "placeholder"))
        cell.contentView.addSubview(imageView)
        return cell
    }
}
