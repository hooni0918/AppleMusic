//
//  ViewController.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
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
