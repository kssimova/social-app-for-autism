//
//  TablesCollections+RegisterXibs.swift
//  SocialApp
//
//  Created by Kristina Simova on 21.05.22.
//


import UIKit

enum CellReuseIdentifier: String {
    case HomeCollectionViewCell
    case ChildProfileTableViewCell
    case StoryLibraryTableViewCell
    case CreateTestTableViewCell
}

extension UITableView {
    func registerCell(nibName: CellReuseIdentifier) {
        self.register(UINib(nibName: nibName.rawValue, bundle: nil), forCellReuseIdentifier: nibName.rawValue)
    }
    
    func dequeueCell(withIdentifier identifier: CellReuseIdentifier, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: identifier.rawValue, for: indexPath)
    }
}

extension UICollectionView {
    func registerCell(nibName: CellReuseIdentifier) {
        self.register(UINib(nibName: nibName.rawValue, bundle: nil), forCellWithReuseIdentifier: nibName.rawValue)
    }
    
    func registerSupplementaryView(nibName: CellReuseIdentifier, forSupplementaryViewOfKind: String) {
        self.register(UINib(nibName: nibName.rawValue, bundle: nil), forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: nibName.rawValue)
    }
    
    func dequeueCell(withIdentifier identifier: CellReuseIdentifier, for indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: identifier.rawValue, for: indexPath)
    }
    
    func dequeueSupplementaryView(ofKind kind: String, withReuseIdentifier reuseIdetifier: CellReuseIdentifier, for indexPath: IndexPath) -> UICollectionReusableView {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdetifier.rawValue, for: indexPath)
    }
}

