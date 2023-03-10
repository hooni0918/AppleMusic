//
//  ViewController.swift
//  appleMusic
//
//  Created by ์ด์งํ on 2023/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    // ๐ ์์น ์ปจํธ๋กค๋ฌ ์์ฑ ===> ๋ค๋น๊ฒ์ด์ ์์ดํ์ ํ ๋น
    //    let searchController = UISearchController()
    
    // ๐ ์์น Results์ปจํธ๋กค๋ฌ โญ๏ธ
    //let sear = UISearchController(searchResultsController: <#T##UIViewController?#>)
    
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    // ๋คํธ์ํฌ ๋งค๋์  (์ฑ๊ธํค)
    var networkManager = NetworkManager.shared
    
    // (์์ ๋ฐ์ดํฐ๋ฅผ ๋ค๋ฃจ๊ธฐ ์ํจ) ๋น๋ฐฐ์ด๋ก ์์
    var musicArrays: [Music] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    // ์์น๋ฐ ์ํ
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        
        // ๐ 1) (๋จ์)์์น๋ฐ์ ์ฌ์ฉ
        //searchController.searchBar.delegate = self
        
        
        // ๐ 2) ์์น(๊ฒฐ๊ณผ)์ปจํธ๋กค๋ฌ์ ์ฌ์ฉ (๋ณต์กํ ๊ตฌํ ๊ฐ๋ฅ)
        //     ==> ๊ธ์๋ง๋ค ๊ฒ์ ๊ธฐ๋ฅ + ์๋ก์ด ํ๋ฉด์ ๋ณด์ฌ์ฃผ๋ ๊ฒ๋ ๊ฐ๋ฅ
        searchController.searchResultsUpdater = self
        
        // ์ฒซ๊ธ์ ๋๋ฌธ์ ์ค์  ์์ ๊ธฐ
        searchController.searchBar.autocapitalizationType = .none
    }
    
    
    func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    
    func setupDatas() {
        //๋คํธ์ํน์ ์์
        
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            
            switch result {
            case Result.success(let musicData):
                
                self.musicArrays = musicData
                
                //self.myTableView.reloadData()
                
                //main์ฐ๋ ๋์์ ๋ถ๋ฌ์ค๊ธฐ
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
                break
                
                
            case Result.failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}




extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MyMusicTableViewCell
        
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
        
        // ์ ํ
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    // ํ์ด๋ธ๋ทฐ ์์ ๋์ด๋ฅผ ์ ๋์ ์ผ๋ก ์กฐ์ ํ๊ณ  ์ถ๋ค๋ฉด ๊ตฌํํ  ์ ์๋ ๋ฉ์๋
    // (musicTableView.rowHeight = 120 ๋์ ์ ์ฌ์ฉ๊ฐ๋ฅ)
    // heightForRowAt ์ ํํ ๋์ด estimatedHeightForRowAt ์ถ์ ๋ ๋์ด
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 120
    //    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ViewController: UISearchResultsUpdating {
    // ๊ธ์ ์๋ ฅํ ๋๋ง๋ค ํธ์ถ๋๋ ๋ฉ์๋ -> ๋ค๋ฅธํ๋ฉด ๋ณด์ฌ์ค๋ ๊ตฌ์ฑ
    func updateSearchResults(for searchController: UISearchController) {
        print("์์น๋ฐ์ ์๋ ฅ๋๋ ๋จ์ด", searchController.searchBar.text ?? "")
        
        // ๊ธ์๋ฅผ ์น๋ ์๊ฐ์ ๋ค๋ฅธ ํ๋ฉด์ ๋ณด์ฌ์ฃผ๊ณ  ์ถ์๋ ์ปฌ๋ ์๋ทฐ ๋ณด์ด๊ธฐ
        let vc = searchController.searchResultsController as! SearchResultViewController
        //์ปฌ๋ ์๋ทฐ์ ์ฐพ์ผ๋ ค๋ ๋จ์ด ์ ๋ฌ
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}


