//
//  Constant.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import Foundation
import UIKit
// NameSpace 사용하기 - 데이터 영역에 저장하며 타입 상관없이 사용가능, 전역변수로도 사용가능함.

//API 문자열 묶음
public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}

//사용하게 될 Cell문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {}
    
}

// 컬렉션뷰 구성을 위한 설정

public struct CVCell {
    static let spacingWitdh: CGFloat = 1 // 셀간격
    static let cellColumns: CGFloat = 3 // 검색시 한번에 보여줄 cell 갯수
    private init() {}
}





