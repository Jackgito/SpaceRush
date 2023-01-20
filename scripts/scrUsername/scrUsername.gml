// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrUsername(){
	// Username
if global.gameState == "Username"
{
	if resetName == true
	{
		username = ""
		resetName = false
	}
	
	draw_set_font(fontMedium)
	draw_text(room_width/2,room_height/4,"Enter your username")
	draw_set_font(fontLarge)
	draw_text(room_width/2,room_height/2,username)
	
	username = keyboard_string
	if string_length(username) > string_length(username2)
	{
		username2 = username
		audio_play_sound(soundMenu,1,false)
    }
	
	if string_length(username) < string_length(username2)
	{
		username2 = username
		audio_play_sound(soundMenuClick,1,false)
    }
	
	
	if string_length(keyboard_string) > 18
   {
   keyboard_string = string_copy(keyboard_string, 1, 18);
   }
   
   

//
	
// Check username validity
	if keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space)
	{
		if string_length(username) > 0
		{
			if username == string_letters(username)
			{
				// Read and save preferences for the user
				ini_open("dataSpaceRush.ini")
				global.shipMovement = ini_read_string(username, "movement", "Default")
				global.shipColor = ini_read_string(username, "color", "Cold")
				global.music = ini_read_string(username, "music", musicElectroman)
				
		// Set ship settings based on old preferences
		if global.shipColor == "Cold" colorIndex = 1
		else if global.shipColor == "Warm" colorIndex = 2
		else if global.shipColor == "Camo" colorIndex = 3
		
		if global.shipMovement == "Sensitive" movementIndex = 1
		if global.shipMovement == "Default" movementIndex = 2
		if global.shipMovement == "Slow" movementIndex = 3
				
				ini_close()
				//
				audio_play_sound(soundSuccess,1,false)
				menuIndex = 1
				cooldown = 5
				global.gameState = "Main menu"
				username2 = ""
				resetName = true
			}
			else
			{
				audio_play_sound(soundError,1,false)
				errorNotLetter = 180	
			}
		}
		else
		{
			audio_play_sound(soundError,1,false)
			errorShort = 180
		}
	}

	if (errorShort > 0)
	{
		errorShort -= 1
		draw_set_font(fontMedium)
		draw_text(room_width/2,500,"Username is too short!")
	}

	if (errorNotLetter > 0)
	{
		errorNotLetter -= 1
		draw_set_font(fontMedium)
		draw_text(room_width/2,450,"Username can't contain numbers or special characters!")
	}
}
//

}