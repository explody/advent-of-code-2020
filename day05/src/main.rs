use std::fs::File;
use std::io::{self, BufRead, BufReader};

fn main() -> io::Result<()> {
    let file = File::open("input.txt").unwrap();
    let reader = BufReader::new(file);
    let mut ids = Vec::new();

    for (_index, line) in reader.lines().enumerate() {
        let line = line.unwrap();
        let binline = line
            .replace("B", "1")
            .replace("F", "0")
            .replace("R", "1")
            .replace("L", "0");
        let binrow = &binline[0..7];
        let bincol = &binline[7..10];

        let introw = isize::from_str_radix(binrow, 2).unwrap();
        let intcol = isize::from_str_radix(bincol, 2).unwrap();

        let seat_id = (introw * 8) + intcol;
        ids.push(seat_id);

        //println!("{} {} {} {} {} {} {} ", seat_id, line, binline, binrow, bincol, introw, intcol);
    }
    ids.sort();
    ids.reverse();

    println!("Part 1 - highest ID: {}", ids[0]);

    ids.sort();
    for i in 0..ids.len()-1 {
        //println!("{} {} {}", i, ids[i], ids[i+1]);
        if ids[i]+1 != ids[i+1] {
            println!("Part 2 - your seat ID: {}", ids[i]+1);
        }
    }

    Ok(())
}
