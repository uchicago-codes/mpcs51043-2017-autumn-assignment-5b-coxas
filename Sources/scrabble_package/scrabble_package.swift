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
