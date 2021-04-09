//
//  FlowRoutingServiceMock.swift
//  PokemonTests
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit
@testable import Pokemon

class FlowRoutingServiceMock: FlowRoutingServiceProtocol {
    var rootViewController: UIViewController
    var visibleViewController: UIViewController
    init() {
        rootViewController = UIViewController()
        visibleViewController = UIViewController()
    }
    func showPushed(_ controller: UIViewController) { pushed = true }
    func clearStackInBetween(left: UIViewController, right: UIViewController) {}
    func clearStackAndShowPushed(_ controllers: [UIViewController]) {}
    func clearLastAndShowPushed(_ controller: UIViewController) {}
    func jumpBack(to controller: UIViewController?) {}
    func jumpBack(to controller: UIViewController, andPush next: UIViewController) {}
    func jumpBackToRoot() { }
    func replace(viewController: UIViewController, with controller: UIViewController) {}
    func showModel(_ controller: UIViewController, modelPresentationStyle: UIModalPresentationStyle?, closeHandler: (() -> Void)?) {}
    var pushed = false
    var pushedDescription: String = ""
    
}

protocol FlowRoutingServiceMocked {
    var pushed: Bool { get }
}

extension FlowRoutingServiceMock: FlowRoutingServiceMocked {}

