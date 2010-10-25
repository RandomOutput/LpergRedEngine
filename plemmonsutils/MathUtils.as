package  plemmonsutils{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	
	public class MathUtils{
		
		public function MathUtils() {
			trace("plemmonsutils.Mathutils is static, no need to use constructor");
		}
		
		//send it degrees, it will give you a vector as an x,y point
		public static function degreesToSlope(deg:Number):Point {
			var rad = deg * Math.PI / 180			
			return new Point(Math.cos(rad), Math.sin(rad));
		}
		
		//send it two points and it will give you the angle in degrees
		public static function getAngle(pt1:Point, pt2:Point):Number {
			var rad = Math.atan2((pt2.y-pt1.y) * -1, pt2.x-pt1.x);
			var deg = rad * 180 / Math.PI;
			if ((pt2.x-pt1.x)<0) {
				deg += 180;
			}
			if ((pt2.x-pt1.x)>=0 && ((pt2.y-pt1.y) * -1)<0) {
				deg += 360;
			}
			return deg;
		}
		//send it two points and it will give you the angle in degrees correctly
		public static function getAngle2(pt1:Point, pt2:Point):Number {
			var theX:int = pt1.x - pt2.x;
			var theY:int = (pt1.y - pt2.y) * -1;
			var angle = Math.atan(theY/theX)/(Math.PI/180);
			if (theX<0) {
				angle += 180;
			}
			if (theX>=0 && theY<0) {
				angle += 360;
			}
			//trace("angle "  + angle);;
			return(angle*-1) + 90;
			
		}
										 
		
		
		//send it two sprites and it will tell if they collide
		public static function doCollide(obj1:Sprite, obj2:Sprite) {
			if(obj1.hitTestObject(obj2)) {
				return true;
			}else {
				return false;
			}
		}
		//send two objects, returns the distance between them
		public static function getDistance(obj1, obj2){
			var dist,xDist,yDist:Number;
			xDist = obj1.x-obj2.x;
			yDist = obj1.y-obj2.y;
			dist = Math.sqrt(xDist*xDist + yDist*yDist);
			//trace(dist);
			return dist;
		}

	}
	
}
