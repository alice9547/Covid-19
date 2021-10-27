//
//  CovidVO.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//

import Foundation

struct Row: Decodable{
    let id: String
    let area: String
    let date: String
    let history: String
    
    enum CodingKeys: String, CodingKey {
        case id = "CORONA19_ID"
        case area = "CORONA19_AREA"
        case date = "CORONA19_DATE"
        case history = "CORONA19_CONTACT_HISTORY"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(String.self, forKey: .id)) ?? "--id"
        area = (try? values.decode(String.self, forKey: .area)) ?? "--area"
        date = (try? values.decode(String.self, forKey: .date)) ?? "--date"
        history = (try? values.decode(String.self, forKey: .history)) ?? "--history"
    }
}

struct Corona19Status: Decodable{
    let row: [Row]
}

struct CovidVO: Decodable{
    let corona19Status: Corona19Status
    
    enum CodingKeys: String, CodingKey {
        case corona19Status = "Corona19Status"
    }
}
