function scrGame(){
	if global.gameState == "Play"
	{

	// Setup/Start
	if global.timer == 0
	{
		instance_create_depth(-200, 500, -1, objPlayer)
		audio_play_sound(global.music,1,true)
	}
	if gameOver == 0 global.timer += 1/game_get_speed(gamespeed_fps)
	layer_hspeed("Background", -power(global.timer, 0.5) - 1)
	
	// Game loop
	spawnFrequency -= random_range(global.timer^0.2, global.timer^0.5)
	
	if spawnFrequency < 0 and gameOver < 120
	{
	asteroidType = choose(objAsteroidLarge, objAsteroidMedium, objAsteroidSmall)
	

	spawnLocationX = room_width + 60
	spawnLocationY = random_range(0, room_height)
	
	instance_create_depth(spawnLocationX, spawnLocationY, 1, asteroidType)
	spawnFrequency = 400 + 5 * global.timer
	
	}
}

// Game over
if !instance_exists(objPlayer) and global.gameState == "Play"
{
	gameOver += 1
	if !instance_exists(objFade)
	{
	audio_stop_sound(global.music)
	instance_create_depth(room_width/2, room_height/2, -1000, objFade)
	audio_play_sound(soundGameOver, 1, false)
	}
		
	if gameOver > 300 and (mouse_check_button(mb_left) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter))
	{
	layer_hspeed(sprBackground,-1)
	personalBest = false
	gameOver = 0
	layer_hspeed("Background", -1)
	global.gameState = "Main menu"
	global.timer = 0
	spawnFrequency = 0
	audio_stop_sound(SoundHighScore)
	audio_stop_sound(soundPersonalBest)
	audio_sound_gain(music8bit, 0.35, 120)
	}
}

// Draw
if global.gameState == "Play" and global.timer > 0
{
	draw_set_alpha(1)
	draw_set_font(fontMedium)
	draw_set_halign(fa_right)
	draw_text(955, 530, global.timer)
}

if gameOver > 150
{
	instance_destroy(asteroids)
	draw_set_font(fontLarge)
	draw_set_halign(fa_center)
	draw_text(room_width/2, room_height/2 - 100, "GAME OVER")
}
if gameOver > 260 scrHighScoresSave(username,gameOver)
}