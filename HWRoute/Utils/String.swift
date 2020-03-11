// Copyright SIX DAY LLC. All rights reserved.

import Foundation

extension String {
    var hex: String {
        let data = self.data(using: .utf8)!
        return data.map { String(format: "%02x", $0) }.joined()
    }

    var hexEncoded: String {
        let data = self.data(using: .utf8)!
        return data.hexEncoded
    }

    var isHexEncoded: Bool {
        guard starts(with: "0x") else {
            return false
        }
        let regex = try! NSRegularExpression(pattern: "^0x[0-9A-Fa-f]*$")
        if regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).isEmpty {
            return false
        }
        return true
    }

    var doubleValue: Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.decimalSeparator = "."
        if let result = formatter.number(from: self) {
            return result.doubleValue
        } else {
            formatter.decimalSeparator = ","
            if let result = formatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }

    var toBase64: String {
        
        let data:Data = self.data(using: String.Encoding.utf8)!
        return data.base64EncodedString(options: [Data.Base64EncodingOptions.init(rawValue: 0)])
    }
    
    var base64ToString: String {
        let data: Data? = Data(base64Encoded: self)
        if data == nil {
            return ""
        }
        return String.init(data: data!, encoding: String.Encoding.utf8) ?? ""
    }
    
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    var asDictionary: [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
                return [:]
            }
        }
        return [:]
    }

    var drop0x: String {
        if self.count > 2 && self.substring(with: Range.init(from: 0, to: 2)) == "0x" {
            return String(self.dropFirst(2))
        }
        return self
    }

    var add0x: String {
        return "0x" + self
    }
    
    //16进制字符串转换二进制后转data
    func hexadecimal() -> Data? {
        var data = Data(capacity: self.count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    
    func hexToString() -> String {
        var string = String.init(format: "%@", self)
        string = string.replacingOccurrences(of: "0x", with: "")
        var location: Int = 0
        for subs in string {
            if subs == "0" {
                location += 1
            }else{
                break
            }
        }
        let hexString = string.substring(from: location)
        return hexString.hexTodecString()
    }
    
    var isValidSha3Hash: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "0x[a-fA-F0-9]{64}")
            let results = regex.matches(in: self, range: NSRange(startIndex..., in: self))
            return results.count == 1
        } catch let error {
            fatalError("invalid regex: \(error.localizedDescription)")
        }
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range) -> String {
        let startIndex = index(from: Int(r.from))
        let endIndex = index(from: Int(r.to))
        return String(self[startIndex..<endIndex])
    }
    
    var asPossibleURLString: String? {
        if self.contains("://") && !self.hasSuffix("://") {
            // Already a possible url string if it has a `://` somewhere in it that is not the last character.
            return self
        }
        
        // Definitely can't be turned into a URL string if no `.` plus at least one other character
        guard self.contains("."), !self.hasSuffix(".") else {  return nil  }
        
        return "http://" + self
    }
}
