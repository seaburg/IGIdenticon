//
//  ViewController.swift
//  Example
//
//  Created by Evgeniy Yurtaev on 19/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var icons = [UIImage]()
    private let imageViewCellIdentifier = "ImageViewCell"
    private var cellSize: CGSize {
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfColumns: CGFloat = 3
        let size = (collectionView!.frame.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        return CGSize(width: size, height: size)
    }

    // MARK: Actions

    @IBAction func addButtonTapped(sender: AnyObject) {
        let generator: IconGenerator = (icons.count % 2 == 0) ? Identicon() : GitHubIdenticon()
        icons.append(generator.icon(from: arc4random(), size: cellSize))

        self.collectionView!.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: imageViewCellIdentifier, for: indexPath) as! ImageViewCell
        cell.imageView.image = icons[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}

