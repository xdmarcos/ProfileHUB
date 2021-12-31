//
// ProfileType.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

typealias UserProfile = UserProfileReposQuery.Data.User
typealias PinnedReposNode = UserProfileReposQuery.Data.User.PinnedItem.Node
typealias TopReposNode = UserProfileReposQuery.Data.User.TopRepository.Node
typealias StarredReposNode = UserProfileReposQuery.Data.User.StarredRepository.Node
typealias ProfileCompletion = (Result<UserProfileQueryResponse, Error>) -> Void
