package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Starfish extends Enemy{
		private var bulletTimer:Number=0;
		private var xPosition:Number = 0;
		private var yPosition:Number = -1;
		private var degrees:Number = 0;
		private var factor:Number = 20;
		
		public function Starfish(xLoc:Number,yLoc:Number) {
			setHealth(200);
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("starfish");
			gotoAndStop("starfish");
			this.x = xLoc;
			this.y = yLoc;
			this.addEventListener(Event.ENTER_FRAME, updateStarfish);
			moveSpeedX = 2;
			moveSpeedY = 2;
		}
		
		public function clearUpdateStarfish(){
			this.removeEventListener(Event.ENTER_FRAME, updateStarfish);
		}
		
		private function updateStarfish(event:Event){
			//move the enemy
			this.y += moveSpeedY;
			this.x += moveSpeedX;
			bulletTimer++;
			if(bulletTimer>20){
				//fire bullets from all 4 points here
				//fire bullets here
						var shot1:TestObject = new TestObject();
						var shot2:TestObject = new TestObject();
						var shot3:TestObject = new TestObject();
						var shot4:TestObject = new TestObject();
						var thePoint:Point = new Point;
						
						thePoint.x = this.x;
						thePoint.y = this.y;
						//give bullet its location, vector, and type, and speed, (does type contain speed?)
						shot1.x = (MathUtils.degreesToSlope(degrees + 90).x * factor) + thePoint.x;//+90 is down
						shot1.y = (MathUtils.degreesToSlope(degrees + 90).y * factor) + thePoint.y;
						shot2.x = (MathUtils.degreesToSlope(degrees + 180).x * factor) + thePoint.x;//+180 is left
						shot2.y = (MathUtils.degreesToSlope(degrees + 180).y * factor) + thePoint.y;
						shot3.x = (MathUtils.degreesToSlope(degrees - 90).x * factor) + thePoint.x;//-90 is top
						shot3.y = (MathUtils.degreesToSlope(degrees - 90).y * factor) + thePoint.y;
						shot4.x = (MathUtils.degreesToSlope(degrees + 0).x * factor) + thePoint.x;//0 is right
						shot4.y = (MathUtils.degreesToSlope(degrees + 0).y * factor) + thePoint.y;
						//trace(Point2.x);
						//trace(Point2.y);
						Globals.theStage.addChild(shot1);
						Globals.theStage.addChild(shot2);
						Globals.theStage.addChild(shot3);
						Globals.theStage.addChild(shot4);
						//trace("degrees: " + degrees);
						//trace("degrees from points: " + MathUtils.getAngle(new Point(thePoint.x, thePoint.y), new Point(shot1.x,shot1.y)));
						/*if(degrees + 10 > 360) { degrees = (degrees+10)-360; } 
						else {degrees = degrees + 10;}*/
						bulletTimer = 0;
						degrees = this.rotation;
			}
		}
	}
}
