#!/bin/bash

# Initialize the board
board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
player1="X"
player2="O"
current_player="$player1"

display_board() {
    echo " ${board[0]} | ${board[1]} | ${board[2]} "
    echo "-----------"
    echo " ${board[3]} | ${board[4]} | ${board[5]} "
    echo "-----------"
    echo " ${board[6]} | ${board[7]} | ${board[8]} "
    echo
}

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

check_tie() {
    for i in "${board[@]}"; do
        if [[ "$i" != "$player1" && "$i" != "$player2" ]]; then
            return 1 # Not a tie
        fi
    done
    return 0 # Tie
}

valid_move() {
    local move=$1
    # Check if the move is a number between 1-9
    if ! [[ "$move" =~ ^[1-9]$ ]]; then
        echo "Move must be a number between 1-9"
        return 1
    fi
    
    # Check if the position is already taken
    if [[ "${board[$((move-1))]}" == "$player1" || "${board[$((move-1))]}" == "$player2" ]]; then
        echo "Position $move is already taken"
        return 1
    fi
    
    return 0 # Valid move
}

computer_move() {
    local attempts=0
    local available_positions=()
    
    # Collect all available positions
    for i in {0..8}; do
        if [[ "${board[$i]}" != "$player1" && "${board[$i]}" != "$player2" ]]; then
            available_positions+=($((i+1)))
        fi
    done
    
    # If there are available positions, randomly select one
    if [[ ${#available_positions[@]} -gt 0 ]]; then
        local random_index=$((RANDOM % ${#available_positions[@]}))
        echo "${available_positions[$random_index]}"
    else
        # No available positions (shouldn't happen with proper tie checking)
        echo "1" # Return a default value
    fi
}

# Game loop
while true; do
    display_board
    
    if [[ "$current_player" == "$player1" ]]; then
        echo "Player $current_player, enter your move (1-9):"
        read -r move
        
        # Validate player move
        validation_result=$(valid_move "$move")
        if [[ $? -ne 0 ]]; then
            echo "$validation_result"
            sleep 1
            continue
        fi
    else
        echo "Computer ($current_player) is making a move..."
        sleep 1
        move=$(computer_move)
        echo "Computer chose position $move"
    fi
    
    # Update the board
    board[$((move-1))]="$current_player"
    
    # Check for win
    if check_win "$current_player"; then
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
        current_player="$player2"
    else
        current_player="$player1"
    fi
done
