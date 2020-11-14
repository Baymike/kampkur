--BU SCRİPT BayMike TARAFINDAN KODLANMIŞTIR  --

RegisterCommand("kampkur",function()
    crouch()                                
    
    TriggerEvent("mythic_progbar:client:progress", {
        name = "campsetup",
        duration = 9000,
        label = "Çadır kuruluyor",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
              
            TriggerEvent("mythic_progbar:client:progress", {
                name = "campfire",
                duration = 4000,
                label = "Kamp ateşi yakılıyor",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(status)
                if not status then
                    local ped = PlayerPedId()
                    local pcoords = GetEntityCoords(ped)
                    local campfire  = CreateObject(`prop_beach_fire`, pcoords.x-1, pcoords.y-1.5, pcoords.z-1.6, false, true, true)
                    local tent = CreateObjectNoOffset(`prop_skid_tent_01`, pcoords.x-1.5, pcoords.y-3.5, pcoords.z-0.3, false, true, true)
                    local chair = CreateObjectNoOffset(`prop_skid_chair_02`, pcoords.x-3.5, pcoords.y-3.5, pcoords.z-0.6, false, true, true)
                    SetEntityHeading(chair, 100.0)
                else
                    print("iptal")
                end
            end)
        else
            print("iptal")
        end
        ClearPedTasks(PlayerPedId(-1))
    end)
end)

function crouch()
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'world_human_gardener_plant', 0, false)
end

RegisterCommand("isin",function()
    local ped = PlayerPedId()
    local pcoords = GetEntityCoords(ped)
    local entity = GetClosestObjectOfType(pcoords, 1.0, `prop_beach_fire`, false, false, false)
    local entityCoords = GetEntityCoords(entity)
   
    print (DoesEntityExist(entity))
    if DoesEntityExist(entity) and #(pcoords-entityCoords) < 3.5 then
        startAnim()
        exports['mythic_notify']:SendAlert('success', 'Isınıyorsun')
        local count = 30
        while count > 0 do
            Citizen.Wait(1000)
            count = count - 1
            if #(GetEntityCoords(ped)-GetEntityCoords(entity)) < 5.5 then
                
                if GetEntityHealth(ped) < 200 then
                    SetEntityHealth(ped, GetEntityHealth(ped) + 2) 
                else
                    exports['mythic_notify']:SendAlert('success', 'Yeterince Isındın.')
                    break
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Ateşten uzaklaştın!')
                break
            end
        end
        ClearPedTasks(ped)
    else
        exports['mythic_notify']:SendAlert('error', 'Etrafta kamp ateşi yok!')
    end
end)

function startAnim()
    Citizen.CreateThread(function()
        RequestAnimDict("bs_2a_mcs_10-6")
        while not HasAnimDictLoaded("bs_2a_mcs_10-6") do
            Citizen.Wait(0)
        end
      TaskPlayAnim(GetPlayerPed(-1), "bs_2a_mcs_10-6", "hc_hacker_dual-6" ,8.0, -8.0, -1, 50, 0, false, false, false)
    
    
    end)
end

--BU SCRİPT BayMike TARAFINDAN KODLANMIŞTIR  --
