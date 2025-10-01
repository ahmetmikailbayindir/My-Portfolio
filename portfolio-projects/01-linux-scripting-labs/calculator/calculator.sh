#!/bin/bash

################################################################################
# Script Name: calculator.sh
# Description: Command-line calculator with comprehensive input validation
# Author: Ahmet Mikail Bayindir
# Course: CST8245 - Linux Scripting
# Date: October 2025
################################################################################

# Function to display calculator menu
display_menu() {
    echo "========================================="
    echo "       Command-Line Calculator"
    echo "========================================="
    echo "Operations available:"
    echo "  1. Addition       (+)"
    echo "  2. Subtraction    (-)"
    echo "  3. Multiplication (*)"
    echo "  4. Division       (/)"
    echo "  5. Exit"
    echo "========================================="
}

# Function to validate numeric input
validate_number() {
    local num=$1
    if [[ "$num" =~ ^-?[0-9]+\.?[0-9]*$ ]]; then
        return 0  # Valid number
    else
        return 1  # Invalid number
    fi
}

# Function to perform calculation
calculate() {
    local num1=$1
    local operator=$2
    local num2=$3
    local result

    case $operator in
        "+")
            result=$(echo "$num1 + $num2" | bc -l)
            echo "$num1 + $num2 = $result"
            ;;
        "-")
            result=$(echo "$num1 - $num2" | bc -l)
            echo "$num1 - $num2 = $result"
            ;;
        "*")
            result=$(echo "$num1 * $num2" | bc -l)
            echo "$num1 * $num2 = $result"
            ;;
        "/")
            # Division by zero validation
            if [ "$num2" == "0" ] || [ "$num2" == "0.0" ]; then
                echo "❌ Error: Division by zero is not allowed!"
                return 1
            fi
            result=$(echo "scale=4; $num1 / $num2" | bc -l)
            echo "$num1 / $num2 = $result"
            ;;
        *)
            echo "❌ Error: Invalid operator"
            return 1
            ;;
    esac
    return 0
}

# Main program loop
while true; do
    display_menu

    echo -n "Select operation (1-5): "
    read choice

    # Exit option
    if [ "$choice" == "5" ]; then
        echo "Thank you for using the calculator. Goodbye!"
        exit 0
    fi

    # Validate choice
    if ! [[ "$choice" =~ ^[1-4]$ ]]; then
        echo ""
        echo "❌ Error: Please select a valid option (1-5)"
        echo ""
        sleep 2
        clear
        continue
    fi

    # Get first number
    echo -n "Enter first number: "
    read num1
    if ! validate_number "$num1"; then
        echo "❌ Error: '$num1' is not a valid number"
        echo ""
        sleep 2
        clear
        continue
    fi

    # Get second number
    echo -n "Enter second number: "
    read num2
    if ! validate_number "$num2"; then
        echo "❌ Error: '$num2' is not a valid number"
        echo ""
        sleep 2
        clear
        continue
    fi

    # Map choice to operator
    case $choice in
        1) operator="+" ;;
        2) operator="-" ;;
        3) operator="*" ;;
        4) operator="/" ;;
    esac

    # Perform calculation
    echo ""
    echo "Result:"
    calculate "$num1" "$operator" "$num2"

    echo ""
    echo -n "Press Enter to continue..."
    read
    clear
done
