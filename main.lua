
function love.load()
	love.graphics.newFont( 62 )
	love.window.setTitle("A Coinye Quest")
	love.window.setMode(800,500)
	backg = love.graphics.newImage("bg1.png")
	leftscore = love.graphics.newImage("bg2.png")
	rightscore = love.graphics.newImage("bg3.png")
	coinye = love.graphics.newImage("coinye.png")
	imgx = 400
	imgy = 400
	width = coinye:getWidth()
	height = coinye:getHeight()
	rotation = 0.1
	love.graphics.setNewFont(12)
	love.keyboard.setKeyRepeat( true )
	xv = 5
	yv = 3
	poney = 250
	bg = backg
	gtime = love.timer.getTime()
	ptime = gtime
	scoreone = 0
	scoretwo = 0
end

function love.update(dt)
	move()
	if (ptime - gtime) > 1 then
		bg = backg
	end
	imgx = imgx + xv
	imgy = imgy + yv
	bounce()
	ptime = love.timer.getTime()
end

function love.draw()
	love.graphics.draw(bg)
	playerOne();
	love.graphics.setColor(250,250,250)
	love.graphics.draw(coinye,imgx,imgy,rotation,0.1,0.1,width/2,height/2)
	rotation = rotation + .01
	love.graphics.print(scoreone, 200, 40)
	love.graphics.print(scoretwo, 600,40)
end

function bounce()
	bouncex = love.window.getWidth()-20
	bouncey = love.window.getHeight()-45

	if (imgx  > bouncex) then
		xv = -1*xv
		gtime = love.timer.getTime()
		bg = rightscore
		scoretwo = scoretwo + 1
	end
	if (imgx < 70) and ((poney + 50) >= imgy) and (poney <= imgy) then
		if(imgy <= poney +50) and (imgy >poney+35) then
			if yv < 0 then
				yv = -8
			else 
				yv = 8
			end
		elseif(imgy >= poney) and (imgy <poney+15) then
			if yv < 0 then
				yv = -8
			else 
				yv = 8
			end
		elseif (imgy >= poney + 15) and (imgy <=poney+35)then
			if yv < 0 then
				yv = -3
			else 
				yv = 3
			end
		end
		xv = -1 * xv
	end

	if (imgx < 20) then
		xv = -1*xv
		gtime = love.timer.getTime()
		bg = leftscore
		scoreone = scoreone + 1
	end

	if (imgy > bouncey) or (imgy < 45) then
		yv = -1*yv
	end
end


function playerOne()
	love.graphics.setColor(200,200,200)
	pone = love.graphics.rectangle("fill",25,poney,20,50)

end

function move()
	if love.keyboard.isDown("up") and poney > 30 then
		poney = poney - 8
	end
	if love.keyboard.isDown("down") and poney < 426 then
		poney = poney + 8
	end
end

--function score()

