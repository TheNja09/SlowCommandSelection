function _OnFrame()
	World = ReadByte(Now + 0x00)
	Room = ReadByte(Now + 0x01)
	Place = ReadShort(Now + 0x00)
	Door = ReadShort(Now + 0x02)
	Map = ReadShort(Now + 0x04)
	Btl = ReadShort(Now + 0x06)
	Evt = ReadShort(Now + 0x08)
	Cheats()
end

function _OnInit()
	if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
		Platform = 'PS2'
		Now = 0x032BAE0 --Current Location
		Save = 0x032BB30 --Save File
		Obj0 = 0x1C94100 --00objentry.bin
		Sys3 = 0x1CCB300 --03system.bin
		Btl0 = 0x1CE5D80 --00battle.bin
		Slot1 = 0x1C6C750 --Unit Slot 1
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
		Platform = 'PC'
		Now = 0x0714DB8 - 0x56454E
		Save = 0x09A7070 - 0x56450E
		GamSpd = 0x07151D4 - 0x56454E
		Obj0 = 0x2A22B90 - 0x56450E
		Sys3 = 0x2A59DB0 - 0x56450E
		Btl0 = 0x2A74840 - 0x56450E
		Slot1 = 0x2A20C58 - 0x56450E
	end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
	return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
   local _shortSpeed = ReadFloat(GamSpd)
   if _shortSpeed > 0.2 then
      if ReadLong(0x24AA2CA) ~= 0 and _shortSpeed ~= 0.25 then
         WriteFloat(GamSpd, 0.25)
      elseif Place == 0x0609 and _shortSpeed ~= 0.25 then --A Blustery Rescue
         if ReadByte(Cntrl) == 0 then --Minigame Started
            WriteFloat(GamSpd, 2)
         end
      elseif Place == 0x0409 and _shortSpeed ~= 0.25 then --Minigame Ended
         WriteFloat(GamSpd, 1)
      elseif Place == 0x0709 then --Hunny Slider
         if ReadByte(Cntrl) == 0 then --Minigame Started
            WriteFloat(GamSpd, 2)
         end
      elseif Place == 0x0309 and _shortSpeed ~= 0.25 then --Minigame Ended
         WriteFloat(GamSpd, 1)
	  elseif ReadLong(0x24AA2CA) == 0 and _shortSpeed ~= 1 then
         WriteFloat(GamSpd, 1)
      end
   end
end
