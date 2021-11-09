//
//  ExploreUnsearchedVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ExploreUnsearchedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var recommPages: [Page] = [Page(title: "추천 페이지 1"), Page(title: "추천페이지 2"), Page(title: "추천 페이지 3"), Page(title: "추천페이지 4"), Page(title: "추천페이지 5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nib 등록
        let nibName = UINib(nibName: "HeartPageCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HeartPageCell")
        
        // table view - scroll view
        DispatchQueue.main.async {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        }

    }
    
    // 검색 바 클릭
    @IBAction func searchBarBtnAction(_ sender: Any) {
        let exploreSearchedVC = self.storyboard?.instantiateViewController(identifier: "ExploreSearchedVC") as! ExploreSearchedVC
        self.navigationController?.pushViewController(exploreSearchedVC, animated: false)
    }
    

}


extension ExploreUnsearchedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeartPageCell") as! HeartPageCell
        return cell
    }
}
