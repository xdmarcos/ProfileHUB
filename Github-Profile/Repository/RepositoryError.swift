// 
// RepositoryError.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

enum RepositoryError: Error {
	case generic(error: Error)
	case graphQL(messsage: String)
}
