
args = { ... }

home = {x=-255,y=69,z=171}
loc = {x=-255,y=69,z=171}
dir = 0
homeDir = 0

headings = {
	"north",
	"east",
	"south",
	"west"
}

xDiff = { 0, 1, 0, -1 }
zDiff = { -1, 0, 1, 0 }

turtle_cmds =  { 
	base_tl = turtle.turnLeft,
	base_tr = turtle.turnRight,
	base_tf = turtle.forward,
	base_tb = turtle.back,
	base_tu = turtle.up,
	base_td = turtle.down
}

function printLocation()
	print("(x = " .. loc.x .. ", y = " .. loc.y .. ", z = " .. loc.z .. ")")
	print("Facing " .. headings[dir + 1])
end

function turnLeft()

	dir = (dir - 1) % 4;
	turtle_cmds.base_tl()
	
end

function turnRight()

	dir = (dir + 1) % 4;
	turtle_cmds.base_tr()
	
end

function up()
	
	while not turtle_cmds.base_tu() do 
		turtle.digUp()
	end
	loc.y = loc.y + 1
	return true

end

function down()
	
	while not turtle_cmds.base_td() do
		turtle.digDown()
	end
	loc.y = loc.y - 1
	return true

end

function forward()
	
	while not turtle_cmds.base_tf() do
		turtle.dig()
	end
	loc.x = loc.x + xDiff[dir+1]
	loc.z = loc.z + zDiff[dir+1]
	return true
	
end

function back()
	
	while not turtle_cmds.base_tb() do end
	loc.x = loc.x - xDiff[dir+1]
	loc.z = loc.z - zDiff[dir+1]
	return true
	
end

function face(target)
	while dir ~= target do
		turnLeft()
	end
end

function dig()
	turtle.dig()
	turtle.digDown()
	turtle.digUp()
end

function gotoY(y)
	
	if loc.y > y then
		while loc.y > y do
			if not down() then
				return false
			end
		end
	elseif loc.y < y then
		while loc.y < y do
			if not up() then
				return false
			end
		end
	end
	
	return true
	
end

function gotoZ(z)
	
	if loc.z > z then
		face(0)
		while loc.z > z do
			if not forward() then
				return false
			end
		end
	elseif loc.z < z then
		face(2)
		while loc.z < z do
			if not forward() then
				return false
			end
		end
	end
	
	return true
	
end

function gotoX(x)
	
	if loc.x < x then
		face(1)
		while loc.x < x do
			if not forward() then
				return false
			end
		end
	elseif loc.x > x then
		face(3)
		while loc.x > x do
			if not forward() then
				return false
			end
		end
	end
	
	return true
	
end

function gotoXZ(x,z)
	
	return gotoX(x) and gotoZ(z)
	
end

function gotoZX(x,z)
	
	return gotoZ(z) and gotoX(x)
	
end

function main(args)
	
	while true do
	
		for i = 1,8 do
			
			for j = 1,16 do
				dig()
				forward()
			end
			
			turnRight()
			forward()
			turnRight()
			
			for j = 1,16 do
				dig()
				forward()
			end
			
			turnLeft()
			forward()
			turnLeft()
			
		end
		
		turnLeft()
		for i = 1,16 do
			forward()
		end
		turnRight()
		
		gotoY(loc.y - 3)
		
	end
	
end

main(args)