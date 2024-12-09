package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func decreasing(reports []int) bool {
	for idx, entry := range reports[:len(reports) - 1] {
		diff := entry - reports[idx + 1]

		if diff > 3 || diff < 1 {
			return false
		}
	}

	return true
}

func decreasingTolerant(reports []int) bool {
	for idx := range reports {
		modified := append([]int{}, reports[:idx]...)
		modified = append(modified, reports[idx+1:]...)

		if decreasing(modified) {
			return true
		}
	}
	return false
}

func increasing(reports []int) bool {
	for idx, entry := range reports[:len(reports) - 1] {
		diff := reports[idx + 1] - entry

		if diff > 3 || diff < 1 {
			return false
		}
	}

	return true
}

func increasingTolerant(reports []int) bool {
	for idx := range reports {
		// would like to figure out why doing the following worked
		modified := append([]int{}, reports[:idx]...)
		modified = append(modified, reports[idx+1:]...)

		// but this did not work
		// l := reports[:idx]
		// r := reports[idx+1:]
		//
		// modified := append(l, r...)

		if increasing(modified) {
			return true
		}
	}
	return false
}

func day2() {
	file, err := os.Open("../inputs/day2.input")
	if err != nil {
		panic(err)
	}	

	scanner := bufio.NewScanner(file)
	if err := scanner.Err(); err != nil {
		panic(err)
	}

	part1 := 0
	part2 := 0
	for scanner.Scan() {
		level := []int{}
		line := strings.Split(scanner.Text(), " ")
		
		for _, num := range line {
			lineNum, _ := strconv.Atoi(num)
			level = append(level, lineNum)
		}
		
		if decreasing(level) || increasing(level) {
			part1++
		}

		if decreasingTolerant(level) || increasingTolerant(level){
			part2++
		}
	}

	fmt.Println("Day 2")
	fmt.Printf("Part 1: %v\n", part1)
	fmt.Printf("Part 2: %v\n", part2)
}
