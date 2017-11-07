import Foundation

public let tileScore  = ["a": 1, "c": 3, "b": 3, "e": 1, "d": 2, "g": 2,
             "f": 4, "i": 1, "h": 4, "k": 5, "j": 8, "m": 3,
             "l": 1, "o": 1, "n": 1, "q": 10, "p": 3, "s": 1,
             "r": 1, "u": 1, "t": 1, "w": 4, "v": 4, "y": 4,
             "x": 8, "z": 10]

// create struct
public struct Word {
    public var line: String
    public var word: String.SubSequence
    public var score: Int
    public var def: String.SubSequence

    public init(line: String) {
        // separate word and def
        // string indexing taken from https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
        let start = line.index(line.startIndex, offsetBy: 0)
        let indexWord = line.index(line.startIndex, offsetBy: 3)
        let wordExtract = line[start..<indexWord]
        let defExtract = line[indexWord...]
        self.word = wordExtract
        self.def = defExtract
        self.line = line
        // calculate score
        var count = 0
        for char in self.word {
            let letter = String(char).lowercased()
            let val = tileScore[letter]!
            count += val
            
        }
        self.score = count
    }
}

extension Word: Equatable, Comparable {
    public static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.score == rhs.score 
    }

    public static func < (lhs: Word, rhs: Word) -> Bool {
        if lhs.score != rhs.score {
            return lhs.score < rhs.score
        } 
        else {
            return false
        }
    }
}

extension Word: CustomStringConvertible {
    public var description: String {
        return "Word: \(self.word) Score: \(self.score) Definition:\(self.def)"
    }
    
}

public enum InputError: Error {
    case invalidInput
}

public func readLetters(tiles: String) throws -> String {
    // remove any commas from input
    var letters = tiles.replacingOccurrences(of:",", with:"")
    // remove any spaces from input
    letters = letters.replacingOccurrences(of:" ", with:"")
    letters = letters.uppercased()
    // check for letter only input
    let validInput = "[A-Z]"   
    let regexLetters = try! NSRegularExpression(pattern: validInput, options: [])
    let numberMatchesLetters = regexLetters.matches(in: letters, range: NSMakeRange(0, letters.count))
    if numberMatchesLetters.count == letters.count {
        return(letters)
    } 
    else {
        throw InputError.invalidInput
    } 
}

public func getPotentialWords(letters: String) -> [String] {
    var potentialWords = [String]()
    for letter in letters {
        let letter_one = letter
        for letter in letters {
            let letter_two = letter 
            for letter in letters {
                let letter_three = letter
                let word = String(letter_one) + String(letter_two) + String(letter_three)
                if potentialWords.contains(word) == false {
                    potentialWords.append(word)
                }
            }
        }
    }
    return(potentialWords)
}

public func getRealWords(realWordList: [Word], potentialWords: [String]) {
    var realWords = [String: Int]()
    for word in potentialWords {
        for result in results {
            if word == String(result.word) {
                let realWord = String(result.word)
                let score = result.score
                realWords[realWord] = score
            }
        }
    }
    for (k,v) in (Array(realWords).sorted {$1.1 < $0.1}) {
        print(k,v)
    }
}