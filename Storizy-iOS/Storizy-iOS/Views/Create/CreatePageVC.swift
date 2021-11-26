//
//  CreatePageVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit
import TTGTagCollectionView

class CreatePageVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var projectSelectView: UITextField!
    @IBOutlet weak var pageTitleTF: UITextField!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var doneBTN: UIButton!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    
    var tagColorTTGCV = TTGTextTagCollectionView()
    let picker = UIPickerView()
    
    var tagDatas: [TagData] = [] {
        didSet {
            tagCV.reloadData()
        }
    }
    var tagIds: [Int] = []
    
    var projectList: [String] = ["오늘의 옷장"] // 프로젝트 id + name 구조체로 대체
    var projectId = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerNib()
        configPickerView()
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
    @IBAction func completeAction(_ sender: Any) {
        // 결과 수집
        tagIds = tagDatas.map({ $0.id ?? 0 })

        let pageRequest = PageRequest(title: pageTitleTF.text,
                                      content: contentTV.text,
                                      startDate: getDateString(startDate),
                                      endDate: getDateString(endDate),
                                      isPublic: true,
                                      projectId: 8, //temp
                                      tagIds: tagIds,
                                      pageImages: [])
        // API
        CreatePageService.shared.createPage(accessToken: accessToken, pageRequest: pageRequest) {(responseCode, responseBody) in
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
        
    }
    
    
    // MARK: - date picker
    func getDateString(_ datePicker: UIDatePicker) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: datePicker.date)
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
        frameUI(projectSelectView)
        frameUI(pageTitleTF)
        // 내용 칸
        contentTV.layer.cornerRadius = 12
        contentTV.textContainerInset = UIEdgeInsets(top: 12, left: 6,bottom: 12,right: 12)
        // 완료 버튼
        doneBTN.layer.cornerRadius = 12
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - 컬러 CV
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
    

}

// MARK: - Collection View
extension CreatePageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 이미지
        if collectionView == imageCV {
            return 1
        }
        // 태그
        else {
            return tagDatas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 이미지
        if collectionView == imageCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatePageImgCell", for: indexPath) as! CreatePageImgCell
            cell.imageView.layer.cornerRadius = 10
            return cell
        }
        // 태그
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as! StoryTagCell
            let tag = tagDatas[indexPath.item]
            cell.tagNameLB.text = tag.tagName
            cell.frameView.backgroundColor = UIColor(named: "\(tag.tagColor ?? "tag_green")-light")
            cell.tagNameLB.textColor = UIColor(named: tag.tagColor ?? "tag_green")
            return cell
        }
    }
}

// 프로젝트 선택 피커 뷰
extension CreatePageVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        projectSelectView.inputView = picker
        configToolbar()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projectList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projectList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 선택 됐을 때 : 프로젝트 아이디 저장
        self.projectSelectView.text = self.projectList[row]
    }
    
    func configToolbar() {
        // toolbar를 만들어준다.
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "black")
        toolBar.sizeToFit()
        // 만들어줄 버튼
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        // 만든 아이템들을 세팅해주고
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        // 악세사리로 추가한다.
        projectSelectView.inputAccessoryView = toolBar
        
    }
    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.projectSelectView.text = self.projectList[row]
        self.projectSelectView.resignFirstResponder()
        
    }
    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.projectSelectView.text = ""
        self.projectSelectView.resignFirstResponder()
    }
}



class CreatePageImgCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

