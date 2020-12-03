package main

import (
    "bufio"
    "fmt"
    "log"
    "os"
    "strconv"
    "strings"
)

// Straight outta SO
func main()  {
    file, err := os.Open("input.txt")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    good := 0
    for scanner.Scan() {
        s := strings.Split(scanner.Text(), " ")
        limits := strings.Split(s[0], "-")
        min, _ := strconv.Atoi(limits[0])
        max, _ := strconv.Atoi(limits[1])
        mychar := strings.Trim(s[1], ":")
        pwd := s[2]
        count := strings.Count(pwd, mychar)

        if count >= min && count <= max {
            good++
        }
    }

    fmt.Printf("%d good passwords\n", good)

    if err := scanner.Err(); err != nil {
        log.Fatal(err)
    }
}
