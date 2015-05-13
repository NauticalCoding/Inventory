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
	boxX = 50,
	boxY = 50,
	boxesW = 10,
	boxesT = 5,
	title = "Inventory",
	font = "DermaDefault"
}

local inventory = {}
local function ReceiveInv()
	inventory = net.ReadTable()
end
net.Receive("SendInv", ReceiveInv)

// Make our nice blur effect

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

local function Main()

	local frame = vgui.Create("DFrame")
	frame:SetSize(set.boxX*set.boxesW + set.pad*set.boxesW+set.pad, set.boxY*set.boxesT + set.pad*set.boxesW+set.pad)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Paint = function(self,w,h)
		DrawBlurPanel(self, 1, 15)
		
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
			slot:SetSize(50, 50)
			slot:SetBackgroundColor(Color(0, 0, 0, 130))
			slot.Paint = function(self,w,h)
				surface.SetDrawColor(slot:GetBackgroundColor())
				surface.DrawRect(0,0,w,h)
				
				surface.SetDrawColor(color_white)
				surface.DrawOutlinedRect(0,0,w,h)
			end

			if m.class ~= nil then // if there's a class
			
				local item = vgui.Create("DModelPanel", slot)
				item:SetSize(50, 50)
				item:SetModel(m.model)
				item:SetCamPos(Vector(20, 20, 5))
				item:SetLookAt(Vector(0, 0, 0))
				item:SetTooltip(m.class)
				
				item.OnCursorEntered = function()
					item:GetParent():SetBackgroundColor(Color(41, 128, 185, 100))
				end
				item.OnCursorExited = function()
					item:GetParent():SetBackgroundColor(Color(0, 0, 0, 130))
				end
				item.PaintOver = function()
					if item:IsHovered() then
						surface.SetDrawColor(color_white)
						surface.DrawOutlinedRect(0, 0, 50, 50)
					end
				end
				
				function item:OnMousePressed(but)
					
					if (but == MOUSE_RIGHT) then
						
						local menu = vgui.Create("DMenu")
						menu:Open()
						
						menu:AddOption("Equip", function() 
							net.Start("Interact")
								net.WriteInt(1, 4) // argument
								net.WriteInt(k, 32)	// Row							
								net.WriteInt(l, 32) // Col
								net.WriteTable(m) // item
							net.SendToServer()
							
							item:Remove()
							AddChat("Equipped: " .. m.class, 1)
						end):SetIcon("icon16/add.png")
						
						menu:AddOption("Drop", function() 
							net.Start("Interact")
								net.WriteInt(2, 4) // argument
								net.WriteInt(k, 32)	// Row							
								net.WriteInt(l, 32) // Col
								net.WriteTable(m) // item
							net.SendToServer()
							
							item:Remove()
							AddChat("Dropped: " .. m.class, 1)
						end):SetIcon("icon16/box.png")
						
						menu:AddOption("Destroy", function() 
							net.Start("Interact")
								net.WriteInt(3, 4) // argument
								net.WriteInt(k, 32)	// Row							
								net.WriteInt(l, 32) // Col
								net.WriteTable(m) // item
							net.SendToServer()
							
							item:Remove()
							AddChat("Destroyed: " .. m.class, 1)
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