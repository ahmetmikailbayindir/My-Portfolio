# Calculator with Validation

## 📝 Problem Statement

Build a command-line calculator that performs basic arithmetic operations (addition, subtraction, multiplication, division) with comprehensive input validation, including division-by-zero checking.

## 🎯 Features

- Four basic arithmetic operations
- Menu-driven interface
- Input validation for numeric values
- **Division by zero protection**
- Support for decimal numbers
- Continuous operation mode
- Clear error messages

## 🔧 Technical Implementation

### Key Concepts Demonstrated

1. **Input Validation**
   - Regex pattern matching for integers and decimals
   - Operator validation
   - Menu choice validation

2. **Error Handling**
   - Division by zero checking (primary focus)
   - Invalid operator detection
   - Non-numeric input handling

3. **Functions**
   - `display_menu()` - UI presentation
   - `validate_number()` - Input validation with return codes
   - `calculate()` - Arithmetic logic with error handling

4. **Advanced Features**
   - Using `bc` for floating-point arithmetic
   - Menu-driven loop with exit option
   - Screen clearing for better UX

## 💻 Usage

```bash
chmod +x calculator.sh
./calculator.sh
```

## 📊 Example Session

```
=========================================
       Command-Line Calculator
=========================================
Operations available:
  1. Addition       (+)
  2. Subtraction    (-)
  3. Multiplication (*)
  4. Division       (/)
  5. Exit
=========================================
Select operation (1-5): 4
Enter first number: 100
Enter second number: 5

Result:
100 / 5 = 20.0000

Press Enter to continue...
```

### Division by Zero Example

```
Select operation (1-5): 4
Enter first number: 42
Enter second number: 0

Result:
❌ Error: Division by zero is not allowed!

Press Enter to continue...
```

## 🧪 Test Cases

| Operation | Input 1 | Input 2 | Expected Output |
|-----------|---------|---------|-----------------|
| Addition | 10 | 5 | 15 |
| Subtraction | 10 | 5 | 5 |
| Multiplication | 10 | 5 | 50 |
| Division | 10 | 5 | 2.0000 |
| **Division** | **10** | **0** | **Error: Division by zero!** |
| Division | 5 | 2 | 2.5000 (decimal support) |
| Invalid input | abc | 5 | Error: Not a valid number |

## 📚 What I Learned

- **Primary Focus**: Implementing division-by-zero validation
- Using `bc` command for precision arithmetic
- Creating reusable validation functions
- Implementing menu-driven programs
- Return codes for function error handling
- Floating-point arithmetic in Bash
- User experience considerations (clear screen, prompts)

## 🔍 Code Highlights

### Division by Zero Validation
```bash
"/")
    # Critical validation check
    if [ "$num2" == "0" ] || [ "$num2" == "0.0" ]; then
        echo "❌ Error: Division by zero is not allowed!"
        return 1
    fi
    result=$(echo "scale=4; $num1 / $num2" | bc -l)
    echo "$num1 / $num2 = $result"
    ;;
```

### Number Validation with Regex
```bash
validate_number() {
    local num=$1
    # Matches integers and decimals (positive/negative)
    if [[ "$num" =~ ^-?[0-9]+\.?[0-9]*$ ]]; then
        return 0
    else
        return 1
    fi
}
```

### Using bc for Precision
```bash
# Set decimal precision to 4 places
result=$(echo "scale=4; $num1 / $num2" | bc -l)
```

## 🎯 Error Handling Matrix

| Error Type | Detection Method | User Feedback |
|-----------|------------------|---------------|
| Division by zero | Explicit if condition | Clear error message |
| Non-numeric input | Regex validation | "Not a valid number" |
| Invalid operation | Case statement default | "Invalid operator" |
| Out-of-range choice | Range validation | "Select valid option" |

## 🚀 Possible Enhancements

- [ ] Add power/exponent operation
- [ ] Add modulo operation
- [ ] Calculation history
- [ ] Memory functions (M+, M-, MR, MC)
- [ ] Scientific calculator mode
- [ ] Expression parsing (e.g., "5 + 3 * 2")

## 🏷️ Skills Demonstrated

`Bash Scripting` `Input Validation` `Error Handling` `Division by Zero Protection` `Functions` `bc Command` `Menu Design` `Regex` `Case Statements`
