//
//  EndPoint.swift
//  Networking
//
//  Created by Srikanth on 10/17/21.
//

import Foundation

public protocol EndPointString {
	var baseUrlString: String { get }
}

public enum EndPoint: String {
	case mock = "mock.json"
}

extension EndPoint: EndPointString {
	public var baseUrlString: String {
		return "https://e4e8b799-096f-418c-956d-b73965ddb835.mock.pstmn.io/"
	}
}
