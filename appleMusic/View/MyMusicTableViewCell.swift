//
//  MyMusicTableViewCell.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import UIKit

final class MyMusicTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var imageURL: String? {
        didSet {
            loadImage()
        }
    }
    
    //셀이 재사용 되기 전에 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //이미지가 바뀌는것처럼 보이는 현상을 없애기 위해서 실행함
        self.mainImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainImageView.contentMode = .scaleToFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //URL => 이미지 변환 메서드
    private func loadImage() {
        guard let urlString = self.imageURL, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard self.imageURL! == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
        
    }
}
