//
//  URLSession+fetch.swift
//  Home
//
//  Created by Srikanth on 10/17/21.
//

import Foundation
import OSLog

public protocol Session {
	func fetch<T: Decodable>(_ endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void)
}

@available(macOS 11.0, *)
extension URLSession: Session {
	public func fetch<T>(_ endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
		
		let request = URLRequest(endpoint: endpoint)
		Self.shared.dataTask(with: request) { data, response, error in
			do {
				if let error = error {
					Logger.log.error("Error - \(error.localizedDescription)")
					completion(.failure(error))
					return
				}
				
				guard let data = data else {
					Logger.log.error("Error - No error was received but we also don't have data...")
					preconditionFailure("No error was received but we also don't have data...")
				}
				
				Logger.log.info("\nResponse: \(String(data: data, encoding: .utf8)!)")
				let decodedObject = try JSONDecoder().decode(T.self, from: data)
				completion(.success(decodedObject))
			} catch {
				Logger.log.error("Error - \(error.localizedDescription)")
				completion(.failure(error))
			}
		}.resume()
	}
}

@available(macOS 11.0, *)
extension Logger {
	static var log: Logger {
		return Logger(
			subsystem: Bundle.main.bundlePath,
			category: "\(Self.self)"
		)
	}
}
