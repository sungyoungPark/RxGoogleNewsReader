//
//  ViewModelBindableType .swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel : ViewModelType! { get set }
    func bindViewModel()
    
}


extension ViewModelBindableType where Self: UIViewController{
    mutating func bind(viewModel : Self.ViewModelType){
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
