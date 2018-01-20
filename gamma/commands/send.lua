local usecoins,gcoins,gsave,gadd,name,command = gcmd.patch(bagelBot.out)
if #command ~= 4 then
    tell(name,badsyntax)
elseif not gamma[command[3]] then
    tell(name,"&6Player is not in the database")
elseif not tonumber(command[4]) or math.floor(tonumber(command[4])) ~= tonumber(command[4]) then
    tell(name,"&6Invalid number amount")
elseif tonumber(command[4]) < 0 then
    tell(name,"&6Amount cannot be negative")
elseif tonumber(command[4]) > gamma[name] then
    tell(name,"&6Insufficient funds")
else
    gamma[name] = gamma[name] - tonumber(command[4])
    gamma[command[3]] = gamma[command[3]] + tonumber(command[4])
    tell(name,"&6"..command[4].."g sent to "..command[3])
    gsave()
end
