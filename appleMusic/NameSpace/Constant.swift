//
//  Constant.swift
//  appleMusic
//
//  Created by 이지훈 on 2023/01/21.
//

import Foundation
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


