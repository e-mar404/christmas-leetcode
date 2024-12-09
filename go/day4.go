package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func day4() {
	file, err := os.Open("../inputs/day4.test")
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

	word := "XMAS"
	part1 := 0
	for row := range matrix {
		for col := range matrix[row] {
			part1 += lookAround(row, col, matrix, word)
		}
	}

	fmt.Printf("Part 1: %v\n", part1)
}

func lookAround(row int, col int, matrix [][]string, word string) int{
	return straightSearch(row, col, matrix, word)
}

func straightSearch(row int, col int, matrix [][]string, word string) int {	
	words := map[string]string{}
	for idx := 0; idx < len(word); idx++ {
		left := col - idx
		right := col + idx
		up := row - idx
		down := row + idx

		if left >= 0 {
			words["left"] = words["left"] + matrix[row][left] 
		}

		if left >= 0 && up >= 0 {
			words["left_up"] = words["left_up"] + matrix[up][left]
		}

		if left >= 0 && down < len(matrix) {
			words["left_down"] = words["left_down"] + matrix[down][left]
		}

		if right < len(matrix[row]) {
			words["right"] += matrix[row][right]
		}

		if right < len(matrix[row]) && up >= 0 {
			words["right_up"] = words["right_up"] + matrix[up][right]
		}

		if right < len(matrix[row]) && down < len(matrix) {
			words["right_down"] = words["right_down"] + matrix[down][right]
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
