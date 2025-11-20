//
//  MovieLineParser.swift
//  Movielister
//
//  Created by Hilal Kahraman on 21.11.2025.
//

import Foundation

struct MovieLineParser {
    static func parse(_ line: String) -> MovieItem? {
        var text = line
        let watched = extractWatched(&text)
        let note = extractNotes(&text)
        let title = cleanTitle(text)
        guard !title.isEmpty else { return nil }
        return MovieItem(title: title, note: note, isWatched: watched)
    }

    private static func extractWatched(_ text: inout String) -> Bool {
        let watchedPatterns = [
            #"^\s*[✓✔✅]+\s*"#,
            #"\s*[✓✔✅]+\s*$"#
        ]
        var watched = false
        for pattern in watchedPatterns {
            if let range = text.range(of: pattern, options: .regularExpression) {
                watched = true
                text.removeSubrange(range)
            }
        }
        return watched
    }

    private static func extractNotes(_ text: inout String) -> String? {
        let pattern = #"\((.*?)\)"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let ns = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: ns.length))

        let notes = matches.compactMap { m -> String? in
            guard m.numberOfRanges > 1 else { return nil }
            let inner = ns.substring(with: m.range(at: 1)).trimmingCharacters(in: .whitespacesAndNewlines)
            return inner.isEmpty ? nil : inner
        }
        // Remove all parentheses blocks from the text (from end to start to keep indices valid)
        matches.map { $0.range(at: 0) }
            .sorted { $0.location > $1.location }
            .forEach { r in
                if let range = Range(r, in: text) {
                    text.removeSubrange(range)
                }
            }

        return notes.isEmpty ? nil : notes.joined(separator: ", ")
    }

    private static func cleanTitle(_ text: String) -> String {
        text
            // Remove leading or trailing dash separators only, keep middle dashes
            .replacingOccurrences(of: #"^\s*-\s*|\s*-\s*$"#, with: " ", options: .regularExpression)
            .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
