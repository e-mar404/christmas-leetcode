package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func day4() {
	file, err := os.Open("../inputs/day4.input")
	if err != nil {
		panic(err)
	}

	scanner := bufio.NewScanner(file)
	if err := scanner.Err(); err != nil {
		panic(err)
	}

	matrix := [][]string{}
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), "")

		matrix = append(matrix, line)
	}

	word1 := "XMAS"
	word2 := "MAS"
	part1 := 0
	part2 := 0
	for row := range matrix {
		for col := range matrix[row] {
			part1 += lookAround(row, col, matrix, word1)
			part2 += findX(row, col, matrix, word2)
		}
	}

	fmt.Println("Day 4")
	fmt.Printf("Part 1: %v\n", part1)
	fmt.Printf("Part 2: %v\n", part2)
}

func lookAround(row int, col int, matrix [][]string, word string) int {	
	words := map[string]string{}
	for idx := 0; idx < len(word); idx++ {
		left := col - idx
		right := col + idx
		up := row - idx
		down := row + idx

		if left >= 0 {
			words["left"] = words["left"] + matrix[row][left] 

			if up >= 0 {
				words["left_up"] = words["left_up"] + matrix[up][left]
			}

			if down < len(matrix) {
				words["left_down"] = words["left_down"] + matrix[down][left]
			}
		}

		if right < len(matrix[row]) {
			words["right"] += matrix[row][right]

			if up >= 0 {
				words["right_up"] = words["right_up"] + matrix[up][right]
			}

			if down < len(matrix[row]) {
				words["right_down"] = words["right_down"] + matrix[down][right]
			}
		}

		if up >= 0 {
			words["up"] = words["up"] + matrix[up][col]
		}

		if down < len(matrix) {
			words["down"] += matrix[down][col]
		}
	}

	points := 0
	for _, value := range words {
		if value == word {
			points++
		}
	}

	return points 
}

func findX(row int, col int, matrix [][]string, word string) int {
	words := map[string]string{}
	left := col - 1
	right := col + 1
	up := row - 1
	down := row + 1

	if (left >= 0  && right < len(matrix[row])) && 
		(up >= 0 && down < len(matrix)) {
			words["left_down"] = matrix[up][left] + matrix[row][col] + matrix[down][right]
			words["left_up"] = matrix[down][right] + matrix[row][col] + matrix[up][left] 
			words["right_down"] = matrix[up][right] + matrix[row][col] + matrix[down][left]
			words["right_up"] = matrix[down][left] + matrix[row][col] + matrix[up][right]
	}

	count := 0
	for _, value := range words {
		if value == word {
			count++
		}
	}

	if count == 2 {
		return 1
	}

	return 0
}
