//
//  Coordinator.swift
//  SocialApp
//
//  Created by Kristina Simova on 26.05.22.
//
import UIKit

public protocol Coordinator: class {
    var children: [Coordinator] { get set }
    func start() -> UIViewController
}

extension Coordinator {

    /// Add a child coordinator to the parent
    public func add(coordinator: Coordinator) {
        children.append(coordinator)
    }

    /// Remove a child coordinator from the parent
    public func remove(coordinator: Coordinator) {
        children = children.filter { $0 !== coordinator }
    }

}

