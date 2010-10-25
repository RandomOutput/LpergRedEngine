package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Angler extends Enemy{
		private var bulletTimer:Number=0;
		private var prismTimer:Number=0;
		private var degrees:Number=0;
		private var factor:Number=20;
		
		
		public function Angler(xLoc:Number,yLoc:Number) {
			setHealth(3000);
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("angler");
			gotoAndStop("angler");
			this.x = xLoc;
			this.y = yLoc;
			this.addEventListener(Event.ENTER_FRAME, updateAngler);
			moveSpeedX = 2;
			moveSpeedY = 2;
		}
		
		public function clearUpdateAngler(){
			this.removeEventListener(Event.ENTER_FRAME, updateAngler);
		}
		
		
		/*
		* create 5 more bullets
		* on the angler
		* make sure they are far enough away
		* so it doesnt prism out of control
		*/
		
		public function prismBullets(){
			if(prismTimer >=30){
				//fire bullets here
				var thePoint:Point = new Point;
				//give bullet its location, vector, and type, and speed, (does type contain speed?)
				thePoint.x = this.x;
				thePoint.y = this.y;
				//give bullet its location, vector, and type, and speed, (does type contain speed?)
				var shot1X = (MathUtils.degreesToSlope(degrees + 90).x * (factor +50));//+90 is down
				var shot1Y = (MathUtils.degreesToSlope(degrees + 90).y * (factor +50));
				var shot2X = (MathUtils.degreesToSlope(degrees + 18).x * (factor +50));//+180 is left
				var shot2Y = (MathUtils.degreesToSlope(degrees + 18).y * (factor +50));
				var shot3X = (MathUtils.degreesToSlope(degrees + 162).x * (factor +50));//-90 is top
				var shot3Y = (MathUtils.degreesToSlope(degrees + 162).y * (factor +50));
				
				var shot4X = (MathUtils.degreesToSlope(degrees - 54).x * (factor +50));//0 is right
				var shot4Y = (MathUtils.degreesToSlope(degrees - 54).y * (factor +50));
				var shot5X = (MathUtils.degreesToSlope(degrees + -126).x * (factor +50));
				var shot5Y = (MathUtils.degreesToSlope(degrees + -126).y * (factor +50));
				
				//needs x,y,dx,dy
				Globals.gameDocClass.fireEnemyBullet(shot1X + thePoint.x, shot1Y + thePoint.y, shot1X /10, shot1Y /10, "angler");
				Globals.gameDocClass.fireEnemyBullet(shot2X + thePoint.x, shot2Y + thePoint.y, shot2X /10, shot2Y /10, "angler");
				Globals.gameDocClass.fireEnemyBullet(shot3X + thePoint.x, shot3Y + thePoint.y, shot3X /10, shot3Y /10, "angler");
				Globals.gameDocClass.fireEnemyBullet(shot4X + thePoint.x, shot4Y + thePoint.y, shot4X /10, shot4Y /10, "angler");
				Globals.gameDocClass.fireEnemyBullet(shot5X + thePoint.x, shot5Y + thePoint.y, shot5X /10, shot5Y /10, "angler");
				prismTimer=0;
			}
		}
		
		private function updateAngler(event:Event){
			prismTimer++;
			if(this.getHealth() <= 0){
				clearUpdateAngler();
			}
			//move the angler
			this.y += moveSpeedY;
			this.x += moveSpeedX;
			bulletTimer++;
			//fire on a timer
			if(bulletTimer >=90){
				//fire shot here
				var thePoint:Point = new Point;
				thePoint.x = this.x;
				thePoint.y = this.y;
				//fires one large beam straight ahead based on its motion
				var shot1X = (MathUtils.degreesToSlope(degrees + 90).x * (factor +50));//+90 is down
				var shot1Y = (MathUtils.degreesToSlope(degrees + 90).y * (factor +50));
				Globals.gameDocClass.fireEnemyBullet(shot1X + thePoint.x, shot1Y + thePoint.y, shot1X /10 , shot1Y /10, "angler");
				
				
				//trace("degrees: " + degrees);
				//trace("degrees from points: " + MathUtils.getAngle(new Point(thePoint.x, thePoint.y), new Point(shot1.x,shot1.y)));
				bulletTimer = 0;
				degrees = this.rotation;
			}
		}
	}
}
