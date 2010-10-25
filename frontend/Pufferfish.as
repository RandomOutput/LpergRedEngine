package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Pufferfish extends Enemy{
		private var bulletTimer:Number=0;
		private var rageDistance:Number=350;//distance at which puffer fish is triggered to fire
		private var rageDelay:Number = 10;
		
		private var degrees:Number = 0;
		private var factor:Number = 20;
		private var isRageEnabled:Boolean=false;
		public function Pufferfish() {
			setHealth(3000);
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("pufferfish");
			gotoAndStop("pufferfish");
			
		}
		
		public function updateEnemy(){
			
			if(getHealth() <= 0){
				
			}
			bulletTimer++;
			this.rotation += 1;
			//fire if other enemies are in range
			isRageEnabled = false;
			for(var i:int=0; i < Globals.enemies.length; i++){
				
				if(this != Globals.enemies[i] && distance(this,Globals.enemies[i]) < rageDistance){
					isRageEnabled = true;
				}
				if(isRageEnabled){
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
				}
				else if(isRageEnabled == false){
					if(this.scaleX >=1.5){
						this.scaleX -= .5;
						this.scaleY -= .5;
					}
					if(this.scaleX < 1){
						this.scaleX = 1;
					}
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
	}
}
