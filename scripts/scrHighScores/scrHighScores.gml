function scrHighScoresShow(){
	if !file_exists("highScores.txt") draw_text(room_width/2,room_height/2, "No high scores")
	else
	{
		scores = []
		file = file_text_open_read("highScores.txt")
		
		// Read high score file and save scores to an array
		for (var i = 0; i < 10; ++i;)
		{
			scor = file_text_read_string(file)
			array_push(scores, scor)
			file_text_readln(file)
		}
		
		draw_set_font(fontSmall)
		for (var i = 0; i < array_length(scores); ++i)
		{
			if i > 2 draw_set_color(c_gray)
			if i == 2 draw_set_color(c_orange)
			if i == 1 draw_set_color(c_white)
			if i == 0  draw_set_color(c_yellow)
			
			draw_text(room_width/2, 40 * i + 110, scores[i])
		}
		file_text_close(file)
	}
	
}

function scrHighScoresSave(username, gameOver) {
	if gameOver == 270
	{
		index = 0
		personalBest = false
		scores = []
	}
	// After the player loses, this function will save the score (global.timer)
	//  and username to highScore.txt while also sorting all the scores.
	if !file_exists("highScores.txt")
	{
		file = file_text_open_write("highScores.txt");
		file_text_write_string(file, username + " " + string(global.timer))
		file_text_close(file)	
	}
	else if gameOver == 280
	{
		file = file_text_open_read("highScores.txt")

		// Save new and old scores to an array, then sort it
		while file_text_eof(file) == false
		{
			line = file_text_read_string(file)
			scor = string_digits(line)
			scor = string_insert(".", scor, string_length(scor) - 1) // Add decimal point
			scor = real(scor)
			name = string_letters(line)
			scores[index,0] = name
			scores[index,1] = scor
			index += 1
			line = file_text_readln(file)
		}

		file_text_close(file)

		// Check if user has existing score. If it is lower than the new one, overwrite it
		for (var i = 0; i < array_length(scores); ++i)
		{
			if username == scores[i,0] // If username exists
			{
				if global.timer > scores[i,1] // Overwrite old score if new is higher
				{
					personalBest = true
					scores[i,1] = global.timer
					break
				}
				else break
			}
			else if i == array_length(scores) - 1 // If last iteration and username isn't found on the array, add new score to it
			{
				scores[i + 1, 0] = username
				scores[i + 1, 1] = global.timer
			}
		}
		
		if array_length(scores) == 0 // If no scores exist
		{
			scores[0,0] = username
			scores[0,1] = global.timer
		}
		
		array_sort(scores, function(a, b) { return real(b[1]) - real(a[1]); })
		//

		// Delete old file and make a new one from the sorted array
		file_delete("highScores.txt")
		file = file_text_open_write("highScores.txt")
		for (var i = 0; i < array_length(scores); ++i)
		{
			if i != 0 file_text_writeln(file)
			file_text_write_string(file, string(scores[i,0]) + " " + string(scores[i,1]))
		}
		file_text_close(file)
		}
	
		// Shows if high score or personal best was achieved

		if gameOver > 280
		{
			if scores[0,0] == username and scores[0,1] == global.timer
			{
				if gameOver == 281
				{
				draw_set_font(fontMediumPlus)
				audio_play_sound(SoundHighScore,1,false)
				}
				draw_text(room_width/2,room_height/2, "New high score!")
			}
			else if personalBest == true
			{
				if gameOver == 281
				{
				draw_set_font(fontMediumPlus)
				audio_play_sound(soundPersonalBest,1,false)
				}
				draw_text(room_width/2,room_height/2, "New personal best!")
			}
		}
}
