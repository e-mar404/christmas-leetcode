package main

import (
	"os"
	"fmt"
	"math"
	"bufio"
	"slices"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("../inputs/day1.input")
	if err != nil {
		fmt.Printf("opening file returned: %v\n", err)
		return
	}

	scanner := bufio.NewScanner(file)
	if err := scanner.Err(); err != nil {
		fmt.Printf("creating scanner returned: %v\n", err)
		return
	}

	var left []int
	var right []int

	for scanner.Scan() {
		line := strings.Split(scanner.Text(), "   ")

		left_num, _ := strconv.Atoi(line[0]) 
		right_num, _ := strconv.Atoi(line[1])

		left = append(left, left_num)
		right = append(right, right_num)
	}
	
	slices.Sort(left)
	slices.Sort(right)
	
	part1 := 0
	part2 := 0
	m := map[int]int{}

	for idx, num := range left {
		part1 += int(math.Abs(float64(num - right[idx])))

		m[right[idx]]++
	}

	for _, num := range left {
		part2 += num * m[num]
	}

	fmt.Printf("Part 1: %v\n", part1)
	fmt.Printf("Part 2: %v\n", part2)
}
