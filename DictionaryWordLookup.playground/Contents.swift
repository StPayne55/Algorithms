/*
    Task 1: Create a way to return a word in a dictionary from user input regardless of case.
            For example: If the word "Dog" is in the dictionary, and the user enters "dO", the word should be returned as "Dog"
    
    Task 2: Suggest an existing word in the dictionary, if applicable, when the user enters the wrong vowel. It can simply be the first word that matches. It doesn't have to be the best match.
            For Example: If the word "Delta" is in the dictionary, and the user enters "Dalte", the word "Delta" should be suggested.
*/

import UIKit

let vowels = ["A", "E", "I", "O", "U"]
var words = ["Apple", "Ball", "Cat", "Dog", "Delta", "Door", "Elephant", "Falcon", "Giraffe", "Hotel", "House", "Hostel", "Indigo", "Jester"]
var wordsDictionary: [String: [String]] = [:]

func indexDictionary(dict: [String]) -> [String: [String]] {
    var outerDict: [String: [String]] = [:]

    for word in words {
        let index = word.substring(to: word.index(word.startIndex, offsetBy: 1)).uppercased()
        var innerArray = outerDict[index] ?? [String]()
        innerArray.append(word.capitalized)

        if let dictIndex = wordsDictionary.keys.filter({ $0 == index }).first {
            //Add inner array to existing index
            outerDict[dictIndex] = innerArray

        } else {
            //create a new index in the dictionary
            outerDict[index] = innerArray
        }
    }

    return outerDict
}

func addWordToDictionary(_ word: String) {
    let index = word.substring(to: word.index(word.startIndex, offsetBy: 1)).uppercased()
    if var innerArray = wordsDictionary[index] {
        innerArray.append(word.capitalized)
        wordsDictionary[index] = innerArray
    } else {
        //We need to create a new index in the dictionary
        wordsDictionary[index] = [word.capitalized]
    }
}

func findWordForInput(_ query: String) -> String? {
    let index = query.substring(to: query.index(query.startIndex, offsetBy: 1)).uppercased()
    if let innerArray = wordsDictionary[index] {
        return innerArray.filter({ $0.lowercased().hasPrefix(query.lowercased()) }).first
    } else {
        return nil
    }
}

func suggestWordForInput(_ query: String) -> String {
    let charArray = query.characters.map { String(describing: $0) }
    var searchTerm = charArray.first ?? ""
    var mutableCharArray = charArray

    for i in 0..<charArray.count {
        if vowels.contains(String(describing: mutableCharArray[i].uppercased())) {
            //We should try the next vowel and see if we find a match
            for vowel in vowels {
                mutableCharArray[i] = vowel
                searchTerm = mutableCharArray.joined()
                print("Checking:  \(searchTerm)")
                if let suggestion = findWordForInput(searchTerm) {
                    print("Match Found: \(suggestion)")
                    return suggestion
                }
            }
        }
    }

    return "No words match this search term"
}

//MARK: - Solution 1
// First we need to sort the words array by letter and index it for easy lookup
wordsDictionary = indexDictionary(dict: words)

// Now we can search for a word using any combination of upper or lowercase letters
print(findWordForInput("c")!) //Should return "Cat"
print(findWordForInput("D")!) //Should return "Dog"
print(findWordForInput("dE")!) //Should return "Delta"


//MARK: - Solution 2
// Search for word using incorrect vowel
suggestWordForInput("Dig") //Should return "Dog"
suggestWordForInput("Cot") //Should return "Cat"
suggestWordForInput("Dilt") //Should return "Delta"
suggestWordForInput("Digger") //Should return nothing


