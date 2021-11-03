//
//  ViewController.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//

import UIKit
import Charts

class ViewController: UIViewController {

    var newHJ:[Int] = []
    var tCovidData:[TotalRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTotalAPI()
        // Do any additional setup after loading the view.
    }

    func callTotalAPI(){
        let tUrl = "http://openapi.seoul.go.kr:8088/6676465568616c6935335a63596e50/json/TbCorona19CountStatus/1/7"
        let tApiURI: URL! = URL(string: tUrl)
//서버 불안정 할 때 jsonData로 사용
        let tApidata = try! Data(contentsOf:tApiURI)
        
        let decoder = JSONDecoder()
        do{
            let result = try decoder.decode(TotalVO.self,from: tApidata)
            tCovidData = result.tb.totalRow

            
            
            print(tCovidData)
            
        } catch {
            print("\(error)\n실패")
        }
    }
}

