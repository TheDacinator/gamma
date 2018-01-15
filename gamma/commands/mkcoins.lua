local usecoins,gcoins,gsave,gadd,name,command = gcmd.patch(bagelBot.out())
if not usecoins then
    tell(name,"&6Coin commands are disabled")
elseif #command ~= 3 then
    tell(name,badsyntax)
elseif (not tonumber(command[3])) or tonumber(command[3]) < 0 then
    tell(name,"&6Invalid number amount")
elseif tonumber(command[3]) > gamma[name] then
    tell(name,"&6Insufficient funds")
else
    local left = tonumber(command[3])
    while left >= 30 do
        local biggest
        for k,v in pairs(gcoins) do
            if v <= left and ((not gcoins[biggest]) or v > gcoins[biggest]) then
                biggest = k
            end
        end
        if biggest then
            commands.give(name,"thermalfoundation:coin",1,biggest)
            left = left - gcoins[biggest]
            gamma[name] = gamma[name] - gcoins[biggest]
        else
            break
        end
    end
    tell(name,"&6"..tostring(command[3] - left).."g transferred")
    gsave()
end
