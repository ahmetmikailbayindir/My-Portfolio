#!/bin/bash

################################################################################
# Script Name: parity-counter.sh
# Description: Counts and displays even and odd numbers from user input
# Author: [Your Name]
# Course: CST8245 - Linux Scripting
# Date: [Date]
################################################################################

# Initialize counters
even_count=0
odd_count=0

# Display welcome message
echo "========================================="
echo "      Parity Counter Application"
echo "========================================="
echo ""

# Prompt user for how many numbers to enter
echo -n "How many numbers would you like to enter? "
read total_numbers

# Validate input is a positive integer
if ! [[ "$total_numbers" =~ ^[0-9]+$ ]] || [ "$total_numbers" -le 0 ]; then
    echo "Error: Please enter a valid positive integer."
    exit 1
fi

echo ""
echo "Please enter $total_numbers numbers:"

# Loop to collect numbers
for ((i=1; i<=total_numbers; i++)); do
    echo -n "Number $i: "
    read number

    # Validate input is an integer
    if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$number' is not a valid integer. Please try again."
        ((i--))  # Decrement counter to re-prompt for this number
        continue
    fi

    # Check if number is even or odd
    if [ $((number % 2)) -eq 0 ]; then
        ((even_count++))
    else
        ((odd_count++))
    fi
done

# Display results
echo ""
echo "========================================="
echo "            Results"
echo "========================================="
echo "Total numbers entered: $total_numbers"
echo "Even numbers: $even_count"
echo "Odd numbers: $odd_count"
echo "========================================="
