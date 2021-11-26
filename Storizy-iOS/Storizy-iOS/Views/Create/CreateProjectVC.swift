//
//  CreateProjectVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit
import TTGTagCollectionView

let colors: [String] = ["tag_red","tag_orange","tag_yellow","tag_green","tag_blue","tag_violet","tag_pink"]

class CreateProjectVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var colorCV: UICollectionView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var publicBTN: UIButton!
    @IBOutlet weak var startDataPicker: UIDatePicker!
    @IBOutlet weak var endDataPicker: UIDatePicker!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var doneBTN: UIButton!
    
    var colorTTGCV =  TTGTextTagCollectionView()
    var tagColorTTGCV = TTGTextTagCollectionView()
    
    var tagDatas: [TagData] = [] {
        didSet {
            tagCV.reloadData()
        }
    }
    var tagIds: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerNib()
        setColorTTGCV()
    }
    
    // 프로젝트 컬러 선택 뷰 셋팅
    func setColorTTGCV(){
        colorTTGCV = TTGTextTagCollectionView.init(frame: CGRect.init(x: 30 , y: headBarView.bounds.maxY + 22, width: view.bounds.width - 60 , height: 24))
        
        setColorCV(colorTTGCV)
        self.view.addSubview(colorTTGCV)
    }
    
    // 컬러 CV
    func setColorCV(_ TTGCV: TTGTextTagCollectionView){
        TTGCV.numberOfLines = 1
        TTGCV.enableTagSelection = true
        TTGCV.selectionLimit = 1
        TTGCV.alignment = .left
        TTGCV.horizontalSpacing = CGFloat(8)
        
        for color in colors {
            let content = TTGTextTagStringContent.init(text: "")
            content.textFont = UIFont.systemFont(ofSize: 14)
            
            let normalStyle = TTGTextTagStyle.init()
            normalStyle.backgroundColor = UIColor(named: color) ?? UIColor.black
            normalStyle.extraSpace = CGSize.init(width: 20, height: 20)
            normalStyle.shadowOpacity = 0
            normalStyle.cornerRadius = 10
            
            let selectedStyle = TTGTextTagStyle.init()
            selectedStyle.backgroundColor = UIColor(named: color) ?? UIColor.black
            selectedStyle.extraSpace = CGSize.init(width: 20, height: 20)
            selectedStyle.shadowOpacity = 0
            selectedStyle.cornerRadius = 10
            selectedStyle.borderWidth = 2
            selectedStyle.borderColor = UIColor(named: "black") ?? UIColor.black

            let colorT = TTGTextTag.init()
            colorT.content = content
            colorT.style = normalStyle
            colorT.selectedStyle = selectedStyle
            TTGCV.addTag(colorT)
        }
        TTGCV.reload()
    }
    // date picker
    func getDateString(_ datePicker: UIDatePicker) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: datePicker.date))
        return formatter.string(from: datePicker.date)
    }
    
    // MARK: - Button Action
    // 태그 추가
    @IBAction func addTagAction(_ sender: Any) {
        // alert view
        let alert = UIAlertController(title: "태그 추가", message: "\n", preferredStyle: .alert)
        
        tagColorTTGCV = TTGTextTagCollectionView.init(frame: CGRect.init(x: alert.view.bounds.minX + 15 , y: 47, width: alert.view.bounds.width - 60 , height: 24))
        setColorCV(tagColorTTGCV)
        alert.view.addSubview(tagColorTTGCV)
        
        alert.addTextField { textView in
            textView.frame = CGRect(x: alert.view.bounds.minX + 30, y: self.tagColorTTGCV.bounds.maxY + 5, width: alert.view.bounds.width - 60 , height: 44)
        }
        
        // action
        // 태그 등록
        let done = UIAlertAction(title: "확인", style: .default) { action in
            let tagName = alert.textFields?[0].text
            let tagColor = Int(self.tagColorTTGCV.allSelectedTags()[0].tagId) % 7 + 1
            
            // 태그 등록 요청 + 응답 받기
            CreateColorTagService.shared.createColorTag(accessToken: accessToken, tagName: tagName ?? "", tagColorId: tagColor) { (responseCode, responseBody) in
                if responseCode == .success {
                    print(responseCode, responseBody)
                    guard let body = responseBody as? ResponseData<TagData> else {return}
                    guard let tag = body.data else {return}
                    self.tagDatas.append(tag)
                } else {
                    print(responseCode, responseBody)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
        }
        
        alert.addAction(cancel)
        alert.addAction(done)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 완료
    @IBAction func doneAction(_ sender: Any) {
        // 결과 수집
        tagIds = tagDatas.map({ $0.id ?? 0 })
        let colorId = Int(self.colorTTGCV.allSelectedTags()[0].tagId) % 7 + 1

        let projectRequest = ProjectRequest(title: titleTF.text,
                                            description: contentTV.text,
                                            startDate: getDateString(startDataPicker),
                                            endDate: getDateString(endDataPicker),
                                            isPublic: true,
                                            projectColorId: colorId,
                                            tagIds: tagIds)
        // 전송
        CreateProjectService.shared.createProject(accessToken: accessToken, projectRequest: projectRequest) {(responseCode, responseBody) in
            if responseCode == .success {
                print(responseCode, responseBody)
                self.tabBarController?.selectedViewController = self.tabBarController?.children[0]
                self.navigationController?.popViewController(animated: true)
            } else {
                print(responseCode, responseBody)
                // 실패 alert
                //temp
                self.tabBarController?.selectedViewController = self.tabBarController?.children[0]
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.tabBarController?.selectedViewController = self.tabBarController?.children[0]
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// 태그
extension CreateProjectVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as? StoryTagCell else { return UICollectionViewCell() }
        let tag = tagDatas[indexPath.item]
        print(tag)
        cell.tagNameLB.text = tag.tagName
        cell.frameView.backgroundColor = UIColor(named: "\(tag.tagColor ?? "tag_green")-light")
        print("\(tag.tagColor ?? "tag_green")-light")
        cell.tagNameLB.textColor = UIColor(named: tag.tagColor ?? "tag_green")
        return cell
    }
    
    
}
