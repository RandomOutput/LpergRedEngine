package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import plemmonsutils.MathUtils;
	
	public class utilsTest extends MovieClip {
		private var degrees:Number = 0;
		private var factor:Number = 20;
		
		public function utilsTest() {
			this.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function tick(e:Event) {
			Point2.x = (MathUtils.degreesToSlope(degrees).x * factor) + thePoint.x;
			Point2.y = (MathUtils.degreesToSlope(degrees).y * factor) + thePoint.y;
			
			Point3.x = (MathUtils.degreesToSlope(degrees + 90).x * factor) + thePoint.x;
			Point3.y = (MathUtils.degreesToSlope(degrees + 90).y * factor) + thePoint.y;
			
			Point4.x = (MathUtils.degreesToSlope(degrees + 180).x * factor) + thePoint.x;
			Point4.y = (MathUtils.degreesToSlope(degrees + 180).y * factor) + thePoint.y;
			
			Point5.x = (MathUtils.degreesToSlope(degrees - 90).x * factor) + thePoint.x;
			Point5.y = (MathUtils.degreesToSlope(degrees - 90).y * factor) + thePoint.y;
			
			trace("degrees: " + degrees);
			trace("degrees from points: " + MathUtils.getAngle(new Point(thePoint.x, thePoint.y), new Point(Point2.x,Point2.y)));
			
			if(degrees + 10 > 360) { degrees = (degrees+10)-360; } 
			else {degrees = degrees + 10;}
			
		}

	}
	
}
