if command[2] == "create" then
  if #command ~= 6 and #command ~= 7 then
    tell(name,badsyntax)
  elseif #command[3] > 16 then
    tell(name,"&6Max name length is 16")
  elseif (not tonumber(command[4])) or (not tonumber(command[5])) or (not tonumber(command[6])) or math.floor(tonumber(command[4])) ~= tonumber(command[4]) or math.floor(tonumber(command[5])) ~= tonumber(command[5])or math.floor(tonumber(command[6])) ~= tonumber(command[6]) then
    tell(name,"&6Invalid number coordinates")
  elseif command[7] and ((not tonumber(command[7])) or math.floor(tonumber(command[7])) ~= tonumber(command[7]) or tonumber(command[7]) < 0) then
    tell(name,"&6Invalid number price")
  elseif gamma.shops[command[3]] then
    tell(name,"&6"..command[3].." already exists")
  elseif commands.getBlockInfo(tonumber(command[4]),tonumber(command[5]),tonumber(command[6])).name ~= "computercraft:peripheral" or commands.getBlockInfo(tonumber(command[4]),tonumber(command[5]),tonumber(command[6])).metadata < 2 or commands.getBlockInfo(tonumber(command[4]),tonumber(command[5]),tonumber(command[6])).metadata > 5 then
    tell(name,"&6No disk drive at location")
  else
    gamma.shops[command[3]] = {}
    gamma.shops[command[3]].x = tonumber(command[4])
    gamma.shops[command[3]].y = tonumber(command[5])
    gamma.shops[command[3]].z = tonumber(command[6])
    gamma.shops[command[3]].price = tonumber(command[7])
    gamma.shops[command[3]].user = name
    tell(name,"&6Shop succesfully created")
    gsave()
  end
elseif command[2] == "list" then
  if #command ~= 2 and #command ~= 3 then
    tell(name,badsyntax)
  elseif command[3] and (not gamma[command[3]]) then
    tell(name,"&6Player is not in database")
  else
    local out = {}
    for k,v in pairs(gamma.shops) do
      if (not command[3]) or command[3] == v.user then
        out[#out+1] = "&5"..k.."&6 - owned by &5"..v.user
        if v.price then
          out[#out] = out[#out].."&6 for &5"..v.price.."g"
        end
      end
    end
    if #out == 0 then
      out = "&6No shops found"
    end
    tell(name,out)
  end
elseif command[2] == "remove" then
  if #command ~= 3 then
    tell(name,badsyntax)
  elseif not gamma.shops[command[3]] then
    tell(name,"&6Shop does not exist")
  elseif gamma.shops[command[3]].user ~= name then
    tell(name,"&6You are not the owner of this shop")
  else
    gamma.shops[command[3]] = nil
    tell(name,"&5"..command[3].."&6 shop removed")
    gsave()
  end
elseif command[2] == "pay" then
  local rx,ry,yz = commands.getBlockPosition()
  if #command ~= 4 and #command ~= 3 then
    tell(name,badsyntax)
  elseif not gamma.shops[command[3]] then
    tell(name,"&6Shop does not exist")
  elseif command[4] and ((not tonumber(command[4])) or tonumber(command[4]) < 0 or math.floor(tonumber(command[4])) ~= math.floor(tonumber(command[4]))) then
    tell(name,"&6Invalid number price")
  elseif gamma.shops[command[3]].price and command[4] and tonumber(command[4]) ~= gamma.shops[command[3]].price then
    tell(name,"&6Price does not match shop's required price")
  elseif (not command[4]) and (not gamma.shops[command[3]].price) then
    tell(name,"&6Price must be specified for this shop")
  elseif not commands.clone(gamma.shops[command[3]].x,gamma.shops[command[3]].y,gamma.shops[command[3]].z,gamma.shops[command[3]].x,gamma.shops[command[3]].y,gamma.shops[command[3]].z,"~","~1","~") then
    tell(name,"&6Drive could not be accessed")
  elseif not fs.exists("disk") then
    tell(name,"&6Block does not contain a disk")
  elseif (command[4] and tonumber(command[4]) > gamma[name]) or (gamma.shops[command[3]].price and gamma.shops[command[3]].price > gamma[name]) then
    tell(name,"&6Insufficient funds")
  else
    local data
    if fs.exists("disk/gshop") then
      local f = fs.open("disk/gshop","r")
      data = textutils.unserialize(f.readAll())
      f.close()
    else
      data = {}
    end
    local info = {}
    info.user = name
    if command[4] then
      info.amount = tonumber(command[4])
    end
    info.shop = command[3]
    data[#data+1] = info
    local f = fs.open("disk/gshop","w")
    f.write(textutils.serialize(data))
    f.close()
    commands.setblock("~","~1","~","air")
    if command[4] then
      gamma[name] = gamma[name] - tonumber(command[4])
      gamma[gamma.shops[command[3]].user] = gamma[gamma.shops[command[3]].user] + tonumber(command[4])
    else
      gamma[name] = gamma[name] - gamma.shops[command[3]].price
      gamma[gamma.shops[command[3]].user] = gamma[gamma.shops[command[3]].user] + gamma.shops[command[3]].price
    end
    tell(name,"&6Purchase successful")
  end
else
  tell(name,"&6Invalid command")
end
