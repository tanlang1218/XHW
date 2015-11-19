--
-- Author: Student
-- Date: 2015-11-09 15:08:12
--
local MainScene=class("MainScene", function()
	return display.newScene()
end)

function MainScene:ctor()
	cc.ui.UILabel.new({
		UIlableType=2,
		text="heka",
		size=64
		})
	:align(display.CENTER, display.cx,display.cy)
	:addTo(self)
	self.exNode=EXNode.new()
	self.exNode:addEveneListener("MY_NEWS",
		handler(self, self.onMynews))
	self:addChild(self.exNode)
end

function MainScene:onMynews(  )	
print("INFO","父Node知道了子Node发过来的消息")
end

function MainScene:onEnter()
	-- body
end

function MainScene:onExit()
	-- body
end

return MainScene