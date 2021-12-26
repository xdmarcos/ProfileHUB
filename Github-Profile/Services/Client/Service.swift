// 
// Service.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

public protocol Service {
	var url: URL { get }
	var token: Token { get }
}
