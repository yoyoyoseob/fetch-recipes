//
//  ViewState.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 9/10/24.
//

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
}
