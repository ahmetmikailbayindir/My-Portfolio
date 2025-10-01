#!/bin/bash

################################################################################
# Script Name: number-guess.sh
# Description: Interactive number guessing game with feedback
# Author: Ahmet Mikail Bayindir
# Course: CST8245 - Linux Scripting
# Date: October 2025
################################################################################

# Function to generate random number between 1 and 100
generate_random() {
    echo $((RANDOM % 100 + 1))
}

# Main game function
play_game() {
    local target_number=$(generate_random)
    local attempts=0
    local max_attempts=10
    local guess

    echo "========================================="
    echo "      Number Guessing Game"
    echo "========================================="
    echo ""
    echo "I'm thinking of a number between 1 and 100."
    echo "You have $max_attempts attempts to guess it!"
    echo ""

    # Game loop
    while [ $attempts -lt $max_attempts ]; do
        ((attempts++))
        remaining=$((max_attempts - attempts + 1))

        echo -n "Attempt $attempts/$max_attempts - Enter your guess: "
        read guess

        # Validate input
        if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
            echo "❌ Error: Please enter a valid number."
            ((attempts--))  # Don't count invalid input as an attempt
            continue
        fi

        # Check range
        if [ "$guess" -lt 1 ] || [ "$guess" -gt 100 ]; then
            echo "❌ Error: Number must be between 1 and 100."
            ((attempts--))
            continue
        fi

        # Check guess
        if [ "$guess" -eq "$target_number" ]; then
            echo ""
            echo "🎉 Congratulations! You guessed it!"
            echo "The number was $target_number"
            echo "You won in $attempts attempts!"
            return 0
        elif [ "$guess" -lt "$target_number" ]; then
            echo "📈 Too low! Try a higher number. ($remaining attempts left)"
        else
            echo "📉 Too high! Try a lower number. ($remaining attempts left)"
        fi
        echo ""
    done

    # Game over - ran out of attempts
    echo "========================================="
    echo "❌ Game Over! You've run out of attempts."
    echo "The correct number was: $target_number"
    echo "========================================="
    return 1
}

# Main program
play_game

# Ask if user wants to play again
echo ""
echo -n "Would you like to play again? (y/n): "
read play_again

if [[ "$play_again" =~ ^[Yy]$ ]]; then
    echo ""
    exec "$0"  # Restart the script
else
    echo "Thanks for playing! Goodbye!"
fi
