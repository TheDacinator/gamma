local name,command = bagelBot.out()
if #command ~= 3 then
    bagelBot.tell(name,"&6Invalid syntax")
elseif not gamma[command[2]] then
    bagelBot.tell(name,"&6Player is not in the database")
elseif not tonumber(command[3]) or math.floor(tonumber(command[3])) ~= tonumber(command[3]) then
    bagelBot.tell(name,"&6Invalid number amount")
elseif tonumber(command[3]) < 0 then
    bagelBot.tell(name,"&6Amount cannot be negative")
elseif tonumber(command[3]) > gamma[name] then
    bagelBot.tell(name,"&6Insufficient funds")
else
    gamma[name] = gamma[name] - tonumber(command[3])
    gamma[command[2]] = gamma[command[2]] + tonumber(command[3])
    bagelBot.tell(name,"&6"..command[3].."g sent to "..command[2])
    gsave()
end
