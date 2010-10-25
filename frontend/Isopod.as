package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Isopod extends Enemy{
		
		private var bulletTimer:Number=0;
		private var xPosition:Number = 0;
		private var yPosition:Number = -1;
		private var bulletDelay:Number = 8;
		
		private var degrees:Number = 0;
		private var factor:Number = 20;
		
		public function Isopod() {
			setHealth(3000);
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("isopod");
			gotoAndStop("isopod");
		}
		
		public function updateEnemy(){
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
				
				var shot1X = (MathUtils.degreesToSlope(shotAngle - 120).x * (factor + 5));//+90 is down
				var shot1Y = (MathUtils.degreesToSlope(shotAngle - 120).y * (factor + 5));
				
				
				//needs x,y,dx,dy
				Globals.gameDocClass.fireEnemyBullet(shot1X + thePoint.x, shot1Y + thePoint.y, shot1X/ 20, shot1Y /20, "isopod");
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
	}
}
