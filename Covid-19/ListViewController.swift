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
    var txtpick:String?
    
    @IBOutlet weak var txtGu: UITextField!
    @IBAction func btnPick(_ sender: Any) {
        txtpick = txtGu.text
        callCovidAPI()
        self.pickGu()
        print("\(txtpick!)버튼 선택")
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        callCovidAPI()
        pickGu()
    }

    // MARK: - Table view data source
    func callCovidAPI() {
        let url = "http://openapi.seoul.go.kr:8088/786377506d616c6932335a4b417249/json/Corona19Status/1/100"
        let apiURI: URL! = URL(string: url)
//서버불안정할때
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
        if txtpick != nil{
            for row in covidData{
                if row.area==txtGu.text{
                    pickData.append(row)
                }
            }
            print("pickGu실행")
        }
        else{
            for row in covidData{
                pickData.append(row)
            }
        }
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
