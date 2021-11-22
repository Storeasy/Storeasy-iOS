//
//  HeartVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

// page, user 구분 상수
let PAGE: Int = 0
let USER: Int = 1

class HeartVC: UIViewController {
    
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var heartTableView: UITableView!
    
    var pages: [Page] = [Page(title: "프로젝트1")]
    var users: [User] = [User(name: "임수정"), User(name: "유기현")]
    var currentDatas: [Any] = []
    
    var type: Int? {
        didSet{
            // type 변경 시
            if type == PAGE {
                currentDatas = pages
            } else {
                currentDatas = users
            }
            heartTableView.reloadData()
        }
    }
    
    /*
     // CustomSegmentedControl
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
            didSet{
                interfaceSegmented.setButtonTitles(buttonTitles: ["페이지","사용자"])
                interfaceSegmented.selectorViewColor = .orange
                interfaceSegmented.selectorTextColor = .orange
                print(interfaceSegmented.selectedIndex)
                self.type = interfaceSegmented.selectedIndex
                print(type)
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 90, width: self.view.frame.width, height: 50), buttonTitle: ["페이지","사용자"])
//        codeSegmented.backgroundColor = .clear
//        view.addSubview(codeSegmented)
        
        // 페이지가 default
        type = PAGE
        
        registerNib()
        setUI()
    }
    
    // segment 변경시
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
    }
    
    // MARK: - Nib 등록
    func registerNib(){
        // 셀 등록
        let pageNibName = UINib(nibName: "HeartPageCell", bundle: nil)
        heartTableView.register(pageNibName, forCellReuseIdentifier: "HeartPageCell")
        let userNibName = UINib(nibName: "HeartUserCell", bundle: nil)
        heartTableView.register(userNibName, forCellReuseIdentifier: "HeartUserCell")
    }
    
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
    }

}

extension HeartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 페이지
        if type == PAGE {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartPageCell", for: indexPath) as! HeartPageCell
            return cell
        }
        
        // 사용자
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartUserCell", for: indexPath) as! HeartUserCell
            return cell
        }
    }
    
    // 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // 페이지
        if type == PAGE {
            let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
            let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
            self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
        }
        
        // 사용자
        else {
            let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
            let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC")
            self.navigationController?.pushViewController(otherHomeVC, animated: true)
        }
        
    }
    
}
