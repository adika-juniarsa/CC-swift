//
//  Login.swift
//
//  Created by febi on 9/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Login: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let authToken = "auth_token"
    static let notice = "notice"
  }

  // MARK: Properties
  public var status: Bool? = false
  public var authToken: String?
  public var notice: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    status = json[SerializationKeys.status].boolValue
    authToken = json[SerializationKeys.authToken].string
    notice = json[SerializationKeys.notice].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.status] = status
    if let value = authToken { dictionary[SerializationKeys.authToken] = value }
    if let value = notice { dictionary[SerializationKeys.notice] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeBool(forKey: SerializationKeys.status)
    self.authToken = aDecoder.decodeObject(forKey: SerializationKeys.authToken) as? String
    self.notice = aDecoder.decodeObject(forKey: SerializationKeys.notice) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(authToken, forKey: SerializationKeys.authToken)
    aCoder.encode(notice, forKey: SerializationKeys.notice)
  }

}
