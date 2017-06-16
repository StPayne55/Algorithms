/*
    Task 1: Create a way to return a word in a dictionary from user input regardless of case.
            For example: If the word "Dog" is in the dictionary, and the user enters "dO", the word should be returned as "Dog"
    
    Task 2: Suggest an existing word in the dictionary, if applicable, when the user enters the wrong vowel. It can simply be the first word that matches. It doesn't have to be the best match.
            For Example: If the word "Delta" is in the dictionary, and the user enters "Dalte", the word "Delta" should be suggested.
 
 
    The key to these solutions is in how we create the data structure to hold these Strings.
    The words are first placed in an array. We then go through that words array and index each word with other words that begin with the same letter.
    This means that when the user enters a String, we don't have to traverse our entire dictionary. We can grab the first letter of their input and quickly get all of the words that start with that letter.
    
    Example: If the user enters the letters 'Ho' then instead of comparing it to 'Apple', 'Ball', etc...we just grab the values for the key 'H' which in this case, would be equal to 3 Key-Value Pairs.
    
    This means we can lookup words in linear time O(n) where n is equal to the number of words that begin with the first letter of the user's input.
    Had we not indexed the words first and placed them into a dictionary, we'd still lookup words in O(n) time but n would be equal to the total number of words in the dictionary, which could be infinitely large.
 
    We could further optimize this by adding more indexing so that instead of looking up a word by it's first letter, we'd lookup by common prefix.
    For example, say there are numerous words that start with the letters "Ho", we could index our dictionary like so:

    wordsDictionary = ["H": ["Ho": ["Hotel", "Hostel", "House"]],
                            ["Ha": ["Haste", "Halo", "Hallow"]]
                            ... and so on
                      ]
 
    With the above indexing, we could GREATLY refine the size of the set we need to compare against. We'd still be performing lookups in O(n) but n would be no larger than the set of words that have the same prefix as the input.
    We could create a function that will check periodically to see if there are common prefixes and if so, add a new sub-index like above.
 
    For simplicity, I'm only indexing by starting letter in this example.
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


// Because of how the data structure is created, we will only ever be filtering a very small subset of the entire dictionary.
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

    // This does technically compare in O(n^2) here but it's bounded since there are only 5 vowels in the alphabet. 
    // Words with multiple vowels could perform more poorly than words with a single vowel but the more we index our words dictionary, the better off we'll be here.
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


