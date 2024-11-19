RegisterNetEvent("sb_laundering:server:launderMoney", function(moneyAmount, launderPercent, key)
    local src = source
    if launderPercent > Config.locations[key].maxPercent then return end
    if not key then return end
    if not moneyAmount then return end
    local success, response  = exports.ox_inventory:RemoveItem(src, Config.blackMoneyItem, moneyAmount)
    if success then
        print(math.floor(moneyAmount * launderPercent / 100))
        local success, response = exports.ox_inventory:AddItem(src, Config.moneyItem, moneyAmount - math.floor(moneyAmount * launderPercent / 100))
        if success then
            TriggerClientEvent('ox_lib:notify', src, {
                title = "You have laundered ".. moneyAmount .. " at " .. launderPercent .. "wich is equel to " .. moneyAmount * launderPercent / 100
            })
        end
    end
end)