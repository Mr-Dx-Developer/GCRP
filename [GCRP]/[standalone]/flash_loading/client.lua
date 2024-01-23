lib.registerContext({
	id = 'video_menu',
	title = 'Configure the loading screen to your liking!',
	options = {
		{
			title = 'Reset video.',
			onSelect = function(args)
				lib.callback('core:video', false, function(check)
					exports.ba_hud:SendAlert('info', ('You reset the loading screen video correctly.'), 5000)
				end, 'reset')
			end,
		},
		{
			title = 'Get your personalized video',
			onSelect = function(args)
				lib.callback('core:video', false, function(video)
					lib.setClipboard(video)
					exports.ba_hud:SendAlert('info', ('You copied the loading screen video successfully.'), 5000)
				end, 'get')
			end,
		},
		{
			title = 'Customize your video to your liking.',
			onSelect = function(args)
				local input = lib.inputDialog('¿What video do you want to post??', {
					{ type = "input", label = "Video (YouTube)", placeholder = "https://www.youtube.com/watch?v=ur6uoxXY-7M&t=75s" },
				})
				if input and input[1] then
					lib.callback('core:video', false, function(check)
						exports.ba_hud:SendAlert('info', ('You changed the loading screen video successfully.'), 5000)
					end, 'update', input[1])
				end
			end,
		},
	},
})

RegisterCommand('video', function()
	lib.showContext('video_menu')
end, false)