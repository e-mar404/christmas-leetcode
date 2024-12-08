package main

import (
	"os"
	"fmt"
	"bufio"
	"regexp"
	"strconv"
)

func day3() {
	file, err := os.Open("../inputs/day3.input")
	if err != nil {
		panic(err)
	}

	scanner := bufio.NewScanner(file)
	if err := scanner.Err(); err != nil {
		panic(err)
	}
	
	part1 := 0
	part2 := 0
	enabled := true
	for scanner.Scan() {
		line := scanner.Text()
		pattern := regexp.MustCompile(`mul\(\d{1,3},\d{1,3}\)|don\'t\(\)|do\(\)`)
		
		matches := pattern.FindAllString(line, 1000);

		for _, command := range matches {
			if command == "don't()" {
				enabled = false
				continue
			}

			if command == "do()" {
				enabled = true
				continue
			}

			numberPattern := regexp.MustCompile(`\d{1,3}`)
			numbers := numberPattern.FindAllString(command, 2)

			number1, _ := strconv.Atoi(numbers[0])
			number2, _ := strconv.Atoi(numbers[1])
			part1 += number1 * number2 

			if enabled {
				part2 += number1 * number2
			}
		}
	}

	fmt.Printf("Part 1: %v\n", part1)
	fmt.Printf("Part 2: %v\n", part2)
}
