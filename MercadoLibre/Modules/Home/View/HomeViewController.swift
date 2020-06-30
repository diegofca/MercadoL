//  HomeViewController.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 30/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet private var categoriesTableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    lazy var presenter: HomePresenter = {
        return HomePresenter(delegate: self)
    }()
       
    private var router: HomeRouter?
    
    struct Constants {
        static let categorieCellName = "HomeCategoryTableViewCell"
        static let defaultRow: CGFloat = 150
        //msg
        static let emptyStateMgs = "No se encontraron resultados en la busqueda"
        static let seachPlaceholderMsg = "Busca tu producto aqui..."
        static let errorTitle = "Error!"
        static let hasSelected = "Has seleccionado"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setViews()
    }
    
    private func getConfiguration() {
        setViews()
        presenter.getCategories()
    }
    
    private func setViews() {
        if let nav = self.navigationController {
            router = HomeRouter(navigationController: nav)
        }
        configurationSearch()

        categoriesTableView.estimatedRowHeight = Constants.defaultRow
        categoriesTableView.tableFooterView = UIView()
        categoriesTableView.register(UINib(nibName: Constants.categorieCellName, bundle: nil),
                                          forCellReuseIdentifier: Constants.categorieCellName)
    }
    
    private func configurationSearch() {
        searchBar.delegate = self
        searchBar.placeholder = Constants.seachPlaceholderMsg
        searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
}

//MARK: - Delegado de tabla de productos
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categorieCellName, for: indexPath) as! HomeCategoryTableViewCell
        let categoryItem = presenter.categories[indexPath.row]
        cell.setDataItem(categoryItem: categoryItem)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryItem = presenter.categories[indexPath.row]
        if presenter.expandedCategory(categoryItem) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.categoriesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController : HomePresenterDelegate {
    func getResultCategories() {
        DispatchQueue.main.async {
            self.categoriesTableView.reloadSections(IndexSet(arrayLiteral: .zero), with: .fade)
        }
    }
    
    func onError(_ mssg: String?) {
        DispatchQueue.main.async {
            NotifyBanner.showBanner(title: Constants.errorTitle, subtitle: mssg, style: .danger)
        }
    }
}


//MARK: - Delegado de busqueda de productos
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
        router?.goToSearchProducts()
    }
}

//MARK: - Delegado de seleccion de subcategoria
extension HomeViewController : HomeCategoryTableViewDelegate {
    func onSelectSubCategory(_ subCategory: SubCategory) {
        NotifyBanner.showBanner(title: Constants.hasSelected, subtitle: subCategory.name, style: .info)
    }
}
