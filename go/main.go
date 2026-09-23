package main

import "fmt"

func main() {
	result := add(5, 3)
	fmt.Printf("Hello, World! Result: %d\n", result)
}

func add(a, b int) int {
	return a + b
}
