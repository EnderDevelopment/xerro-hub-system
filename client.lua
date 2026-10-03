local isUIOpen = false
local isFlyEnabled = false
local isNoclipEnabled = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isUIOpen then
            DrawUI()
        end
    end
end)

function DrawUI()
    local x = Config.UIPosition.x
    local y = Config.UIPosition.y
    local width = Config.UISize.width
    local height = Config.UISize.height
    
    DrawRect(x, y, width, height, Config.UIColor.r, Config.UIColor.g, Config.UIColor.b, Config.UIColor.a)
    DrawText(Config.UIText, x, y - height / 2, 0.4, 0, 255, 255, 255, 255)
    
    if IsControlJustPressed(1, 177) then -- Backspace key
        isUIOpen = false
    end
    
    if IsControlJustPressed(1, 38) then -- E key
        ToggleFly()
    end
    
    if IsControlJustPressed(1, 21) then -- Left Shift key
        ToggleNoclip()
    end
end

function ToggleFly()
    isFlyEnabled = not isFlyEnabled
    if isFlyEnabled then
        SetFlyMode(true)
    else
        SetFlyMode(false)
    end
end

function SetFlyMode(enabled)
    local playerPed = PlayerPedId()
    if enabled then
        SetEntityInvincible(playerPed, true)
        SetEntityVisible(playerPed, false, false)
        SetPlayerInvincible(PlayerId(), true)
        SetPedCanRagdoll(playerPed, false)
        SetEntityCollision(playerPed, false, false)
        FreezeEntityPosition(playerPed, true)
        SetEntityAlpha(playerPed, 51, false)
        SetPlayerInvincible(PlayerId(), true)
        SetPedCanRagdoll(playerPed, false)
        SetEntityCollision(playerPed, false, false)
        FreezeEntityPosition(playerPed, true)
        SetEntityAlpha(playerPed, 51, false)
        while isFlyEnabled do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local forward = GetEntityForwardVector(playerPed)
            local speed = Config.FlySpeed
            
            if IsControlPressed(1, 32) then -- W key
                coords = coords + forward * speed
            end
            if IsControlPressed(1, 33) then -- S key
                coords = coords - forward * speed
            end
            if IsControlPressed(1, 34) then -- A key
                coords = coords - GetEntityRightVector(playerPed) * speed
            end
            if IsControlPressed(1, 35) then -- D key
                coords = coords + GetEntityRightVector(playerPed) * speed
            end
            if IsControlPressed(1, 21) then -- Left Shift key
                coords = coords + vector3(0.0, 0.0, speed)
            end
            if IsControlPressed(1, 20) then -- Left Ctrl key
                coords = coords - vector3(0.0, 0.0, speed)
            end
            
            SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false)
        end
    else
        SetEntityInvincible(playerPed, false)
        SetEntityVisible(playerPed, true, false)
        SetPlayerInvincible(PlayerId(), false)
        SetPedCanRagdoll(playerPed, true)
        SetEntityCollision(playerPed, true, true)
        FreezeEntityPosition(playerPed, false)
        SetEntityAlpha(playerPed, 255, false)
    end
end

function ToggleNoclip()
    isNoclipEnabled = not isNoclipEnabled
    if isNoclipEnabled then
        SetNoclipMode(true)
    else
        SetNoclipMode(false)
    end
end

function SetNoclipMode(enabled)
    local playerPed = PlayerPedId()
    if enabled then
        SetEntityInvincible(playerPed, true)
        SetEntityVisible(playerPed, false, false)
        SetPlayerInvincible(PlayerId(), true)
        SetPedCanRagdoll(playerPed, false)
        SetEntityCollision(playerPed, false, false)
        FreezeEntityPosition(playerPed, true)
        SetEntityAlpha(playerPed, 51, false)
        while isNoclipEnabled do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local forward = GetEntityForwardVector(playerPed)
            local speed = Config.NoclipSpeed
            
            if IsControlPressed(1, 32) then -- W key
                coords = coords + forward * speed
            end
            if IsControlPressed(1, 33) then -- S key
                coords = coords - forward * speed
            end
            if IsControlPressed(1, 34) then -- A key
                coords = coords - GetEntityRightVector(playerPed) * speed
            end
            if IsControlPressed(1, 35) then -- D key
                coords = coords + GetEntityRightVector(playerPed) * speed
            end
            if IsControlPressed(1, 21) then -- Left Shift key
                coords = coords + vector3(0.0, 0.0, speed)
            end
            if IsControlPressed(1, 20) then -- Left Ctrl key
                coords = coords - vector3(0.0, 0.0, speed)
            end
            
            SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false)
        end
    else
        SetEntityInvincible(playerPed, false)
        SetEntityVisible(playerPed, true, false)
        SetPlayerInvincible(PlayerId(), false)
        SetPedCanRagdoll(playerPed, true)
        SetEntityCollision(playerPed, true, true)
        FreezeEntityPosition(playerPed, false)
        SetEntityAlpha(playerPed, 255, false)
    end
end

RegisterCommand('hub', function()
    isUIOpen = not isUIOpen
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isFlyEnabled or isNoclipEnabled then
            DisableControlAction(0, 32, true) -- W
            DisableControlAction(0, 33, true) -- S
            DisableControlAction(0, 34, true) -- A
            DisableControlAction(0, 35, true) -- D
            DisableControlAction(0, 21, true) -- Left Shift
            DisableControlAction(0, 20, true) -- Left Ctrl
        end
    end
end)