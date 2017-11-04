import Foundation

public func createDict(path: String) -> [String: String] {
    var morseDict = [String: String]()
    let data = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
    let lines = data.components(separatedBy: CharacterSet.newlines)

    for line in lines {
        // setting i equal to the key (first char of line)
        let i = line.index(line.startIndex, offsetBy: 0)
        // due to problems separating key/val pairs by colons and trimming whitespaces, manually adding vals for colon and space characters--was having hard time figuring out a non-manual way to do it
        if line[i] == " " {
            morseDict[String(line[i])] = "/"
        }
        if line[i] == ":" {
            morseDict[String(line[i])] = "---..."
        }
        else {
            let keyval = line.components(separatedBy: ":")
            let key = String(keyval[0])
            let val = String(keyval[1])
            var trimmedVal = val.replacingOccurrences(of: ",", with: "", options: .regularExpression)
            let trimmedKey = key.trimmingCharacters(in: .whitespaces)
            trimmedVal = trimmedVal.trimmingCharacters(in: .whitespaces)
            morseDict[trimmedKey] = trimmedVal 
        }
    }
return(morseDict)
}


public func encode(message: String) -> String {
    let morseDict = createDict(path:"morse_code.txt")
    let message = message.uppercased()
    var result = ""
    for char in message {
        let key = String(char)
        if let val = morseDict[key] {
            result.append(val + " ")
        }
        else {
            result = "Invalid Input"
        }
    }
return(result)
}


public func decode(message: String) -> String {
    let morseDict = createDict(path: "morse_code.txt")
    var result = ""
    let letters = message.components(separatedBy: " ")
    for letter in letters {
        for keyval in morseDict {
            if keyval.value == letter {
                let key = keyval.key
                result.append(key)
            }
        }
    }
return(result)
}   

