#!/bin/bash

# Initialize the board
board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
player1="X"
player2="O"
current_player=$player1

# Function to display the board
display_board() {
  clear
  echo " ${board[0]} | ${board[1]} | ${board[2]} "
  echo "-----------"
  echo " ${board[3]} | ${board[4]} | ${board[5]} "
  echo "-----------"
  echo " ${board[6]} | ${board[7]} | ${board[8]} "
  echo
}

# Function to check for a win
check_win() {
  local p=$1
  # Check rows
  if [[ "${board[0]}" == "$p" && "${board[1]}" == "$p" && "${board[2]}" == "$p" ]] ||
     [[ "${board[3]}" == "$p" && "${board[4]}" == "$p" && "${board[5]}" == "$p" ]] ||
     [[ "${board[6]}" == "$p" && "${board[7]}" == "$p" && "${board[8]}" == "$p" ]] ||
     # Check columns
     [[ "${board[0]}" == "$p" && "${board[3]}" == "$p" && "${board[6]}" == "$p" ]] ||
     [[ "${board[1]}" == "$p" && "${board[4]}" == "$p" && "${board[7]}" == "$p" ]] ||
     [[ "${board[2]}" == "$p" && "${board[5]}" == "$p" && "${board[8]}" == "$p" ]] ||
     # Check diagonals
     [[ "${board[0]}" == "$p" && "${board[4]}" == "$p" && "${board[8]}" == "$p" ]] ||
     [[ "${board[2]}" == "$p" && "${board[4]}" == "$p" && "${board[6]}" == "$p" ]]; then
    return 0 # Win
  else
    return 1 # No win
  fi
}

# Function to check for a tie
check_tie() {
  for i in "${board[@]}"; do
    if [[ "$i" != "$player1" && "$i" != "$player2" ]]; then
      return 1 # Not a tie
    fi
  done
  return 0 # Tie
}

# Main game loop
while true; do
  display_board
  echo "Player $current_player, enter your move (1-9):"
  read move

  # Validate move
  if ! [[ "$move" =~ ^[1-9]$ ]] || [[ "${board[$move-1]}" == "$player1" ]] || [[ "${board[$move-1]}" == "$player2" ]]; then
    echo "Invalid move. Try again."
    sleep 1
    continue
  fi

  # Update board
  board[$move-1]=$current_player

  # Check for win
  if check_win $current_player; then
    display_board
    echo "Player $current_player wins!"
    break
  fi

  # Check for tie
  if check_tie; then
    display_board
    echo "It's a tie!"
    break
  fi

  # Switch players
  if [[ "$current_player" == "$player1" ]]; then
    current_player=$player2
  else
    current_player=$player1
  fi
done
