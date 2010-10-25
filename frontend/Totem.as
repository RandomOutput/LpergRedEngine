/*
*This may contain feedback or it may contain nothing
*
*/
package  frontend {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import frontend.*;
	import flash.geom.Point;
	import plemmonsutils.MathUtils;
	
	public class Totem extends MovieClip{
		
		
		//private var health:Number=100;
		public static var playerHealth:Number=100;
		public static var playerEnergy:Number=100;
		
	
		public function Totem(xLoc:Number, yLoc:Number) {
			this.x = xLoc;
			this.y = yLoc;
			this.addEventListener(Event.ENTER_FRAME, totemAngle);
		}
		
		private function totemAngle(event:Event){
			//trace(this.x);
			var totemLocation:Point = new Point(this.x,this.y);
			var worldCenter:Point = new Point(640, 400);
			this.rotation = MathUtils.getAngle2(worldCenter, totemLocation);
			updateTotemHealthCircle();
			
		}
		private function updateTotemHealthCircle(){
			playerHealth+=.025;
			
			this.healthCircle.alpha = .6;
			this.healthCircle.scaleX = playerHealth / 100;
			this.healthCircle.scaleY = playerHealth / 100;
		}
		/*
		* applies damage from enemy bullet or collision
		*checks to see if the player is killed
		*
		*TO DO:
		* apply modifiers to damage based on bullet type
		* apply modifiers to damage based on enemy type
		* needs to pass to Daniel health, how much health taken, by what kind of fire
		*
		*/
		private function addDebris(){
			Globals.totemDebris.push(new Debris(this.x, this.y));
			Globals.theStage.addChild(Globals.totemDebris[Globals.totemDebris.length-1]);
			/*
			var newDebris = new Debris(this.x, this.y);
			Globals.totemDebris.push(newDebris);
			Globals.theStage.addChild(newDebris);*/
		}
		
		public function hitByEnemy(damageTaken:Number){
			playerHealth -= damageTaken;
			//space for defensive and offensive modifiers
			//was hit by bullet
			
			if(playerHealth >= 90){
				addDebris();
			}
			if(playerHealth >= 75 && playerHealth <=89){
				addDebris();
				addDebris();
			}
			if(playerHealth >= 50 && playerHealth <=74){
				addDebris();
				addDebris();
				addDebris();
			}
			if(playerHealth >= 25 && playerHealth <=49){
				addDebris();
				addDebris();
				addDebris();
				addDebris();
			}
			if(playerHealth >= 0 && playerHealth <=24){
				addDebris();
				addDebris();
				addDebris();
				addDebris();
				addDebris();
			}
			//trace("new debris added");
			//trace(Globals.totemDebris[Globals.totemDebris.length-1].x);
			//collided with enemy 
			killedByEnemies();
		}
		
		private function killedByEnemies(){
			if(playerHealth >= 100){
				playerHealth = 100;
			}
			if(playerHealth <= 0){
				playerHealth = 0;
				//trace("this is the point at which you would have lost");
			}
		}
		
		//get the health of the totem
		public function getHealth(){
			return playerHealth;
		}
		
		//get the health of the totem
		public function setHealth(newHealth:Number){
			playerHealth = newHealth;
		}
	}
}
