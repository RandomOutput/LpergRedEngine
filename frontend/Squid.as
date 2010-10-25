package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Squid extends Enemy{
		private var pointToMoveTo:Point = new Point;
		private var xSpeedDegrade:Number=1;//slowly reduce speed of travel
		private var ySpeedDegrade:Number=1;
		public var newPoint:Point = new Point(500,500);//create new point for squid to track
		
		private var xSpeed:Number=15;//speed on x
		private var ySpeed:Number=15;//speed on y
		private var xSpeedOld:Number=xSpeed;//speed on x
		private var ySpeedOld:Number=ySpeed;//speed on y
		
		//public var this.x:Number= (Math.random()* 600) - 100;
		//public var this.y:Number= (Math.random()* 400) - 100
		
		//vars for rotation
				
		//public var speed = 10 + ( (Math.random() * 1) / 2 );
		public var speed = 15;
		public var rotationSpeed = 20 - Math.random() * 10;
		
		
		
		
		
		
		
		private var bulletTimer:Number=0;
		private var xPosition:Number = 0;
		private var yPosition:Number = -1;
		private var bulletDelay:Number = 45;
		
		private var degrees:Number = 0;
		private var factor:Number = 20;
		
		public function Squid(xLoc:Number,yLoc:Number) {
			setHealth(3000);
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("squid");
			gotoAndStop("squid");
			this.x = xLoc;
			this.y = yLoc;
			//this.addEventListener(Event.ENTER_FRAME, updateSquid);
			pointToMoveTo.x = Math.random()* Globals.screenSizeX;
			pointToMoveTo.y = Math.random()* Globals.screenSizeY;
			//trace("pointToMoveTo " + pointToMoveTo);
			//moveSpeedX = 0;
			//moveSpeedY = 2;
		}
		
		public function clearUpdateSquid(){
			//trace("clear updateSquid");
			//this.removeEventListener(Event.ENTER_FRAME, updateSquid);
		}
		
		public function updateEnemy(){
			moveToPoint();
			if(getHealth() <= 0){
				clearUpdateSquid();
			}
			//move the puffer
			//moveSpeedX = 0;
			//moveSpeedY = 0;
			
			
			//this.y += moveSpeedY ;
			//this.x += moveSpeedX ;
			bulletTimer++;
			//3 second delay
			if(bulletTimer >= bulletDelay){
				//fire bullets here
				var thePoint:Point = new Point;
				
				thePoint.x = this.x;
				thePoint.y = this.y;
				
				
				/* give bullet its location, vector, and type, and speed, (does type contain speed?)
				*  shoot at nearest totem
				*/
				var highestDistance:Number=0;
				var currentDistance:Number=0;
				var totemToFireAt:Number=0;
				/*
				*  find the nearest totem
				*/
				for(var i:int=0; i < Globals.totems.length; i++){
					currentDistance = MathUtils.getDistance(Globals.totems[i], this);
					if(currentDistance > highestDistance){
						totemToFireAt = i;
						highestDistance = currentDistance;
						//trace(totemToFireAt);
					}
				}
				var totemPoint:Point = new Point();
				totemPoint.x = Globals.totems[totemToFireAt].x;
				totemPoint.y = Globals.totems[totemToFireAt].y;
				var shotAngle = MathUtils.getAngle2(totemPoint, thePoint);
				
				var shot1X = (MathUtils.degreesToSlope(shotAngle - 120).x * (factor + 50));//+90 is down
				var shot1Y = (MathUtils.degreesToSlope(shotAngle - 120).y * (factor + 50));
				var shot2X = (MathUtils.degreesToSlope(shotAngle - 90).x * (factor + 50));//+180 is left
				var shot2Y = (MathUtils.degreesToSlope(shotAngle - 90).y * (factor + 50));
				var shot3X = (MathUtils.degreesToSlope(shotAngle - 60).x * (factor + 50));//-90 is top
				var shot3Y = (MathUtils.degreesToSlope(shotAngle - 60).y * (factor + 50));
				
				//needs x,y,dx,dy
				Globals.gameDocClass.fireEnemyBullet(shot1X + thePoint.x, shot1Y + thePoint.y, shot1X/ 10, shot1Y /10, "squid");
				Globals.gameDocClass.fireEnemyBullet(shot2X + thePoint.x, shot2Y + thePoint.y, shot2X/ 10, shot2Y/ 10, "squid");
				Globals.gameDocClass.fireEnemyBullet(shot3X + thePoint.x, shot3Y + thePoint.y, shot3X/ 10, shot3Y/ 10, "squid");
				degrees = this.rotation;
				bulletTimer = 0;
			}
			
	
			
			
			
			for(var j:int=0; j < Globals.totems.length; j++){
				/*
				*is colliding with a totem
				*/
				if(this.hitTestObject(Globals.totems[j])){
					//damage totem here
					
					//damage this Squid here
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
