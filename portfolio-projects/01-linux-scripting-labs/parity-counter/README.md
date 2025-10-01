# Parity Counter Script

## 📝 Problem Statement

Create a Bash script that accepts multiple numbers from the user and counts how many are even and how many are odd. The script must validate all inputs and handle errors gracefully.

## 🎯 Features

- Prompts user for total count of numbers to enter
- Validates that inputs are valid integers
- Counts even and odd numbers separately
- Displays formatted results
- Error handling for invalid inputs

## 🔧 Technical Implementation

### Key Concepts Demonstrated

1. **Input Validation**
   - Regular expression pattern matching for integer validation
   - Handling negative numbers correctly

2. **Flow Control**
   - For loops with counter variables
   - Conditional statements (if/else)
   - Continue statement for error recovery

3. **Arithmetic Operations**
   - Modulo operator for parity checking
   - Counter increment operations

## 💻 Usage

```bash
chmod +x parity-counter.sh
./parity-counter.sh
```

## 📊 Example Input/Output

```
=========================================
      Parity Counter Application
=========================================

How many numbers would you like to enter? 5

Please enter 5 numbers:
Number 1: 10
Number 2: 15
Number 3: 22
Number 4: 7
Number 5: 100

=========================================
            Results
=========================================
Total numbers entered: 5
Even numbers: 3
Odd numbers: 2
=========================================
```

## 🧪 Test Cases

| Input | Expected Output |
|-------|----------------|
| 2, 4, 6, 8 | Even: 4, Odd: 0 |
| 1, 3, 5, 7 | Even: 0, Odd: 4 |
| -2, -3, 0 | Even: 2, Odd: 1 |
| abc (invalid) | Error message, re-prompt |

## 📚 What I Learned

- How to use modulo arithmetic for parity checking
- Implementing robust input validation with regex
- Using for loops with dynamic ranges
- Error recovery techniques in shell scripts
- Formatting output for better user experience

## 🔍 Code Highlights

```bash
# Regex validation for integers (including negatives)
if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Not a valid integer"
    ((i--))  # Re-prompt for this iteration
    continue
fi

# Parity check using modulo operator
if [ $((number % 2)) -eq 0 ]; then
    ((even_count++))
else
    ((odd_count++))
fi
```

## 🏷️ Skills Demonstrated

`Bash Scripting` `Input Validation` `Flow Control` `Arithmetic Logic` `Error Handling` `Linux CLI`
