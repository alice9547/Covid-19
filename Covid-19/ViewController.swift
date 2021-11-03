//
//  ViewController.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//
import Foundation
import UIKit
import Charts

class ViewController: UIViewController {

    var newHJ:[Int] = []
    var tCovidData:[TotalRow] = []
    
    @IBOutlet weak var txtdate: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    @IBOutlet weak var txtNew: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTotalAPI()
        // Do any additional setup after loading the view.
        fillText()
    }
    
//apiData받기
    func callTotalAPI(){
        let tUrl = "http://openapi.seoul.go.kr:8088/6676465568616c6935335a63596e50/json/TbCorona19CountStatus/1/7"
        let tApiURI: URL! = URL(string: tUrl)
        let tApidata = try! Data(contentsOf:tApiURI)
        
        let decoder = JSONDecoder()
        do{
            let result = try decoder.decode(TotalVO.self,from: tApidata)
            tCovidData = result.tb.totalRow
            
            for r in tCovidData{
                newHJ.append(Int(r.new) ?? 0)
            }
            
        } catch {
            print("\(error)\n실패")
        }
    }
    
    func fillText(){
        let intTotal = Int(tCovidData[0].total)
        let intNew = Int(tCovidData[0].new)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
            
        txtdate.text = tCovidData[0].date
        txtTotal.text = numberFormatter.string(for: intTotal)! + " 명"
        txtNew.text = numberFormatter.string(for: intNew)! + " 명"
    }
    
    func drawCharts(){
        
        var lineChartEntry = [ChartDataEntry]() // graph 에 보여줄 data array
                
             // chart data array 에 데이터 추가
//             for i in 0..<newHJ.count {
//                    let value = ChartDataEntry(x: i, y: newHJ[i])
//                    lineChartEntry.append(value)
//             }
//        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Number")
//             line1.colors = [NSUIColor.blue]
//                
//             let data = LineChartData()
//             data.addDataSet(line1)
//                
//             lineChartView.data = data
    }
}
