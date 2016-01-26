# Karol-Regula-Jessica-Titensky-Final-Project
Final Project 2016 APCS


			Project Description
			~~~~~~~~~~~~~~~~~~~
Scrabble with multiplayer or against an AI.


      		     	Directions to compile/run
			~~~~~~~~~~~~~~~~~~~~~~~~~
Open any of the .pde files in Main and press run.

     	    	     	
			Directions to use it
			~~~~~~~~~~~~~~~~~~~~
On the main menu, press how many players you want, and whether to have an AI. To enter player names, press on that player's box, type in the name (max 8 chars), and press enter. On the game screen, to make a move, select a letter and then press where on the board you want it (the first move has to go through the center square and the others all have to touch other tiles on the board). To make the move, press play and if its a valid word, itll go onto the next players turn (shown in the scoreboard). For each word you make, you get the sum of the scores on each letter of the word multiplied by the square that letter is on (white is 1x, red and blue are 2x, green and orange are 3x).Instead of making a word, you can also swap tiles on your turn (press swap, select which tiles to change, and press swap again to end the turn (this only works if there are >=7 tiles left)). The undo button gets rid of all the tiles you just put on the board, undoes anything you just selected for a swap, and reverts originally blank tiles in your tile rack to being blank again. 


			     	Changelog
 				~~~~~~~~~
  01-20-16
  	Karol-worked on AI and fixed a part of how tiles should move
 	Jessica-made a swap button/function and added a feature to the score board
 01-21-16
 	Karol - I continued to work on the AI, the AI now has all of the methods in place to achieve basic functionality and a lot of the bugs that seemed unsurmountable in the first two days of its development have been fixed. The biggest change today is the new makePlay() function which relies on the new indexing system to make a move. The AI first creates a list of all the words it can make and then tries to insert every word (collection of tiles in actuality) into all possible locations in both the vertical and horizontal directions. The AI uses 4 different ArrayLists to track the scores and corresponding tiles in both the x and y directions. The makePlay() function searches the scoreIndexX and scoreIndexY for a high score and then tries to play the tiles in tileIndexX and tileIndexY repectively. The AI is in a much better state than it was yesterday but it still does not yet function in the manner that is expected of it.
 	Bugfix - scoreBoard now correctly keeps track of the amount of tiles left in the bag after a player has swapped their tiles out (previously the number of tiles in the bag would decrease)
 	New class - Input Field: detects keypresses and for now prints them into the console. Will be used as a means for the player to provide input when choosing their name and selecting a letter for the 2 blank tiles(not yet implemented).
 	Tiles also have a new variable that identifies them in a unique way ("number").


 	Jessica- changed the scoring system to be based on words and not letters, and fixed the swapping function so that it returns the swapped out tiles to the 'box' (Karol fixed this in how its displayed, but it the game still functioned without those tiles)
 01-22-16 (actually 01-21-16 late night)
 	Karol - Fixed a bug in the swapselect() method, did not swap tile scores when swapping letters. Most tiles had incorrect scores after swapping. Reverted to old commit to make sure I didn't break that. Added everything back in after bug was fixed.
 	Finally added the two blank tiles increading the amount of tiles to 100 (equal number and distribution to real Scrabble). The player may press any upper or lower case key (illegal keypresses do not crash the game) in order to assign a letter to a blank tile that he or she has previously selected. The selecting occurs in detect() and changes the boolean needsLetter to true. In keyspressed() a loop and a if statement find the tile with needsLetter = true and change the letter to the input from the Input class. The tile then sets its score to match the score the letter should have.
 	Bugs Introduced - Tiles now slide down to the left when being replenished (not really a bug but the behavior is different from the one before)(and that worries me).
	Might have broken new scoring system that tracked the score for entire words when a letter was added to them. This could be related to the other bug. (Will coordinate in class, ask how new scoring system works and fix bug) 
	01-24-16
	Major work on AI, now works ~90% (from 0%) of the time. 

	01-23/24-16
	Jessica- fixed a lot of buggy things (swapping, blank tiles, undoing, and scoring. and made the adding names thing.
	

	>>>  See commit notes for details. <<<
 	
