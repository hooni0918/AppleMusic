//
//  ViewController.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    // 🍏 서치 컨트롤러 생성 ===> 네비게이션 아이템에 할당
    //    let searchController = UISearchController()
    
    // 🍎 서치 Results컨트롤러 ⭐️
    //let sear = UISearchController(searchResultsController: <#T##UIViewController?#>)
    
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    // 네트워크 매니저 (싱글톤)
    var networkManager = NetworkManager.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    // 서치바 셋팅
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        
        // 🍏 1) (단순)서치바의 사용
        //searchController.searchBar.delegate = self
        
        
        // 🍎 2) 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    
    func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    
    func setupDatas() {
        //네트워킹의 시작
        
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            
            switch result {
            case Result.success(let musicData):
                
                self.musicArrays = musicData
                
                //self.myTableView.reloadData()
                
                //main쓰레드에서 불러오기
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
        
        // 선택
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
    // (musicTableView.rowHeight = 120 대신에 사용가능)
    // heightForRowAt 정확한 높이 estimatedHeightForRowAt 추정된 높이
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 120
    //    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ViewController: UISearchResultsUpdating {
    // 글자 입력할때마다 호출되는 메서드 -> 다른화면 보여줄때 구성
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        
        // 글자를 치는 순간에 다른 화면을 보여주고 싶을때 컬렉션뷰 보이기
        let vc = searchController.searchResultsController as! SearchResultViewController
        //컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}


