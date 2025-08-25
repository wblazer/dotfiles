#!/usr/bin/env nu

# Parse git blame porcelain output to show date, author, and commit message
def main [file: string, line: int] {
    let blame_info = (git blame --porcelain -L $"($line),+1" $file | lines | reduce -f {} {|line, acc|
        let parts = ($line | split row " ")
        let key = ($parts | first)

        if $key == "author" {
            $acc | insert author ($parts | skip 1 | str join " ")
        } else if $key == "author-time" {
            let timestamp = ($parts | get 1)
            let date_str = (^date -d $"@($timestamp)" "+%m-%d-%Y")
            $acc | insert date $date_str
        } else if $key == "summary" {
            $acc | insert summary ($parts | skip 1 | str join " ")
        } else {
            $acc
        }
    })
    
    $"($blame_info.date) - ($blame_info.author): ($blame_info.summary)"
}
