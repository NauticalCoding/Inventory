//
/*

	Client main script
	
	Nautical & Anarchy
	
	5/8/2015
*/

if (SERVER) then return end

local function AddChat(text, sender)

	if sender == 1 then // sent from client
		
		chat.AddText(Color(145,220,135), "[Inventory] ", color_white, text)
	else // must have been sent from server...
		local text = net.ReadString()
		
		chat.AddText(Color(145,220,135), "[Inventory] ", color_white, text)
	end
	
end
net.Receive("AddChat", AddChat)

local set = {
	pad = 5,
	boxX = 70,
	boxY = 70,
	boxesW = 10,
	boxesT = 5,
	title = "Inventory",
	font = "DermaDefault",
	admins = {"trialmod", "moderator", "admin", "superadmin", "owner"}
}

local inventory = {}
local function ReceiveInv()
	inventory = net.ReadTable()
end
net.Receive("SendInv", ReceiveInv)



// Make our nice blur effect (credit to chessnut)
// found here: http://facepunch.com/showthread.php?t=1440586&p=47046119&viewfull=1#post47046119
// and here: https://github.com/Chessnut/NutScript/blob/097c611c19f093a7a9d9a5d45f2fd73ac7d68309/gamemode/derma/cl_charmenu.lua#L8

local blur = Material("pp/blurscreen")
local function DrawBlurPanel(panel, amount, heavyness)


	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

local function DrawBlurRect(x, y, w, h, amount, heavyness)
	local X, Y = 0,0
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, scrW, scrH)
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end


