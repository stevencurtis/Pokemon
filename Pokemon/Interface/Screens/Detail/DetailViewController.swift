//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    enum Constants {
        static let padding: CGFloat = 5
    }

    private var viewModel: DetailViewModel
    private var cancellables = [AnyCancellable]()

    lazy private var label = UILabel()
    lazy private var stackView = UIStackView()
    lazy private var statsTextView = UITextView()
    lazy private var carousel = Carousel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
        setupBindings()
    }

    private func setupBindings() {
        viewModel.$pokemon
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemon in
                self?.label.text = "name: \(pokemon.name)"
                self?.carousel.update(urls: pokemon.images.compactMap { URL(string: $0) })
                self?.statsTextView.text = pokemon.stats.map { "\($0.name): \($0.base) "}.joined(separator: "\n")
            }
            .store(in: &cancellables)
    }

    private func setupHierarchy() {
        view.addSubview(stackView)
        view.addSubview(carousel)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(statsTextView)
    }

    private func setupComponents() {
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)

        carousel.translatesAutoresizingMaskIntoConstraints = false

        statsTextView.translatesAutoresizingMaskIntoConstraints = false
        statsTextView.textContainerInset = .zero
        statsTextView.textContainer.lineFragmentPadding = 0
        statsTextView.isSelectable = false
        statsTextView.font = .systemFont(ofSize: 18)

        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            carousel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200),

            stackView.topAnchor.constraint(equalTo: carousel.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
        ])
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
