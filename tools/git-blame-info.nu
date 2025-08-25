#!/usr/bin/env nu

# Parse git blame porcelain output to show date, author, and commit message
def main [file: string, line: int] {
    let blame_info = (git blame --porcelain -L $"($line),+1" $file | lines | reduce --fold {} {|line, acc|
        let parts = ($line | split row " ")
        let key = ($parts | first)

        match $key {
            "author" => {
                $acc | insert author ($parts | skip 1 | str join " ")
            },
            "author-time" => {
                $acc | insert date ($parts | get 1 | into datetime -f "%s" | format date "%B %-d, %Y")
            },
            "summary" => {
                $acc | insert summary ($parts | skip 1 | str join " ")
            },
            _ => $acc
        }
    })
    
    $"($blame_info.date) - ($blame_info.author): ($blame_info.summary)"
}
