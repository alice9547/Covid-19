//
//  TotalVO.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/11/03.
//

import Foundation

struct TotalRow: Codable{
    let date: String
    let total: String
    let new: String
    
    enum CodingKeys: String, CodingKey {
        case date = "T_DT"
        case total = "T_HJ"
        case new = "N_HJ"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = (try? values.decode(String.self, forKey: .date)) ?? "--"
        total = (try? values.decode(String.self, forKey: .total)) ?? "--"
        new = (try? values.decode(String.self, forKey: .new)) ?? "--"
    }
}

struct TbCorona19CountStatus: Codable {
    let totalRow: [TotalRow]
    
    enum CodingKeys: String, CodingKey{
        case totalRow = "row"
    }
}

struct TotalVO: Codable {
    let tb:TbCorona19CountStatus
    
    enum CodingKeys:String, CodingKey{
        case tb = "TbCorona19CountStatus"
    }
}
