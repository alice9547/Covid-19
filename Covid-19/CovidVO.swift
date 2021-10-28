//
//  CovidVO.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//

import Foundation

let testX = "test"
let jsonData = """
{"Corona19Status":{"list_total_count":117358,"RESULT":{"CODE":"INFO-000","MESSAGE":"정상 처리되었습니다"},"row":[{"CORONA19_ID":"117358","CORONA19_DATE":"2021-10-27","CORONA19_NO":"","CORONA19_COUNTRY":"","CORONA19_PERSONAL":"","CORONA19_AREA":"구로구","CORONA19_TRAVEL_HISTORY":"","CORONA19_CONTACT_HISTORY":"강동구 소재 병원 관련('21.10.(2))","CORONA19_CORRECTIVE":"","CORONA19_LEAVE_STATUS":"-","CORONA19_MOVING_PATH":"","CORONA19_IDATE":"2021-10-28 09:41:52","CORONA19_MDATE":"2021-10-28 09:41:52"},{"CORONA19_ID":"117357","CORONA19_DATE":"2021-10-27","CORONA19_NO":"","CORONA19_COUNTRY":"","CORONA19_PERSONAL":"","CORONA19_AREA":"구로구","CORONA19_TRAVEL_HISTORY":"","CORONA19_CONTACT_HISTORY":"기타 확진자 접촉","CORONA19_CORRECTIVE":"","CORONA19_LEAVE_STATUS":"-","CORONA19_MOVING_PATH":"","CORONA19_IDATE":"2021-10-28 09:41:52","CORONA19_MDATE":"2021-10-28 09:41:52"},{"CORONA19_ID":"117356","CORONA19_DATE":"2021-10-27","CORONA19_NO":"","CORONA19_COUNTRY":"","CORONA19_PERSONAL":"","CORONA19_AREA":"타시도","CORONA19_TRAVEL_HISTORY":"","CORONA19_CONTACT_HISTORY":"감염경로 조사중","CORONA19_CORRECTIVE":"","CORONA19_LEAVE_STATUS":"-","CORONA19_MOVING_PATH":"","CORONA19_IDATE":"2021-10-28 09:41:52","CORONA19_MDATE":"2021-10-28 09:41:52"}]}}
""".data(using: .utf8)!

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
