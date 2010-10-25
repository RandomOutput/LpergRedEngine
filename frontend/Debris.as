	package  frontend{
	import flash.events.Event;
	import frontend.Globals;
	import flash.display.MovieClip;
	
	public class Debris extends MovieClip{
		private var moveSpeedX:Number = Math.random()* 10 -5;
		private var moveSpeedY:Number = Math.random()* 10 -5;
		public function Debris(xLoc:Number,yLoc:Number) {
			// constructor code
			this.x = xLoc;
			this.y = yLoc;
			this.addEventListener(Event.ENTER_FRAME, moveDebris);
		}
		
		private function moveDebris(event:Event){
			this.x += moveSpeedX;
			this.y += moveSpeedY;
			this.scaleX -= .01;
			this.scaleY -= .01;
			this.alpha -=.01;
			//trace("this.x " + this.x);
			if(this.scaleX <= 0){
				var arayPosition = Globals.totemDebris.indexOf(this);
				this.removeEventListener(Event.ENTER_FRAME, moveDebris);
				Globals.totemDebris.splice(arayPosition,1);
				//trace("removing the object");
				this.parent.removeChild(this);
			}
		}
	}
}
