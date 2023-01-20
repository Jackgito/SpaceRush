function scrMenu(index,name) {
	if menuIndex == index
	{	
		draw_set_color(c_aqua)
		draw_set_font(fontMediumPlus)
		draw_text(room_width/2, index * 80 + 100, name)
		draw_set_font(fontMedium)
		draw_set_color(c_white)
		
		if (keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space)) and cooldown == 0 and start == false
		{
			if name == "Exit" game_end()
			else if name == "Play"
			{
				audio_play_sound(soundSuccess, 1, false)
				menuIndex = 1
				start = true
			}
			else if name == "Back"
			{
				cooldown = 5
				menuIndex = 1
				global.gameState = "Main menu"
			}
			else
			{
			cooldown = 5
			menuIndex = 1
			global.gameState = name
			}
		}
	}
	else
	{
		draw_set_font(fontMedium)
		draw_text(room_width/2, index * 80 + 100, name)
	}

}

function scrMenuShips() {
		if keyboard_check_pressed(vk_left) or keyboard_check_pressed(vk_right) audio_play_sound(soundMenu,1,false)
		draw_set_color(c_white)
		draw_set_halign(fa_center)
		draw_set_font(fontLarge)
		draw_text(room_width/2,20,"Ships")
		
		if colorIndex == 1 global.shipColor = "Cold"
		else if colorIndex == 2 global.shipColor = "Warm"
		else if colorIndex == 3 global.shipColor = "Camo"
		
		if movementIndex == 1 global.shipMovement = "Sensitive"
		else if movementIndex == 2 global.shipMovement = "Default"
		else if movementIndex == 3 global.shipMovement = "Slow"
		
	if menuIndex == 1
	{
		draw_set_color(c_aqua)
		draw_set_font(fontMediumPlus)
		draw_text(room_width/2, 200, "Color: " + string(global.shipColor))
		
		if keyboard_check_pressed(vk_left) colorIndex += 1
		if keyboard_check_pressed(vk_right) colorIndex -= 1
		if colorIndex > 3 colorIndex = 1
		if colorIndex < 1 colorIndex = 3
	}
	else
	{
		draw_set_font(fontMedium)
		draw_set_color(c_white)
		draw_text(room_width/2, 200, "Color: " + string(global.shipColor))
	}
	
	
	if menuIndex == 2
	{
		draw_set_color(c_aqua)
		draw_set_font(fontMediumPlus)
		draw_text(room_width/2, 300, "Movement: " + string(global.shipMovement))
		if keyboard_check_pressed(vk_left) movementIndex += 1
		if keyboard_check_pressed(vk_right) movementIndex -= 1
		if movementIndex > 3 movementIndex = 1
		if movementIndex < 1 movementIndex = 3
	}
	else
	{
		draw_set_font(fontMedium)
		draw_set_color(c_white)
		draw_text(room_width/2, 300, "Movement: " + string(global.shipMovement))
	}
	
	if menuIndex == 3
	{
		draw_set_color(c_aqua)
		draw_set_font(fontMediumPlus)
		draw_text(room_width/2, 400, "Back")
		if (keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space)) and cooldown == 0
		{
			// Save ship color and movement type to ini file
			ini_open("dataSpaceRush.ini")
			ini_write_string(username, "color", global.shipColor)
			ini_write_string(username, "movement", global.shipMovement)
			ini_close()
			//
			cooldown = 5
			menuIndex = 1
			global.gameState = "Options"
		}
	}
	else
	{
		draw_set_font(fontMedium)
		draw_set_color(c_white)
		draw_text(room_width/2, 400, "Back")
	}
}


function scrMenuMusic(index,name) {
	if menuIndex == index
	{	
		draw_set_font(fontLarge)
		draw_text(room_width/2,20,"Music")
		draw_set_color(c_aqua)
		draw_set_font(fontMediumPlus)
		draw_text(room_width/2, index * 60 + 50, name)
		draw_set_font(fontMedium)
		draw_set_color(c_white)
		
		if (keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space)) and cooldown == 0
		{
			if name == "Back"
			{
				// Save music preference to ini file
				ini_open("dataSpaceRush.ini")
				ini_write_string(username, "music", global.music)
				ini_close()
				//
				cooldown = 5
				menuIndex = 1
				global.gameState = "Options"
			}
			else if name == "Electroman Adventures"
			{
			cooldown = 5
			global.music = musicElectroman
			}
			else if name == "One Against the World"
			{
			cooldown = 5
			global.music = musicOneAgainst
			}
			else if name == "Deja Vu"
			{
			cooldown = 5
			global.music = musicDejaVu
			}
			else if name == "Through the Fire and Flames"
			{
			cooldown = 5
			global.music = musicFireFlames
			}
			else if name == "My Heart"
			{
			cooldown = 5
			global.music = musicMyHeart
			}
			else if name == "Strength of a Thousand Men"
			{
			cooldown = 5
			global.music = musicStrength
			}
		}	
	}
	else
	{
		// Set color to orange if selected
		var color = make_color_rgb(255,215,0)
		if global.music == musicElectroman and index == 1 draw_set_color(color)
		else if global.music == musicOneAgainst and index == 2 draw_set_color(color)
		else if global.music == musicDejaVu and index == 3 draw_set_color(color)
		else if global.music == musicFireFlames and index == 4 draw_set_color(color)
		else if global.music == musicMyHeart and index == 5 draw_set_color(color)
		else if global.music == musicStrength and index == 6 draw_set_color(color)
		//
		draw_set_font(fontMedium)
		draw_text(room_width/2, index * 60 + 50, name)
		draw_set_color(c_white)
	}

}