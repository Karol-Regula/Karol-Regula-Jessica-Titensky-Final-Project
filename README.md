# Karol-Regula-Jessica-Titensky-Final-Project
Final Project 2016 APCS

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