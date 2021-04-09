//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
