local usecoins,gcoins,gsave,gadd,name,command = gcmd.patch(bagelBot.out())
if not (#command == 2 or #command == 3) then
    tell(name,badsyntax)
elseif #command == 3 and (not gamma[command[3]]) then
    tell(name,"&6Player is not in the database")
else
    local p
    if command[3] then
        p = command[3]
    else
        p = name
    end
    tell(name,"Balance: "..gamma[p])
end
