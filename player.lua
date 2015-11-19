--
-- Author: Student
-- Date: 2015-11-16 14:54:50
--
local player=class("player", function ()
	return display.newSprite("icon.png"
		)
end)

function player:ctor() 
	-- self:addStateMachine()
end

function player:doEvent()
	-- if self.fsm:canDoEvent(event) then
	--     self.fsm:doEvent(event)
 --  end
end

function player:addStateMachine() 
-- 	self.fsm={}
-- cc.GameObject.extend(self.fsm):addComponent("components.behavior.StateMachine"):exportMethods()
-- self.fsm:setupState({
-- 	initial="idle",
-- 	events={
-- 	{name ="move",   from={"idle", "jump"}, to ="walk"},
-- 	{name ="attack", from={"idle", "walk"}, to ="jump"},  
--     {name ="normal", from={"walk", "jump"}, to ="idle"}, },})

end

function player:attack( )
 --    self.armature=ccs.Armature:create("paobu")
	-- -- self.armature:getAnimation():playWithIndex(0)
	-- self.armature:getAnimation():play("PB")
	-- self.armature:setPosition(display.cx,display.cy)
	-- self.armature:setScale(1)
	-- self:addChild(self.armature,2)
 end 

 function player:run( )
 --   self.armature=ccs.Armature:create("paobu")
	-- -- self.armature:getAnimation():playWithIndex(0)
	-- self.armature:getAnimation():play("PB")
	-- self.armature:setPosition(display.cx,display.cy)
	-- self.armature:setScale(1)
	-- self:addChild(self.armature,2)
 end 

 function player:skill1( )
   -- body
   --播放动画
 end 

 function player:skill2( )
   -- body
   --播放动画
 end 

 function player:skill3( )
   -- body
   --播放动画
 end 

return player 