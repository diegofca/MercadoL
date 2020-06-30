//  ProductDetailViewController.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class ProductDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet private var tableView: UITableView!
    private var backHeader = ProductDetailHeaderView()
    private var header = ProductDetailHeaderSpaceView()
    
    lazy var presenter: ProductDetailPresenter = {
        return ProductDetailPresenter(delegate: self)
    }()
    
    struct Constants {
        static let titleItemCell = "ProductDetailTitleViewCell"
        static let descrpItemCell = "ProductDetailDescriptionViewCell"
        static let picturesItemCell = "ProductDetailListPicturesViewCell"
        static let priceItemCell = "ProductDetailPriceViewCell"
        // metrics Values
        static let heigthHeaderInView: CGFloat = UIScreen.main.bounds.height/1.65
        static let topTableInView: CGFloat = UIScreen.main.bounds.height/1.55
        static let offsetBottom: CGFloat = 20
        static let heigthCell: CGFloat = 135
        static let heigthSection: CGFloat = 60
        static let spaceViewToBottom: CGFloat = 34
        // mssg
        static let errorTitle = "Error!"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getProductDetail()
    }
    
    private func setViews() {
        //Register cells
        setTableView()
        
        //MARK: - Set views
        backHeader = ProductDetailHeaderView(height: Constants.heigthHeaderInView, delegate: self)
        header = ProductDetailHeaderSpaceView(height: Constants.heigthHeaderInView)

        tableView.addSubview(backHeader)
        tableView.sendSubviewToBack(backHeader)
        tableView.contentInset = UIEdgeInsets(top: Constants.topTableInView, left: .zero, bottom: Constants.spaceViewToBottom, right: .zero)
        tableView.contentOffset = CGPoint(x: .zero, y: -Constants.topTableInView )
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.tableHeaderView = header
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: Constants.titleItemCell, bundle: nil),
                                forCellReuseIdentifier: Constants.titleItemCell)
        tableView.register(UINib(nibName: Constants.descrpItemCell, bundle: nil),
                           forCellReuseIdentifier: Constants.descrpItemCell)
        tableView.register(UINib(nibName: Constants.picturesItemCell, bundle: nil),
                           forCellReuseIdentifier: Constants.picturesItemCell)
        tableView.register(UINib(nibName: Constants.priceItemCell, bundle: nil),
                           forCellReuseIdentifier: Constants.priceItemCell)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.itemsCell[indexPath.row] {
        case .Title:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.titleItemCell, for: indexPath) as! ProductDetailTitleViewCell
            cell.setProductTitle(presenter.product?.title)
            return cell
            
        case .Price:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.priceItemCell, for: indexPath) as! ProductDetailPriceViewCell
            cell.setDataProduct(presenter.product)
            return cell
            
        case .Description:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.descrpItemCell, for: indexPath) as! ProductDetailDescriptionViewCell
            return cell
            
        case .Images:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.picturesItemCell, for: indexPath) as! ProductDetailListPicturesViewCell
            cell.setImagesList(imagesList: presenter.product?.pictures)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollingImageHeader(scrollView, animated: false)
    }
    
    func scrollingImageHeader(_ scrollView: UIScrollView, animated: Bool){
        let duration: Double = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            let yPos: CGFloat = -scrollView.contentOffset.y
            if yPos > .zero {
                var imgRect: CGRect = self.backHeader.frame
                imgRect.origin.y = scrollView.contentOffset.y
                imgRect.size.height = yPos + Constants.offsetBottom
                self.backHeader.frame = imgRect
            }
                            
            let alpha = 1 - (yPos / Constants.heigthHeaderInView)
            self.backHeader.effectView.alpha = alpha
            scrollView.layoutIfNeeded()
        }
    }
    
    func updateUIAction(_ action: @escaping () -> Void){
        DispatchQueue.main.async {
            action()
        }
    }
    
}

//MARK: - Delegado del Header principal de la vista
extension ProductDetailViewController : ProductDetailHeaderViewDelegate {
    func favoriteClicked() {
        updateUIAction {
            NotifyBanner.showBanner(title: "Añadido a tus favoritos", subtitle: "", style: .danger)
        }
    }
    
    func shareClicked() {
        updateUIAction {
            NotifyBanner.showBanner(title: "Compartiendo producto...", subtitle: "", style: .danger)
        }
    }
    
    func buyClicked() {
        updateUIAction {
            NotifyBanner.showBanner(title: "Has comprado este producto.", subtitle: "", style: .danger)
        }
    }
}

//MARK: - Delegado del presentador
extension ProductDetailViewController : ProductDetailPresenterDelegate {
    func onLoadProduct(_ product: Product) {
        updateUIAction {
            self.backHeader.setProductData(product)
            self.tableView.reloadDataFaded()
        }
    }

    func onError(_ mssg: String?) {
        updateUIAction {
            NotifyBanner.showBanner(title: Constants.errorTitle, subtitle: mssg, style: .danger)
        }
    }
}
