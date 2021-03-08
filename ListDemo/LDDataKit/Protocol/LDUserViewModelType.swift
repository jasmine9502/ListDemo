//
//  LDUserViewModelType.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/4.
//

import Foundation

protocol LDUserViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

