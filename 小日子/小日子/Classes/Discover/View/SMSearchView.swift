//
//  SMSearchView.swift
//  小日子
//
//  Created by mike on 16/3/29.
//  Copyright © 2016年 MK. All rights reserved.
//

import UIKit

class SMSearchView: UIView {


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchTextField.delegate = self
        setupSubView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchButton?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(53)
            make.height.equalTo(subViewH)
            make.right.equalTo(self.snp_right).offset (-margin)
        })
        
          searchTextField.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.left.equalTo(self.snp_left).offset(margin)
            make.height.equalTo(subViewH)
            make.right.equalTo(self.searchButton!.snp_left).offset (-2)
        }
        
        
    }
    //MARK:- 添加子控件
    func setupSubView() {
        addSubview(searchTextField)
        searchButton = SMSearchButton( target: self, action: "searchButtonClick:")
        addSubview(searchButton!)
    }
    
    //MARK:- 搜索按钮点击
    func searchButtonClick(button: UIButton) {
        self.endEditing(false)
        if (searchTextField.text == "") {
             delegate?.searchViewButtonClick(self, keyText: "", button: button)
            return
        }
        button.selected = !button.selected
        if button.selected {
        delegate?.searchViewButtonClick(self, keyText: searchTextField.text!, button: button)
        }else {
            delegate?.searechviewCancel(self, button: button)
            searchTextField.text = ""
            
        }
    }
    
    func chanegeSearViewState(keyText: String){
        searchButton?.selected = true
        searchTextField.text = keyText
    }
    
    
    var searchTextField = SMSearchTextField()
    var searchButton : SMSearchButton?
    var margin : CGFloat = 10
    var subViewH: CGFloat = 27
    weak var delegate: SMSearchViewDelegate?

}

//MARK:- searchTextField代理方法
extension SMSearchView: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        searchButton?.selected = false
       delegate?.searechviewCancel(self, button: searchButton! )
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        searchButton?.selected = false
       delegate?.searechviewCancel(self, button: searchButton!)
        return true
    }
}

//MARK:- SearchView代理方法
protocol SMSearchViewDelegate: NSObjectProtocol {
    func searchViewButtonClick(searchView: SMSearchView, keyText: String, button: UIButton)
    func searechviewCancel(searchView: SMSearchView,button: UIButton)
}
