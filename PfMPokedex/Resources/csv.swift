//
//  CSV
//  Modified by Mark Price on 08/14/15
//

import Foundation

public class CSV {
    
    public var headers: [String] = []
    public var rows: [[String: String]] = []
    public var columns = [String: [String]]()
    var delimiter = CharacterSet(charactersIn: ",")
    
    public init(content: String?, delimiter: CharacterSet, encoding: UInt) throws {
        if let csvStringToParse = content {
            self.delimiter = delimiter
            
            let newline = CharacterSet.newlines
            var lines: [String] = []
            csvStringToParse.trimmingCharacters(in: newline).enumerateLines { line, stop in lines.append(line); print(stop) }
            self.headers = self.parseHeaders(fromLines: lines)
            self.rows = self.parseRows(fromLines: lines)
            self.columns = self.parseColumns(fromLines: lines)
        }
    }
    
    public convenience init(contentsOfURL url: String) throws {
        let comma = CharacterSet(charactersIn: ",")
        let csvString: String?
        do {
            csvString = try String(contentsOfFile: url, encoding: String.Encoding.utf8)
        } catch _ {
            csvString = nil
        }
        try self.init(content: csvString, delimiter: comma, encoding: String.Encoding.utf8.rawValue)
    }
    
    func parseHeaders(fromLines lines: [String]) -> [String] {
        return lines[0].components(separatedBy: delimiter)
    }
    
    func parseRows(fromLines lines: [String]) -> [[String: String]] {
        var rows: [[String: String]] = []
        
        for (lineNumber, line) in lines.enumerated() {
            if lineNumber == 0 {
                continue
            }
            var row = [String: String]()
            let values = line.components(separatedBy: delimiter)
            for (index, header) in self.headers.enumerated() {
                if index < values.count {
                    row[header] = values[index]
                } else {
                    row[header] = ""
                }
            }
            rows.append(row)
        }
        return rows
    }
    
    func parseColumns(fromLines lines: [String]) -> [String: [String]] {
        var columns = [String: [String]]()
        for header in self.headers {
            let column = self.rows.map { row in row[header] != nil ? row[header]! : "" }
            columns[header] = column
        }
        return columns
    }
}
