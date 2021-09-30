//
//  CovidVO.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//

import Foundation

struct CovidVO: Decodable{
    let id: String
    let area: String
    let date: String
    let history: String
    
    enum CodingKeys: String, CodingKey {
        case id = "CORONA19_ID"
        case area = "CORONA19_AREA"
        case date = "CORONA19_DATE"
        case history = "CORONA19_CONTACT_HISORY"
    }
}
