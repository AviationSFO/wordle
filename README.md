# Wordle
## Description
Wordle clone made in lua that works in the command line. See installation options [here](#installation).
## How to Play
You have six tries to guess the five-letter word that computer has randomly generated. Type in your guess and submit your word by hitting the “enter” key on the keyboard. The color of the characters will change after you submit your word letting you know if you got it right. If a character is yellow, it is in the word, but your guess has it in the wrong spot. If it is green, it is in the correct spot. If the color does not change, then the letter is not in the word. You can find all of the wrong letters in your guesses where it says "wrong letters used" below your entry.

# Installation
```shell
curl https://raw.githubusercontent.com/AviationSFO/wordle/master/install.sh | bash
```