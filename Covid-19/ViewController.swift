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
    var newHJdate:[String] = []
    var tCovidData:[TotalRow] = []
    
    @IBOutlet weak var txtdate: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    @IBOutlet weak var txtNew: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTotalAPI()
        // Do any additional setup after loading the view.
        fillText()
        
        barChartView.noDataText = "데이터가 없습니다."
                barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        setCharts(dataPoints: newHJdate, values: newHJ)
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
                newHJdate.append(r.date.substring(from: 5, to: 9))
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
    
//차트 그리기
    func setCharts(dataPoints: [String], values: [Int]){

        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<newHJdate.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        print(dataEntries[0])
        //정수형으로 변환
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let formatter = DefaultValueFormatter(formatter: format)

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "신규 확진자")
 
        // 차트 컬러
        chartDataSet.colors = [.systemOrange]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        
        //오른쪽 레이블 삭제
        barChartView.rightAxis.enabled = false
        //줌 비활성화
        barChartView.doubleTapToZoomEnabled = false
        // X축 레이블 위치 조정
        barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        // X축 레이블 갯수 최대로 설정
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
                
        barChartView.data = chartData
    }
}

//index로 문자열 자르기
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
        return ""
        }

    // Index 값 획득
    let startIndex = index(self.startIndex, offsetBy: from)
    let endIndex = index(self.startIndex, offsetBy: to + 1)
    // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문

    // 파싱
    return String(self[startIndex ..< endIndex])
    }
}
