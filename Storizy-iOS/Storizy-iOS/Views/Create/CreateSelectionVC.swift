//
//  CreateSelectionVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit

class CreateSelectionVC: UIViewController {

    // components
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var pageCreateCell: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()     //UI
    }
    
    // 프로젝트 생성 버튼 클릭
    @IBAction func projectCreateSelectAction(_ sender: Any) {
        print("clicke")
        let createProjectVC = self.storyboard?.instantiateViewController(identifier: "CreateProjectVC") as! CreateProjectVC
        self.navigationController?.pushViewController(createProjectVC, animated: true)

    }
    
    // 페이지 생성 버튼 클릭
    @IBAction func pageCreateSelectAction(_ sender: Any) {
        let createPageVC = self.storyboard?.instantiateViewController(identifier: "CreatePageVC") as! CreatePageVC
        self.navigationController?.pushViewController(createPageVC, animated: true)
    }
    
    // MARK: - UI
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        // page cell 둥글
        pageCreateCell.layer.cornerRadius = 20
    }
}
