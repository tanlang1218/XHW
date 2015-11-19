--
-- Author: zyuq
-- Date: 2015-11-13 11:31:01
--
local HRocker = class("HRocker", function()
	return display.newLayer()
end)

function HRocker:ctor()
	self:init()
end

function HRocker:init()
	local widget = cc.uiloader:load("HRockerLayer.csb"):addTo(self)
	
    self.Sprite_HRocker = widget:getChildByName("Sprite_HRocker")
    self.Sprite_HRockerBG = widget:getChildByName("Sprite_HRocker_BG")   

    self.tagDirecton = {rocker_stay     = 0,    -- 保持
                        rocker_right    = 1,    -- 向右
                        rocker_up_right = 2,    -- 右上
                        rocker_up       = 3,    -- 向上
                        rocker_up_left  = 4,    -- 左上
                        rocker_left     = 5,    -- 向左
                        rocker_down_left= 6,    -- 左下
                        rocker_down     = 7,    -- 向下
                        rocker_down_right =8,}  -- 右下

	self.Sprite_HRocker:setVisible(false)
    self.Sprite_HRockerBG:setVisible(false)
    -- 初始化摇杆方向
    self.rockerDirection = 0
    self.faceDirection = false  -- 默认英雄的脸向右
    -- 是否可操作摇杆
    self.isCanMove = false

    -- 平砍按钮
    local pugongBtn = widget:getChildByName("Button_PingKan")
    
end
 
 -- 启动摇杆
 function HRocker:startRocker()
	self.Sprite_HRocker:setVisible(true)
    self.Sprite_HRockerBG:setVisible(true)

    -- 创建监听器
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(handler(self, self.rockerBegan), cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(handler(self, self.rockerMoved), cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(handler(self, self.rockerEnded), cc.Handler.EVENT_TOUCH_ENDED)
    dispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    
end

function HRocker:stopRocker()
	self.Sprite_HRocker:setVisible(false)
    self.Sprite_HRockerBG:setVisible(false)
    -- 这里移除了点击事件
    self:removeNodeEventListener(self.touchId)    
end

function HRocker:rockerBegan(touch, event)
	local point = touch:getLocation()
	if not cc.rectContainsPoint(self.Sprite_HRockerBG:getBoundingBox(), point) then
		return false
	end
    self.isCanMove = true
	return true
end

function HRocker:rockerMoved(touch, event)
    if not self.isCanMove then return end
	-- 获取摇杆原点位置
	local originX, originY = self.Sprite_HRockerBG:getPosition()
	-- 获取触摸位置
	local touchPoint = touch:getLocation()
	local touchX = touchPoint.x
	local touchY = touchPoint.y
	-- 计算触摸点到摇杆的距离
	local dis = cc.pGetDistance(cc.p(originX, originY), cc.p(touchX, touchY))
    -- 获取摇杆半径
    local rockerBGR = self.Sprite_HRockerBG:getContentSize().width / 2
    -- 计算弧度
    local angle = math.acos((touchX - originX) / dis)
    if touchY < originY then
    	angle = -angle
    end
    -- 设置位置
    if dis > rockerBGR then
    	self.Sprite_HRocker:setPosition(cc.p(originX + rockerBGR * math.cos(angle), originY + rockerBGR * math.sin(angle)))
    else
    	self.Sprite_HRocker:setPosition(touch:getLocation())
    end

    -- 记录方向
    local PI = math.pi
    if (angle >= -PI/8 and angle < PI/8) then
    	self.rockerDirection = self.tagDirecton.rocker_right
        self.faceDirection = false
    elseif (angle >= PI/8 and angle < PI*3/8) then
    	self.rockerDirection = self.tagDirecton.rocker_up_right
        self.faceDirection = false
    elseif (angle >= PI*3/8 and angle < PI*5/8) then
    	self.rockerDirection = self.tagDirecton.rocker_up
    elseif (angle >= PI*5/8 and angle < PI*7/8) then
    	self.rockerDirection = self.tagDirecton.rocker_up_left
        self.faceDirection = true
    elseif (angle >= PI*7/8 or angle < -PI*7/8) then
    	self.rockerDirection = self.tagDirecton.rocker_left
        self.faceDirection = true
    elseif (angle >= -PI*7/8 and angle < -PI*5/8) then
    	self.rockerDirection = self.tagDirecton.rocker_down_left
        self.faceDirection = true
    elseif (angle >= -PI*5/8 and angle < -PI*3/8) then
    	self.rockerDirection = self.tagDirecton.rocker_down
    elseif (angle >= -PI*3/8 and angle < -PI*1/8) then
    	self.rockerDirection = self.tagDirecton.rocker_down_right
        self.faceDirection = false
    end

end

function HRocker:rockerEnded(touch, event)
	self.Sprite_HRocker:setPosition(self.Sprite_HRockerBG:getPosition())
    self.isCanMove = false
    self.rockerDirection = self.tagDirecton.rocker_stay
end

return HRocker