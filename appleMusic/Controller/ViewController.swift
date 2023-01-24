//
//  ViewController.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    // 네트워크 매니저 (싱글톤)
    var networkManager = NetworkManager.shared
    
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()

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
    

