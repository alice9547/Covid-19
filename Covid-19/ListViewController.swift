//
//  ListViewController.swift
//  Covid-19
//
//  Created by 소프트웨어컴퓨터 on 2021/09/25.
//

import UIKit

class ListViewController: UITableViewController {
    
    lazy var list: [CovidVO] = {
        var datalist = [CovidVO]()
        return datalist
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        callCovidAPI()
    }

    // MARK: - Table view data source
    func callCovidAPI() {
        let url = "http://openapi.seoul.go.kr:8088/786377506d616c6932335a4b417249/json/Corona19Status/1/10"
        let apiURI: URL! = URL(string: url)
        let apidata = try! Data(contentsOf:apiURI)
//        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        
        let decoder = JSONDecoder()

        do{
            let result = try decoder.decode(CovidVO.self,from: apidata)
            let covidData = result.corona19Status.row

            for row in covidData{
//                print(row.id)
                
            }
        } catch {
            print(error)
        }
        
//        do {
//            let decoder = JSONDecoder()
//            let jsonString = String(data: apidata, encoding: .utf8)
//            let data = jsonString?.data(using: .utf8)
//
//
//            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
//
//            let status = apiDictionary["Corona19Status"] as! NSDictionary
//            //let result = status["RESULT"] as! NSArray
//            let covid = status["row"] as! NSArray
//
//            for row in covid {
//                let r = row as! NSDictionary
//
//                let cvo = CovidVO()
//
//                cvo.id = r["CORONA19_ID"] as? String
//                cvo.area = r["CORONA19_AREA"] as? String
//                cvo.date = r["CORONA19_DATE"] as? String
//                cvo.history = r["CORONA19_CONTACT_HISTORY"] as? String
//
//                self.list.append(cvo)
//            }
//
//        } catch {}
//
}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! CovidCell

//        cell.id?.text = row.id
//        cell.area?.text = row.area
//        cell.date?.text = row.date
//        cell.history?.text = row.history

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행이다.")
    }

}
