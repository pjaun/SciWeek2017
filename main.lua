-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local function onComplete( event )
    if event.action == "clicked" then
        local i = event.index
        if i == 1 then
            transition.to( ErrorImg, { time=200,alpha=0 } )
        	transition.to( webView, { time=200,alpha=1 } )
            webView:reload( )
        end
    end
end

local function webListener( event )
    if event.type ~= "loaded" then
	    native.setActivityIndicator( true )
	 else
	    native.setActivityIndicator( false )
	end
  
    if event.errorCode then
    	native.setActivityIndicator( false )
    	transition.to( webView, { alpha = 0 } )
    	transition.to( ErrorImg, { alpha = 1 } )
        native.showAlert( "Error!", "ระบบยังไม่พร้อมใช้งาน"..event.errorCode, { "OK" } ,onComplete )
    end
end

local function onKeyEvent( event )
	
	if (event.keyName == "back") then
		webView:back()
		return true
	end

	-- Return false to indicate that this app is *not* overriding the received key.
	-- This lets the operating system execute its default handling of this key.
	return false
end
  
webView = native.newWebView( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
ErrorImg = display.newImage( "assets/sciweek.png"  ,display.contentCenterX	,0)
transition.to( ErrorImg, {alpha = 0} )

webView:request( "http://scw.science.cmu.ac.th/apps" )
  
webView:addEventListener( "urlRequest", webListener )

Runtime:addEventListener( "key", onKeyEvent ); -- เพิ่มในส่วนของการตรวจจับการกดปุ่ม back


