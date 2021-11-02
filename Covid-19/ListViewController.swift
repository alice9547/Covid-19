//
//  ListViewController.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//

import UIKit

class ListViewController: UITableViewController {
    var covidData:[Row] = []
    var pickData:[Row] = []
    var txtpick:String? = nil
    
    @IBOutlet weak var txtGu: UITextField!
    @IBAction func btnPick(_ sender: Any) {
        pickData = []
        txtpick = txtGu.text
        
        pickGu()
        
        print("\(txtpick!)버튼 선택")
        self.tableView.reloadData()
    }
    @IBAction func btnReset(_ sender: Any) {
        pickData = []
        txtpick = nil
        
        pickGu()
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callCovidAPI()
        self.pickGu()
    }

    // MARK: - Table view data source
    func callCovidAPI() {
        let url = "http://openapi.seoul.go.kr:8088/786377506d616c6932335a4b417249/json/Corona19Status/1/100"
        let apiURI: URL! = URL(string: url)
//서버 불안정 할 때 jsonData로 사용
        let apidata = try! Data(contentsOf:apiURI)
        
        let decoder = JSONDecoder()
        do{
            let result = try decoder.decode(CovidVO.self,from: apidata)
            covidData = result.corona19Status.row

            print("apidata는 받음")
            
        } catch {
            print(error)
        }
}
    func pickGu() {
        if txtpick == nil{
            for row in covidData{
                pickData.append(row)
            }
        } else {
            for row in covidData{
                if row.area == txtpick{
                    pickData.append(row)
                }
            }
        }

        print("pickGu 호출")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.pickData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! CovidCell

        cell.id?.text = row.id
        cell.area?.text = row.area
        cell.date?.text = row.date
        cell.history?.text = row.history

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행이다.")
    }

}
