
--[[
	FE Animation Player
	by minishakk
	
	It spawns an animation player, just insert an ID and watch your character come to life.
	
	Do NOT showcase, redistribute OR modify, without contacting @minishakk on Discord first, or unless permission granted by @minishakk (i grant mastersmz permission, pls showcase :p).

	All rights reserved.
	© 2025 minishakk
]]

local AnimPlayer = Instance.new("ScreenGui")
local TopFrame = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local IdBOX = Instance.new("TextBox")
local PlayBTN = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local CloseBTN = Instance.new("TextButton")

AnimPlayer.Name = "AnimPlayer"
AnimPlayer.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
AnimPlayer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TopFrame.Name = "TopFrame"
TopFrame.Parent = AnimPlayer
TopFrame.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
TopFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TopFrame.BorderSizePixel = 0
TopFrame.Position = UDim2.new(0.372395843, 0, 0.351251155, 0)
TopFrame.Size = UDim2.new(0, 489, 0, 51)
TopFrame.ZIndex = 9999999

MainFrame.Name = "MainFrame"
MainFrame.Parent = TopFrame
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 0, 1.0000006, 0)
MainFrame.Size = UDim2.new(0, 488, 0, 195)

IdBOX.Name = "IdBOX"
IdBOX.Parent = MainFrame
IdBOX.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
IdBOX.BorderColor3 = Color3.fromRGB(0, 0, 0)
IdBOX.BorderSizePixel = 0
IdBOX.Position = UDim2.new(0.217213109, 0, 0.157555833, 0)
IdBOX.Size = UDim2.new(0, 276, 0, 61)
IdBOX.Font = Enum.Font.RobotoMono
IdBOX.Text = "rbxassetid://ID_HERE"
IdBOX.TextColor3 = Color3.fromRGB(255, 255, 255)
IdBOX.TextScaled = true
IdBOX.TextSize = 14.000
IdBOX.TextWrapped = true

PlayBTN.Name = "PlayBTN"
PlayBTN.Parent = MainFrame
PlayBTN.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
PlayBTN.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayBTN.BorderSizePixel = 0
PlayBTN.Position = UDim2.new(0.295081973, 0, 0.643807888, 0)
PlayBTN.Size = UDim2.new(0, 200, 0, 50)
PlayBTN.Font = Enum.Font.SourceSansBold
PlayBTN.Text = "Play"
PlayBTN.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayBTN.TextScaled = true
PlayBTN.TextSize = 14.000
PlayBTN.TextWrapped = true

Title.Name = "Title"
Title.Parent = TopFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.0204498973, 0, 0.0196078438, 0)
Title.Size = UDim2.new(0, 200, 0, 50)
Title.Font = Enum.Font.SourceSansItalic
Title.Text = "Animation Player"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBTN.Name = "CloseBTN"
CloseBTN.Parent = TopFrame
CloseBTN.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
CloseBTN.BackgroundTransparency = 1.000
CloseBTN.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseBTN.BorderSizePixel = 0
CloseBTN.Position = UDim2.new(0.9043293, 0, 0.0196078438, 0)
CloseBTN.Size = UDim2.new(0, 45, 0, 50)
CloseBTN.Font = Enum.Font.SourceSans
CloseBTN.Text = "X"
CloseBTN.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBTN.TextScaled = true
CloseBTN.TextSize = 14.000
CloseBTN.TextWrapped = true

local function drag()
	local script = Instance.new('LocalScript', TopFrame)

	local frame = script.Parent
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
	    local delta = input.Position - dragStart
	    frame.Position = UDim2.new(
	        startPos.X.Scale,
	        startPos.X.Offset + delta.X,
	        startPos.Y.Scale,
	        startPos.Y.Offset + delta.Y
	    )
	end
	
	frame.InputBegan:Connect(function(input)
	    if input.UserInputType == Enum.UserInputType.MouseButton1 then
	        dragging = true
	        dragStart = input.Position
	        startPos = frame.Position
	
	        input.Changed:Connect(function()
	            if input.UserInputState == Enum.UserInputState.End then
	                dragging = false
	            end
	        end)
	    end
	end)
	
	frame.InputChanged:Connect(function(input)
	    if input.UserInputType == Enum.UserInputType.MouseMovement then
	        dragInput = input
	    end
	end)
	
	game:GetService("UserInputService").InputChanged:Connect(function(input)
	    if input == dragInput and dragging then
	        update(input)
	    end
	end)
	
