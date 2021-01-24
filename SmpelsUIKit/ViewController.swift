//
//  ViewController.swift
//  SmpelsUIKit
//
//  Created by Tal Spektor on 24/01/2021.
//  Copyright © 2021 Tal Spektor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let samples: [BaseVC] = [MapVC(), LinkPreviewVCViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit Semples"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(describing: samples[indexPath.row].topTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = samples[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

