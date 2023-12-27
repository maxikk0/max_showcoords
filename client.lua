local showCoords = false
local lastToggleTime = 0
local cooldownTime = Config.Cooldown

RegisterCommand(Config.Command, function()
    local currentTime = GetGameTimer()

    if currentTime - lastToggleTime > cooldownTime then
        showCoords = not showCoords
        lastToggleTime = currentTime
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if showCoords then
            local playerPed = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(playerPed))
            local heading = GetEntityHeading(playerPed)

            local coordsText = string.format('X: %.2f, Y: %.2f, Z: %.2f, Heading: %.2f', x, y, z, heading)

            DrawTxt(Config.TextPosition, Config.TextScale, coordsText, Config.TextColor)
        else
            Citizen.Wait(cooldownTime)
        end
    end
end)

function DrawTxt(position, scale, text, color)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)

    DrawText(position.x, position.y)
end
