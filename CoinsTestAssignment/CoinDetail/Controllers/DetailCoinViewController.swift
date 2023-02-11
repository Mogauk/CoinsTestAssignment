//
//  DetailCoinViewController.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import UIKit

class DetailCoinViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .thin)
        label.textAlignment = .left
        
        return label
    }()
    
    private let pricelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let titlePriceChange24HLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.text = "Percent change last 24 hours"
        return label
    }()
    
    private let priceChange24HLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private let titlePriceChange1HLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.text = "Percent change last 1 hour"
        return label
    }()
    
    private let priceChange1HLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private let viewModel: DetailCoinViewModel
    
    init(viewModel: DetailCoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nameLabel.text = viewModel.coin.data.name
        symbolLabel.text = viewModel.coin.data.symbol
        pricelLabel.text = viewModel.coin.data.market_data.price_usd.formatted(.currency(code: "USD"))
        priceChange24HLabel.text = viewModel.coin.data.market_data.percent24Hchange
        priceChange24HLabel.textColor = viewModel.coin.data.market_data.percent_change_usd_last_24_hours > 0 ? .green : .red
        priceChange1HLabel.text = viewModel.coin.data.market_data.percent1Hchange
        priceChange1HLabel.textColor = viewModel.coin.data.market_data.percent_change_usd_last_1_hour > 0 ? .green : .red
        
        view.addSubview(nameLabel)
        view.addSubview(symbolLabel)
        view.addSubview(pricelLabel)
        view.addSubview(priceChange24HLabel)
        view.addSubview(titlePriceChange24HLabel)
        view.addSubview(titlePriceChange1HLabel)
        view.addSubview(priceChange1HLabel)
        
        createNameLabelConstraint()
        createSymbolLabelConstraint()
        createPricelLabelConstraint()
        createPriceChange24HlLabelConstraint()
        createTitlePriceChange24HLabelConstraint()
        createTitlePriceChange1HLabelConstraint()
        createPriceChange1HlLabelConstraint()
    }
    
    func createNameLabelConstraint() {
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func createSymbolLabelConstraint() {
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        symbolLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        symbolLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func createPricelLabelConstraint() {
        pricelLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10).isActive = true
        pricelLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        pricelLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
    }
    
    func createTitlePriceChange24HLabelConstraint() {
        titlePriceChange24HLabel.topAnchor.constraint(equalTo: pricelLabel.bottomAnchor, constant: 40).isActive = true
        titlePriceChange24HLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titlePriceChange24HLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
    }
    
    func createPriceChange24HlLabelConstraint() {
        priceChange24HLabel.topAnchor.constraint(equalTo: titlePriceChange24HLabel.bottomAnchor, constant: 10).isActive = true
        priceChange24HLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        priceChange24HLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func createTitlePriceChange1HLabelConstraint() {
        titlePriceChange1HLabel.topAnchor.constraint(equalTo: priceChange24HLabel.bottomAnchor, constant: 40).isActive = true
        titlePriceChange1HLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titlePriceChange1HLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
    }
    
    func createPriceChange1HlLabelConstraint() {
        priceChange1HLabel.topAnchor.constraint(equalTo: titlePriceChange1HLabel.bottomAnchor, constant: 10).isActive = true
        priceChange1HLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        priceChange1HLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}


