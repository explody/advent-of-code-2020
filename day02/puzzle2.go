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
        pos1, _ := strconv.Atoi(limits[0])
        pos2, _ := strconv.Atoi(limits[1])
        mychar := strings.Trim(s[1], ":")
        pwd := s[2]
        plen := len(pwd)

        if pos1 > plen || pos2 > plen {
            fmt.Println("bad pos")
            continue
        }
        hit1 := string(pwd[pos1-1]) == mychar
        hit2 := string(pwd[pos2-1]) == mychar

        if (hit1 && !hit2) || (hit2 && !hit1) {
            good++
        }
    }

    fmt.Printf("%d good passwords\n", good)

    if err := scanner.Err(); err != nil {
        log.Fatal(err)
    }
}
