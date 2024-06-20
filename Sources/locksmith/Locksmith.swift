//
//  Locksmith.swift
//
//
//  Created by Eren Kabakci
//

import Foundation

public protocol LocksmithProtocol {
  func save<T>(key: String, value: T) where T : Codable
  func read<T>(key:String, forType: T.Type) -> T? where T : Codable
  func delete(key: String)
}

public class Locksmith: LocksmithProtocol {
  private let service: String
  private let accessGroup: String?

  public init(service: String? = nil, accessGroup: String? = nil) {
    self.service = service ?? "com.keychainStorage.service"
    self.accessGroup = accessGroup
  }

  public func save<T>(key: String, value: T) where T : Codable {
    do { // Encode as JSON data and save in keychain
      let data = try JSONEncoder().encode(value)
      save(data, key: key)
    } catch {
      assertionFailure("Fail to encode item for keychain: \(error)")
    }
  }

  public func read<T>(key: String, forType: T.Type) -> T? where T : Codable {
    guard let data = read(account: key) else { return nil }

    do { // Decode JSON data to object
      let item = try JSONDecoder().decode(forType, from: data)
      return item
    } catch {
      assertionFailure("Fail to decode item for keychain: \(error)")
      return nil
    }
  }

  public func delete(key: String) {
    SecItemDelete(query(account: key)) // Delete item from keychain
  }

  private func save(_ data: Data, key: String) {
    let status = SecItemAdd(queryWithData(data: data, account: key), nil)
    if status == errSecDuplicateItem {
      SecItemUpdate(query(account: key), [kSecValueData: data] as CFDictionary)
    }
  }

  private func read(account: String) -> Data? {
    var result: AnyObject?
    SecItemCopyMatching(queryRead(account: account), &result)
    return (result as? Data)
  }

  private func queryRead(account: String) -> CFDictionary {
    var query: [String: Any] = [
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecClass as String: kSecClassGenericPassword,
      kSecReturnData as String: true,
      kSecAttrSynchronizable as String: kSecAttrSynchronizableAny,
    ]

#if !targetEnvironment(simulator)
    if let group = accessGroup {
      query[kSecAttrAccessGroup as String] = group
    }
#endif

    return query as CFDictionary
  }

  private func query(account: String) -> CFDictionary {
    var query: [String: Any] = [
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrSynchronizable as String: kSecAttrSynchronizableAny,
    ]

#if !targetEnvironment(simulator)
    if let group = accessGroup {
      query[kSecAttrAccessGroup as String] = group
    }
#endif

    return query as CFDictionary
  }

  private func queryWithData(data: Data, account: String) -> CFDictionary {
    var query: [String: Any] = [
      kSecValueData as String: data,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrSynchronizable as String: kSecAttrSynchronizableAny,
    ]

#if !targetEnvironment(simulator)
    if let group = accessGroup {
      query[kSecAttrAccessGroup as String] = group
    }
#endif

    return query as CFDictionary
  }
}
