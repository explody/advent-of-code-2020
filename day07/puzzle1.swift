import Foundation

// Read data from this file.
let path = "input.txt"
var bags = [String: [String: Int]]()
var subBags = [String: Int]()

func find_bags(bags: Dictionary<String, Dictionary<String, Int>>, name: String) -> Array<String> {
    var hasmember: [String] = []
    for (bag, contents) in bags {
        let memberExists = contents[name] != nil
        if memberExists {
            hasmember.append(bag)
        }
    }
    for container in hasmember {
        hasmember = hasmember + find_bags(bags: bags, name: container)
    }
    return hasmember
}

do {
    let data = try NSString(contentsOfFile: path,
        encoding: String.Encoding.ascii.rawValue)
    let lines = data.components(separatedBy: CharacterSet.newlines)

    for var line in lines {
        // This is horrible but I have no idea (or time to figure out) how to do it right in Swift
        line = line.replacingOccurrences(of: ".", with: "")
        line = line.replacingOccurrences(of: ",", with: "|")
        line = line.replacingOccurrences(of: "bags", with: "")
        line = line.replacingOccurrences(of: "bag", with: "")
        line = line.replacingOccurrences(of: "contain ", with: "")
        
        let bagCounts = line.components(separatedBy: "  ")

        if bagCounts.count < 2 {
            continue
        }
        
        let containerBag = bagCounts[0]
        let bagContents = bagCounts[1].components(separatedBy: " | ")
        for contents in bagContents {
            let baginfo = contents.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ", maxSplits: 1)
            
            let bagExists = bags[containerBag] != nil
            if !bagExists {
                let myBags = subBags
                bags[containerBag] = myBags
            }
            
            if baginfo[0] == "no" {
                bags[containerBag] = ["none": 0]
            } else {
                bags[containerBag]![String(baginfo[1])] = Int(baginfo[0])!
            }
        }
    }
    
    print(Array(Set(find_bags(bags: bags, name: "shiny gold"))).count)
    
}
