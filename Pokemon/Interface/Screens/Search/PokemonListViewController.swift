//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Steven Curtis on 09/04/2021.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController {
    enum Section: CaseIterable {
        case pokemon
    }
 
    var viewModel: PokemonListViewModel
    let searchController = UISearchController(searchResultsController: nil)
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    var dataSource: UITableViewDiffableDataSource<Section, PokemonDetail>!

    lazy var tableView = UITableView()
    var cancellables = [AnyCancellable]()
    
    func applySnapshot() {
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteAllItems()
        currentSnapshot.appendSections([Section.pokemon])
        currentSnapshot.appendItems(viewModel.pokemon)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupHierarchy()
        setupComponents()
        setupConstraints()
        setupBindings()
        
        viewModel.getData()

    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    func setupBindings() {
        viewModel.pokemonPublisher
           .receive(on: DispatchQueue.main)
           .sink { [weak self] _ in
            self?.applySnapshot()
           }
           .store(in: &cancellables)
        
        viewModel.$shouldError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                if $0 {
                    self?.displayAlert()
                }
            }
            )
            .store(in: &cancellables)
        
        viewModel.$shouldLoad
            .receive(on: DispatchQueue.main)
            .sink(receiveValue:{ [weak self] in
                if $0 {
                    self?.indicator.startAnimating()
                } else {
                    self?.indicator.stopAnimating()
                }
            }
            )
            .store(in: &cancellables)
    }
    
    func setupSearchController() {
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.placeholder = "Search for a Pokemon"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.autocapitalizationType = .none

        let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        placeholderAppearance.font = .systemFont(ofSize: 16)

        navigationController?.navigationBar.barTintColor = UIColor(named: "PrimaryColor")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
    }

    func setupComponents() {
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray

        tableView.rowHeight = 50
        
        tableView.delegate = self
        
        configureDataSource()

        setupActivityIndicator()
        setupSearchController()
    }
    
    func configureDataSource() {
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, pokemon in
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: "Cell",
                for: indexPath
            ) as? PokemonTableViewCell {
                cell.configure(
                    with: pokemon.name,
                    pictureURL: pokemon.images.first
                )
                
                return cell
            }
            else {
                fatalError()
            }
        })
    }
    
    func setupActivityIndicator() {
        self.view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                indicator.topAnchor.constraint(equalTo: view.topAnchor),
                indicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                indicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                indicator.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func displayAlert() {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: "Something went wrong!", message: "Press OK to continue", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.viewModel.getData()
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        )
    }
    
    
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pokemon = dataSource.itemIdentifier(for: indexPath) {
//            viewModel.moveDetail(with: pokemon)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.viewModel.keyWordSearch = searchText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.keyWordSearch = ""
    }
}