end
coroutine.wrap(drag)()
local function play()
	local script = Instance.new('LocalScript', PlayBTN)

	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	
	local btn = script.Parent
	local idbox = btn.Parent.IdBOX
	
	local track
	local animated = false
	
	btn.Activated:Connect(function()
		if animated then
			if track then
				track:Stop()
				track:Destroy()
				track = nil
			end
			animated = false
			btn.Text = "Play"
		else
			local id = idbox.Text
			local anim = Instance.new("Animation")
			anim.AnimationId = id
	
			track = hum:LoadAnimation(anim)
			track.Looped = true
			track:Play()
	
			animated = true
			btn.Text = "Stop"
		end
	end)
end
coroutine.wrap(play)()
local function close()
	local script = Instance.new('LocalScript', CloseBTN)

	script.Parent.MouseEnter:Connect(function()
		script.Parent.BackgroundTransparency = 0
	end)
	
	script.Parent.MouseLeave:Connect(function()
		script.Parent.BackgroundTransparency = 1
	end)
	
	script.Parent.Activated:Connect(function()
		script.Parent.Parent:Destroy()
	end)
end
coroutine.wrap(close)()
local function notify()
	local script = Instance.new('LocalScript', AnimPlayer)

	local StarterGui = game:GetService("StarterGui")
	
	StarterGui:SetCore("SendNotification", {
		Title = "FE Anim Player",
		Text = "by minishakk, it plays animations.",
		Icon = "rbxassetid://6877509129",
		Duration = 2
	})
end
coroutine.wrap(notify)()

local ExpandBTN = Instance.new("TextButton")
ExpandBTN.Name = "ExpandBTN"
ExpandBTN.Parent = MainFrame
ExpandBTN.AnchorPoint = Vector2.new(1, 1)
ExpandBTN.Position = UDim2.new(1, -5, 1, -5)
ExpandBTN.Size = UDim2.new(0, 30, 0, 30)
ExpandBTN.BackgroundTransparency = 1
ExpandBTN.Text = ">"
ExpandBTN.Font = Enum.Font.SourceSansBold
ExpandBTN.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandBTN.TextScaled = true
ExpandBTN.ZIndex = 99999999

local SidePanel = Instance.new("Frame")
SidePanel.Name = "SidePanel"
SidePanel.Parent = TopFrame
SidePanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SidePanel.BorderSizePixel = 0
SidePanel.Position = UDim2.new(1, 0, 1.0000006, 0)
SidePanel.Size = UDim2.new(0, 200, 0, 195)
SidePanel.Visible = false
SidePanel.ZIndex = 9999998

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = SidePanel
ScrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ZIndex = 9999999

local InfoBox = Instance.new("TextBox")
InfoBox.Name = "InfoBox"
InfoBox.Parent = ScrollFrame
InfoBox.BackgroundTransparency = 1
InfoBox.Size = UDim2.new(1, -10, 0, 0)
InfoBox.Position = UDim2.new(0, 5, 0, 5)
InfoBox.TextWrapped = true
InfoBox.TextYAlignment = Enum.TextYAlignment.Top
InfoBox.TextXAlignment = Enum.TextXAlignment.Left
InfoBox.Text = game:HttpGet('https://raw.githubusercontent.com/shakk-code/fe-animation-player/main/animations.txt')
InfoBox.Font = Enum.Font.RobotoMono
InfoBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBox.TextSize = 14
InfoBox.ZIndex = 9999999
InfoBox.ClearTextOnFocus = false
InfoBox.MultiLine = true
InfoBox.TextEditable = false

ExpandBTN.MouseButton1Click:Connect(function()
	if SidePanel.Visible then
		SidePanel.Visible = false
		ExpandBTN.Text = ">"
	else
		SidePanel.Visible = true
		ExpandBTN.Text = "<"
	end
end)

local function updateCanvas()
	local textService = game:GetService("TextService")
	local textSize = textService:GetTextSize(
		InfoBox.Text,
		InfoBox.TextSize,
		InfoBox.Font,
		Vector2.new(InfoBox.AbsoluteSize.X, math.huge)
	)

	InfoBox.Size = UDim2.new(1, -10, 0, textSize.Y)
	ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, textSize.Y + 10)
end

InfoBox:GetPropertyChangedSignal("Text"):Connect(updateCanvas)
InfoBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateCanvas)

updateCanvas()
