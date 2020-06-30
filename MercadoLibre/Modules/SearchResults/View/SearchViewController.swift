//  SearchViewController.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    @IBOutlet private var productsTableView: UITableView!
    private var searchBar = UISearchController()
    
    lazy var presenter: SearchPresenter = {
        return SearchPresenter(delegate: self)
    }()
    
    private var router: SearchRouter?
    
    struct Constants {
        static let productCellName = "SearchProductTableViewCell"
        static let defaultRow: CGFloat = 150
        //msg
        static let stateSearchMgs = "Busca los mejores productos"
        static let emptyStateMgs = "No se encontraron resultados en la busqueda"
        static let seachPlaceholderMsg = "Busca tu producto aqui..."
        static let errorTitle = "Error!"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.searchBar.searchBar.becomeFirstResponder()
        }
    }

    private func setViews() {
        if let nav = self.navigationController {
            router = SearchRouter(navigationController: nav)
        }
        configurationSearch()

        productsTableView.estimatedRowHeight = Constants.defaultRow
        productsTableView.tableFooterView = UIView()
        productsTableView.register(UINib(nibName: Constants.productCellName, bundle: nil),
                           forCellReuseIdentifier: Constants.productCellName)
    }
    
    func configurationSearch() {
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.delegate = self
        searchBar.automaticallyShowsCancelButton = true
        searchBar.hidesNavigationBarDuringPresentation = true
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = Constants.seachPlaceholderMsg
        searchBar.searchBar.sizeToFit()

        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchBar
        definesPresentationContext = true
    }
    
}

//MARK: - Delegado del presentador
extension SearchViewController : SearchPresenterDelegate {
    
    func getResultProducts(with query: String) {
        DispatchQueue.main.async {
            self.productsTableView.reloadDataFaded()
            guard !query.isEmpty else {
                self.productsTableView.emptyMessage(Constants.stateSearchMgs)
                return
            }
            self.productsTableView.emptyMessage(Constants.emptyStateMgs)
        }
    }
    
    func onError(_ mssg: String?) {
        DispatchQueue.main.async {
            NotifyBanner.showBanner(title: Constants.errorTitle, subtitle: mssg, style: .danger)
        }
    }
}

//MARK: - Delegado de tabla de productos
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.productCellName, for: indexPath) as! SearchProductTableViewCell
        let productItem = presenter.items[indexPath.row]
        cell.setDataItem(productItem: productItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productItem = presenter.items[indexPath.row]
        router?.goToProductDetail(productID: productItem.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - Delegado de busqueda de productos
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        presenter.searchProducts(query: query)
    }
}
