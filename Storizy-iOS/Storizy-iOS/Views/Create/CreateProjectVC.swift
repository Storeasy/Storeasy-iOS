//
//  CreateProjectVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit

class CreateProjectVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var colorCV: UICollectionView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var publicBTN: UIButton!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var doneBTN: UIButton!
    
    
    var tags: [String] = ["러시아워","유기현최고"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerNib()
    }
    
    
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 완료
    @IBAction func doneAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Nib
    func registerNib(){
        let storyTagNibName = UINib(nibName: "StoryTagCell", bundle: nil)
        tagCV.register(storyTagNibName, forCellWithReuseIdentifier: "StoryTagCell")
    }
    
    
    // MARK: - UI
    
    func frameUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
        view.clipsToBounds = true
    }
    
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        // 입력 칸 테두리
        frameUI(titleTF)
        // 내용 칸
        contentTV.layer.cornerRadius = 12
        contentTV.textContainerInset = UIEdgeInsets(top: 12, left: 6,bottom: 12,right: 12)
        // 완료 버튼
        doneBTN.layer.cornerRadius = 12
    }

}


extension CreateProjectVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as? StoryTagCell else { return UICollectionViewCell() }
        cell.tagNameLB.text = tags[indexPath.item]
        // ui
        cell.frameView.backgroundColor = UIColor(named: "tag_orange-light")
        cell.tagNameLB.textColor = UIColor(named: "tag_orange")
        return cell
    }
    
    
}
