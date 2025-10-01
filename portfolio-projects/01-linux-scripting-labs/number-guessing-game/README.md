# Number Guessing Game

## 📝 Problem Statement

Develop an interactive Bash script that generates a random number between 1-100 and allows the user to guess it within a limited number of attempts, providing feedback on each guess.

## 🎯 Features

- Random number generation (1-100)
- 10 attempt limit with counter
- Intelligent feedback (too high/low)
- Input validation (numbers only, within range)
- Play again functionality
- Attempt tracking and scoring

## 🔧 Technical Implementation

### Key Concepts Demonstrated

1. **Random Number Generation**
   - Using `$RANDOM` built-in variable
   - Modulo arithmetic for range control

2. **Functions**
   - Modular code organization
   - Function return values

3. **Nested Control Structures**
   - While loops with counters
   - Nested if/elif/else statements
   - Input validation loops

4. **User Experience**
   - Clear feedback messages
   - Attempt tracking
   - Game restart functionality

## 💻 Usage

```bash
chmod +x number-guess.sh
./number-guess.sh
```

## 📊 Example Game Session

```
=========================================
      Number Guessing Game
=========================================

I'm thinking of a number between 1 and 100.
You have 10 attempts to guess it!

Attempt 1/10 - Enter your guess: 50
📉 Too high! Try a lower number. (9 attempts left)

Attempt 2/10 - Enter your guess: 25
📈 Too low! Try a higher number. (8 attempts left)

Attempt 3/10 - Enter your guess: 37
📈 Too low! Try a higher number. (7 attempts left)

Attempt 4/10 - Enter your guess: 43
🎉 Congratulations! You guessed it!
The number was 43
You won in 4 attempts!

Would you like to play again? (y/n): n
Thanks for playing! Goodbye!
```

## 🧪 Edge Cases Handled

| Input | Behavior |
|-------|----------|
| Non-numeric input | Error message, re-prompt without counting attempt |
| Number < 1 | Error message, re-prompt |
| Number > 100 | Error message, re-prompt |
| 10 incorrect guesses | Game over, reveal answer |
| Correct guess | Win message, show attempt count |

## 📚 What I Learned

- Working with Bash's `$RANDOM` variable
- Implementing game logic with while loops
- Creating reusable functions
- Managing game state (attempts, remaining guesses)
- Providing helpful user feedback
- Script restart techniques with `exec`

## 🔍 Code Highlights

```bash
# Random number generation (1-100)
target_number=$((RANDOM % 100 + 1))

# Remaining attempts calculation
remaining=$((max_attempts - attempts + 1))

# Restart script functionality
if [[ "$play_again" =~ ^[Yy]$ ]]; then
    exec "$0"
fi
```

## 🎮 Possible Enhancements

- [ ] Difficulty levels (adjust range and attempts)
- [ ] Score tracking across multiple games
- [ ] Hint system (multiples, prime, etc.)
- [ ] Timer to track speed
- [ ] High score leaderboard

## 🏷️ Skills Demonstrated

`Bash Scripting` `Functions` `Random Generation` `Game Logic` `While Loops` `User Interaction` `Input Validation`
