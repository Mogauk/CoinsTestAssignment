//
//  CoinsTableViewCell.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import UIKit

class CoinsTableViewCell: UITableViewCell {
    
    static let identifier = "CoinsTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let pricelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let priceChange24HLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(pricelLabel)
        contentView.addSubview(priceChange24HLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        symbolLabel.sizeToFit()
        pricelLabel.sizeToFit()
        priceChange24HLabel.sizeToFit()
        
        nameLabel.frame = CGRect(
            x: 25,
            y: contentView.frame.size.height/2,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
        
        symbolLabel.frame = CGRect(
            x: 25,
            y: 0,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
        
        pricelLabel.frame = CGRect(
            x: contentView.frame.size.width/2,
            y: 0,
            width: (contentView.frame.size.width/2)-15,
            height: contentView.frame.size.height/2
        )
        
        priceChange24HLabel.frame = CGRect(
            x: contentView.frame.size.width/2,
            y: 35,
            width: (contentView.frame.size.width/2)-15,
            height: contentView.frame.size.height/2
        )
    }
    
    func configure(with viewModel: CoinModel) {
        
        let price = viewModel.data.market_data.price_usd
        nameLabel.text = viewModel.data.name
        symbolLabel.text = viewModel.data.symbol
        pricelLabel.text = price.formatted(.currency(code: "USD"))
        priceChange24HLabel.text = viewModel.data.market_data.percent24Hchange
        priceChange24HLabel.textColor = viewModel.data.market_data.percent_change_usd_last_24_hours > 0 ? .green : .red
    }
}
