//
//  CoinsViewController.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import UIKit

class CoinsViewController: UIViewController {
    
    private let viewModel: CoinsViewModel
    
    init(viewModel: CoinsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CoinsTableViewCell.self, forCellReuseIdentifier: CoinsTableViewCell.identifier)
        return tableView
    }()
    
    private let spiner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Crypto Tracker"
        
        view.addSubview(tableView)
        view.addSubview(spiner)

        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(signOutButtonClicked))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort24H", style: .plain, target: self, action: #selector(sortButtonClicked))
        
        spiner.center = self.view.center
        spiner.startAnimating()
        viewModel.loadCoins { [weak self] in
            self?.tableView.reloadData()
            self?.spiner.stopAnimating()
            print("requests completed")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func signOutButtonClicked() {
        viewModel.signOut()
    }
    
    @objc func sortButtonClicked() {
        viewModel.sortPrice()
        tableView.reloadData()
    }
}

extension CoinsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = viewModel.answers[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinsTableViewCell.identifier, for: indexPath) as? CoinsTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.routeToCoinsDetails(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

