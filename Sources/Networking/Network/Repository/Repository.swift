//
//  Repository.swift
//  Home
//
//  Created by Srikanth on 10/17/21.
//

import Foundation

public protocol Repository {
	associatedtype RepositoryType
	func fetch(_ endpoint: EndPoint, completion: @escaping (Result<RepositoryType, Error>) -> Void)
}
