package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Pufferfish extends Enemy{
		private var bulletTimer:Number=0;
		private var xPosition:Number = 0;
		private var yPosition:Number = -1;
		private var rageDistance:Number=350;//distance at which puffer fish is triggered to fire
		private var rageDelay:Number = 10;
		
		private var degrees:Number = 0;
		private var factor:Number = 20;
		private var pointToMoveTo:Point = new Point;
		private var xSpeedDegrade:Number=1;//slowly reduce speed of travel
		private var ySpeedDegrade:Number=1;
		public var newPoint:Point = new Point(500,500);//create new point for squid to track
		
		private var xSpeed:Number=3;//speed on x
		private var ySpeed:Number=3;//speed on y
		private var xSpeedOld:Number=xSpeed;//speed on x
		private var ySpeedOld:Number=ySpeed;//speed on y
		public function Pufferfish(xLoc:Number,yLoc:Number) {
			setHealth(3000);
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("pufferfish");
			gotoAndStop("pufferfish");
			this.x = xLoc;
			this.y = yLoc;
			//this.addEventListener(Event.ENTER_FRAME, updatePuffer);
			//moveSpeedX = 0;
			//moveSpeedY = 2;
		}
		
		public function clearUpdatePuffer(){
			//this.removeEventListener(Event.ENTER_FRAME, updatePuffer);
		}
		
		public function updateEnemy(){
			
			if(getHealth() <= 0){
				
			}
			//move the puffer
			//this.y += moveSpeedY /2;
			//this.x += moveSpeedX /2;
			moveToPoint();
			bulletTimer++;
			this.rotation += 1;
			//fire if other enemies are in range
			for(var i:int=0; i < Globals.enemies.length; i++){
				if(this != Globals.enemies[i] && distance(this,Globals.enemies[i]) > rageDistance){
					if(this.scaleX >=1.5){
						this.scaleX -= .5;
						this.scaleY -= .5;
					}
					if(this.scaleX < 1){
						this.scaleX = 1;
					}
				}
				
				else if(this != Globals.enemies[i] && distance(this,Globals.enemies[i]) < rageDistance){
					//trace("the puffer is within range of another enemy");
					if(this.scaleX <=5){
						this.scaleX += .25;
						this.scaleY += .25;
					}
					if(bulletTimer >= rageDelay){
						//fire bullets here
						
						var thePoint:Point = new Point;
						
						thePoint.x = this.x;
						thePoint.y = this.y;
						//give bullet its location, vector, and type, and speed, (does type contain speed?)
						var shot1X = (MathUtils.degreesToSlope(degrees + 150).x * (factor + 50));//+90 is down
						var shot1Y = (MathUtils.degreesToSlope(degrees + 150).y * (factor + 50));
						var shot2X = (MathUtils.degreesToSlope(degrees + 180).x * (factor + 50));//+180 is left
						var shot2Y = (MathUtils.degreesToSlope(degrees + 180).y * (factor + 50));
						var shot3X = (MathUtils.degreesToSlope(degrees - 150).x * (factor + 50));//-90 is top
						var shot3Y = (MathUtils.degreesToSlope(degrees - 150).y * (factor + 50));
						
						var shot4X = (MathUtils.degreesToSlope(degrees + 30).x * (factor + 50));//0 is right
						var shot4Y = (MathUtils.degreesToSlope(degrees + 30).y * (factor + 50));
						var shot5X = (MathUtils.degreesToSlope(degrees + 0).x * (factor + 50));
						var shot5Y = (MathUtils.degreesToSlope(degrees + 0).y * (factor + 50));
						var shot6X = (MathUtils.degreesToSlope(degrees  -30).x * (factor + 50));
						var shot6Y = (MathUtils.degreesToSlope(degrees - 30).y * (factor + 50));
						
						//needs x,y,dx,dy
						Globals.gameDocClass.fireEnemyBullet(shot1X + thePoint.x, shot1Y + thePoint.y, shot1X/ 10, shot1Y/ 10, "pufferfish");
						Globals.gameDocClass.fireEnemyBullet(shot2X + thePoint.x, shot2Y + thePoint.y, shot2X/ 10, shot2Y/ 10, "pufferfish");
						Globals.gameDocClass.fireEnemyBullet(shot3X + thePoint.x, shot3Y + thePoint.y, shot3X/ 10, shot3Y/ 10, "pufferfish");
						Globals.gameDocClass.fireEnemyBullet(shot4X + thePoint.x, shot4Y + thePoint.y, shot4X/ 10, shot4Y/ 10, "pufferfish");
						Globals.gameDocClass.fireEnemyBullet(shot5X + thePoint.x, shot5Y + thePoint.y, shot5X/ 10, shot5Y/ 10, "pufferfish");
						Globals.gameDocClass.fireEnemyBullet(shot6X + thePoint.x, shot6Y + thePoint.y, shot6X/ 10, shot6Y/ 10, "pufferfish");
						//trace("degrees: " + degrees);
						//trace("degrees from points: " + MathUtils.getAngle(new Point(thePoint.x, thePoint.y), new Point(shot1.x,shot1.y)));
						
						/*if(degrees + 10 > 360) { degrees = (degrees+10)-360; } 
						else {degrees = degrees + 10;}*/
						degrees = this.rotation;
						bulletTimer = 0;
					}
				}else{//if not inside teh rage distance
					
				}
					
			}
			for(var j:int=0; j < Globals.totems.length; j++){
				/*
				*is colliding with a totem
				*/
				if(this.hitTestObject(Globals.totems[j])){
					//damage totem here
					
					//damage this puffer here
				}
			}
		}
				private function recalculateMovement():void{//reset speed, point, degrade, etc
			xSpeed = xSpeedOld;//reset initial speeds
			ySpeed = ySpeedOld;
			
			newPoint.x = this.x + (Math.random()* 1000) - 500;
			newPoint.y = this.y + (Math.random()* 600) - 300;
			if(newPoint.x < 50){
				//trace(" newPoint.x < 50");
				newPoint.x = (Globals.screenSizeX / 2) + (Math.random()* 600) - 300;
			}
			if(newPoint.x > Globals.screenSizeX){
				//trace(" newPoint.x < Globals.screenSizeX");
				newPoint.x = (Globals.screenSizeX / 2) + (Math.random()* 600) - 300;
			}
			if(newPoint.y < 50){
				//trace(" newPoint.y < 50");
				newPoint.y = (Globals.screenSizeY / 2) + (Math.random()* 600) - 300;
			}
			if(newPoint.y > Globals.screenSizeY){
				//trace(" newPoint.y < Globals.screenSizeY");
				newPoint.y = (Globals.screenSizeY / 2) + (Math.random()* 600) - 300;
			}
			
			
			xSpeedDegrade = .25;
			ySpeedDegrade = .25;
		}
		
		private function moveToPoint(){
			//trace("moveToPoint");
			
			this.x += Math.random()* 1 - .5;//random motion if desired
			this.y += Math.random()*1 - .5;
			this.x += xSpeedDegrade;//slow down speed after each speed change
			this.y += ySpeedDegrade;
			if(xSpeed >= 5.25){//set minimum speeds
				xSpeed-=.25;
			}
			if(ySpeed >= 5.25){
				ySpeed-=.25;
			}
			
			
			if(this.x < newPoint.x){//determine which direction to travel
				this.x += xSpeed;
			}
			if(this.x > newPoint.x){
				this.x -= xSpeed;
			}
			if(this.y > newPoint.y){
				this.y -= ySpeed;
			}
			if(this.y < newPoint.y){
				this.y += ySpeed;
			}
			
			xSpeedDegrade -=.25;//reduce speed
			ySpeedDegrade -=.25;
			if(xSpeedDegrade <=0){//set minimum speed degradation
				xSpeedDegrade = 0;
			}
			if(ySpeedDegrade <=0){
				ySpeedDegrade = 0;
			}
			
			//if we collided with the borders
			if(this.x <=50 || this.x > Globals.screenSizeX || this.y < 50 || this.y > Globals.screenSizeY){
				recalculateMovement();
			}
			
			
			//if we reached the point
			if(Math.abs(this.x-newPoint.x) <=10 && Math.abs(this.y-newPoint.y) <=10){
				recalculateMovement();
			}
		}
	}
}
