//
//  ViewController.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

    }

    func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
