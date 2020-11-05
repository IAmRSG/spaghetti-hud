money = 0
mystress = nil
isloaded = false

RegisterNetEvent("gui:getItems")
AddEventHandler("gui:getItems", function(THEITEMS)
    SendNUIMessage({
       items = THEITEMS,
    })
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    isloaded = true
end)

--[[
RegisterNetEvent("gui:getStress")
AddEventHandler("gui:getStress", function(stress)
    mystress = stress
    print("Questo è il tuo stress:"..mystress)
end) 

RegisterNetEvent("gui:setstress") 
AddEventHandler("gui:setstress", function()
    local _src = source
    TriggerServerEvent("maliko:notstress")
end)

Citizen.CreateThread(function()
    TriggerEvent("gui:setstress")
    print("Triggero il lato Server")
end)]]

--[[Citizen.CreateThread(function()  QUESTO THREAD DIMINUISCE LO STRESS DEL GIOCATORE OGNI 30 SECONDI DI 3. 
while true do 
    Wait(30000)
    --TriggerServerEvent("AbbassaStress", mystress)
    --mystress = nil
end
end)]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if isloaded then
            local _source = source 
        --	TriggerServerEvent("hud:checkmoney")
            Citizen.InvokeNative(0x50C803A4CD5932C5 , true)
            local myhunger
            local mythirst
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            Citizen.InvokeNative(0xB98B78C3768AF6E0,true)
            local temp = GetTemperatureAtCoords(coords)
            local _src = source

            TriggerEvent("vorpmetabolism:getValue","Thirst",function(value)
                if value == nil then
                    mythirst = 0
                else
                    mythirst = value / 10
                end
            end)
            
            TriggerEvent("vorpmetabolism:getValue","Hunger",function(value)  
                if value == nil then
                    myhunger = 0
                else
                    myhunger = value / 10
                end
            end)


            SendNUIMessage({
                action = "updateStatusHud",
                    show = not IsRadarHidden(),
                    hunger = myhunger,
                    thirst = mythirst,
                -- stress = mystress,
                -- cash = money,
                    temp = math.floor(temp * 1.8 + 32.0).."°F", 
                    --temp= math.floor(temp).."°C", -- You can switch to C by commenting the line above, and uncommenting this line.
            })
            Citizen.Wait(1000)
        end
    end
end)
--[[
RegisterNetEvent("StressaPlayer")
AddEventHandler("StressaPlayer", function(qt)
    stress = 0
    mystress = nil
    TriggerServerEvent("maliko:stressa",qt)
    print("Il giocatore è stato stressato di "..qt)
end)

]]

--[[RegisterCommand("malikomistressa", function()
    TriggerEvent("StressaPlayer", 10)
end)]]


-- TriggerEvent("StressaPlayer", 100)  -- AGGIUNGE X STRESS 
