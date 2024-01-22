--[[---------------------------------------------------------------------------------------

	Mr Dx
	Created by Mr_Dx

	For discussions, information on future updates, and more, join
	my Discord: https://discord.gg/fD4e6WD

	MIT License

	Copyright (c) 2020-2021 Mr_Dx

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

---------------------------------------------------------------------------------------]]--

-- Branding!
local label =
[[ 
  //


  ███    ███ ██████          ██████  ██   ██ 
  ████  ████ ██   ██         ██   ██  ██ ██  
  ██ ████ ██ ██████          ██   ██   ███   
  ██  ██  ██ ██   ██         ██   ██  ██ ██  
  ██      ██ ██   ██ ███████ ██████  ██   ██ 
											 
																
  || 
  ||                        Created by Mr_Dx#0879

                 You Can Buy FiveM Server / Script / Bug Fix / Mlos:
				    https://www.fiverr.com/fivem_develop


  ||]]

-- Returns the current version set in fxmanifest.lua
function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

-- Grabs the latest version number from the web GitHub
PerformHttpRequest( "https://wolfknight98.github.io/wk_wars2x_web/version.txt", function( err, text, headers )
	-- Wait to reduce spam
	Citizen.Wait( 2000 )

	-- Print the branding!
	print( label )

	-- Get the current resource version
	local curVer = GetCurrentVersion()


	-- Warn the console if the resource has been renamed, as this will cause issues with the resource's functionality.
	if ( GetCurrentResourceName() ~= "Mr_Dx" ) then
		print( "^1ERROR: Any Problem or Any Need of QBUS Server, Mr Dx if Always will be with you ^0\n\n" )
	end
end )