// Create an easy button
local function DermaBut(text,method)

	local but = vgui.Create("DButton")
	but:SetText("")
	local col_cold, col_hot = Color(0, 0, 0, 0), Color(255, 90, 90, 100)
	local rect_col, text_col = color_white, color_white
	but.Paint = function(self, w, h)
		surface.SetDrawColor(self:IsHovered() and col_hot or col_cold)
		surface.DrawRect(0, 0, w, h)
			
		surface.SetDrawColor(rect_col)
		surface.DrawOutlinedRect(0, 0, w, h)

		draw.SimpleTextOutlined(text, set.font, w/2, h/2, text_col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	end
	
	but.DoClick = function()
	
		surface.PlaySound("UI/buttonclick.wav")
		method()
	end
	
	return but
end

// OUR MENUS

// ADMIN MENU
local function AdminMenu()
	
	if not table.HasValue(set.admins, LocalPlayer():GetUserGroup()) then return end // check again, just to be safe :)

	local frame = vgui.Create("DFrame")
	frame:SetSize(300,120)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Paint = function(self,w,h)
		DrawBlurPanel(self, 1, 10)
		
		surface.SetDrawColor(color_white)
		surface.DrawOutlinedRect(0,0,w-34,25)
		
		draw.SimpleTextOutlined("Admin", set.font, 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, color_black)
		
		draw.SimpleTextOutlined("Enter a 64-bit SteamID", set.font, w/2, 35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black)
	end

	local closeBut = DermaBut("X",function() 
	
		if frame:IsValid() && IsValid(frame) then
			frame:Close()
		end
	end)
	closeBut:SetParent(frame)
	closeBut:SetPos(frame:GetWide()-35,0)
	closeBut:SetSize(35,25)
	
	local idEntry = vgui.Create("DTextEntry", frame)
	idEntry:SetSize(frame:GetWide()-20, 25)
	idEntry:SetPos(10, 55)
	idEntry:SetText("")
	idEntry.OnEnter = function(self)
	
		local id = self:GetValue()
		if not (string.len(id) == 17) then AddChat("Enter a valid 64-bit SteamID!", 1) return end
		
		net.Start("OpenOtherInv")
			net.WriteString(id)
		net.SendToServer()
		
		if frame:IsValid() && IsValid(frame) then
			frame:Close()
		end
	end
	
	local confirmBut = DermaBut("Confirm",function()
		local id = idEntry:GetValue()
		if not (string.len(id) == 17) then AddChat("Enter a valid 64-bit SteamID!", 1) return end
		
		net.Start("OpenOtherInv")
			net.WriteString(id)
		net.SendToServer()
		
		if frame:IsValid() && IsValid(frame) then
			frame:Close()
		end
		
	end)
	confirmBut:SetParent(frame)
	confirmBut:SetPos(10,85)
	confirmBut:SetSize(frame:GetWide()/2-12.5,25)
	
	local cancelBut = DermaBut("Cancel",function() 
	
		if frame:IsValid() && IsValid(frame) then
			frame:Close()
		end
	end)
	cancelBut:SetParent(frame)
	cancelBut:SetPos(confirmBut.x+confirmBut:GetWide()+5,confirmBut.y)
	cancelBut:SetSize(confirmBut:GetWide(),confirmBut:GetTall())
end

// MAIN MENU
local function Main()

	local frame = vgui.Create("DFrame")
	frame:SetSize(set.boxX*set.boxesW + set.pad*set.boxesW+set.pad, set.boxY*set.boxesT + set.pad*set.boxesW+set.pad)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Paint = function(self,w,h)
		DrawBlurPanel(self, 1, 10)
		
		surface.SetDrawColor(color_white)
		surface.DrawOutlinedRect(0,0,w-34,25)
		
		draw.SimpleTextOutlined(set.title, set.font, 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, color_black)
	end
	
	local closeBut = DermaBut("X",function() 
	
		if frame:IsValid() && IsValid(frame) then
			frame:Close()
		end
	end)
	closeBut:SetParent(frame)
	closeBut:SetPos(frame:GetWide()-35,0)
	closeBut:SetSize(35,25)
	
	if table.HasValue(set.admins, LocalPlayer():GetUserGroup()) then
		local adminBut = DermaBut("Admin",function() 
		
			if frame:IsValid() && IsValid(frame) then
				frame:Close()
				AdminMenu()
			end
		end)
		adminBut:SetParent(frame)
		adminBut:SetPos(frame:GetWide()-75,0)
		adminBut:SetSize(35,25)
	end
	
	local iconLayout = vgui.Create("DIconLayout", frame)
	iconLayout:SetSize(frame:GetWide()-10, frame:GetTall()-35)
	iconLayout:SetPos(5,30)
	iconLayout:SetSpaceY(5)
	iconLayout:SetSpaceX(5)
	iconLayout.Paint = function(self,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(55,55,55,0))
	end
	
	for k,v in pairs(inventory) do
		for l,m in pairs(v) do
			local slot = vgui.Create("DPanel", iconLayout)
			slot:SetSize(set.boxX, set.boxY)
			slot:SetBackgroundColor(Color(55, 55, 55, 100))
			slot.Paint = function(self,w,h)
				surface.SetDrawColor(slot:GetBackgroundColor())
				surface.DrawRect(0,0,w,h)
				
				surface.SetDrawColor(Color(255,255,255,150))
				surface.DrawOutlinedRect(0,0,w,h)
			end

			if m.class ~= nil then // if there's a class
			
				local item = vgui.Create("DModelPanel", slot)
				item:SetSize(set.boxX, set.boxY)
				item:SetModel(m.model)
				item:SetCamPos(Vector(20, 20, 5))
				item:SetLookAt(Vector(0, 0, 0))
				item:SetTooltip(ReplaceClassWithName(m.class))
				
				item.OnCursorEntered = function()
					item:GetParent():SetBackgroundColor(Color(41, 128, 185, 100))
				end
				item.OnCursorExited = function()
					item:GetParent():SetBackgroundColor(Color(55, 55, 55, 100))
				end
				
				function item:OnMousePressed(but)
					
					if (but == MOUSE_RIGHT) then
						
						local menu = vgui.Create("DMenu")
						menu:Open()
						menu:AddOption(ReplaceClassWithName(m.class))
						
						menu:AddSpacer()
						
						
						menu:AddOption("Equip", function() 
							net.Start("Interact")
								net.WriteInt(1, 4) // argument
								net.WriteInt(k, 32)	// Row							
								net.WriteInt(l, 32) // Col
								net.WriteTable(m) // item
							net.SendToServer()
							
							item:Remove()
							AddChat("Equipped: " .. ReplaceClassWithName(m.class), 1)
						end):SetIcon("icon16/add.png")
						
						menu:AddOption("Drop", function() 
							net.Start("Interact")
								net.WriteInt(2, 4) // argument
								net.WriteInt(k, 32)	// Row							
								net.WriteInt(l, 32) // Col
								net.WriteTable(m) // item
							net.SendToServer()
							
							item:Remove()
							AddChat("Dropped: " .. ReplaceClassWithName(m.class), 1)
						end):SetIcon("icon16/arrow_down.png")
						
						menu:AddOption("Destroy", function() 
							net.Start("Interact")
								net.WriteInt(3, 4) // argument
								net.WriteInt(k, 32)	// Row							
								net.WriteInt(l, 32) // Col
								net.WriteTable(m) // item
							net.SendToServer()
							
							item:Remove()
							AddChat("Destroyed: " .. ReplaceClassWithName(m.class), 1)
						end):SetIcon("icon16/exclamation.png")

						menu:AddSpacer()
						
						menu:AddOption("Cancel"):SetIcon("icon16/arrow_left.png")
						
						
					end
				
				end
			
			end
				
			
		end
	end

end
usermessage.Hook("InvMenu", Main)

// Weapon display

local maxDis = 170
local function WeaponDisplay()
	local ent = LocalPlayer():GetEyeTrace().Entity
	
	if (!IsValid(ent)) then return end
	
	if (ent:GetClass() == "spawned_weapon") then
		if (ent:GetPos():Distance(LocalPlayer():GetPos()) > maxDis) then return end
		
		local class = ent:GetWeaponClass()
		
		local pos = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
		
		DrawBlurRect(pos.x-100, pos.y-10, 200, 40, 1, 10)
		
		surface.SetDrawColor(Color(255,255,255))		
		surface.DrawOutlinedRect(pos.x - 100, pos.y - 10, 200, 40)

		draw.SimpleTextOutlined((ReplaceClassWithName(class) or ""), "DermaDefault", pos.x, pos.y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		draw.SimpleTextOutlined("E to store | Shift+E to equip" , "DermaDefault", pos.x, pos.y+15, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	end
end
hook.Add("HUDPaint", "Inventory-WeaponDisplay", WeaponDisplay)