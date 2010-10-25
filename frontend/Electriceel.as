package  frontend{
	import flash.events.Event;
	import flash.display.*;
	import flash.geom.*;
	import frontend.Globals;
	
	public class Electriceel extends Enemy{
		private var bulletTimer:Number=0;
		//private var arcLightningLine:Shape = new Shape();
		

		public function Electriceel(xLoc:Number,yLoc:Number) {
			//Globals.arcLightningLine = new Shape();
			
			// constructor code
			//set the graphics of the enemy
			this.setEnemyType("electriceel");
			gotoAndStop("electriceel");
			this.x = xLoc;
			this.y = yLoc;
			this.addEventListener(Event.ENTER_FRAME, updateElectriceel);
		}
		
		public function clearUpdateElectriceel(){
			this.removeEventListener(Event.ENTER_FRAME, updateElectriceel);
		}
		
		private function updateElectriceel(event:Event){
			if(this.getHealth() <= 0){
				clearUpdateElectriceel();
			}
			//move the enemy
			Globals.arcLightningLine.graphics.clear();
			this.y += moveSpeedY;
			this.x += moveSpeedX;
			arcLightning();
			bulletTimer++;
			//get the health of the enemy to find out if i need to clear listeners and kill it
			
		}
		
		/*
		*check the distance between all other actors
		*make sure that the eel is not trying to arc against itself
		*draw a line between the two if they are close enough
		*/
		private function arcLightning(){
			Globals.arcLightningLine.graphics.clear();
			var arcDistance:Number = 450;//maximum distance between two enemies to start arcing
			
			for(var i:int = 0; i < Globals.enemies.length; i++){
				if(Globals.enemies[i] != this){
					if(distance(Globals.enemies[i], this) < arcDistance){
						//electricity should arc here
						Globals.arcLightningLine.graphics.lineStyle(10, 0xFFD700, 1, false, LineScaleMode.VERTICAL,
							CapsStyle.NONE, JointStyle.MITER, 10);
						Globals.arcLightningLine.graphics.moveTo(Globals.enemies[i].x, Globals.enemies[i].y);
						Globals.arcLightningLine.graphics.lineTo(this.x, this.y);
						Globals.theStage.addChild(Globals.arcLightningLine);
						//draw a line between the two enemies
						//trace("GameDocClass, arcLightning: enemy within arcDistance");
					}
				}
			}
			for(var k:int = 0; k < Globals.totems.length; k++){//arc to player totems
				if(distance(this, Globals.totems[k]) < (arcDistance / 2)){
					Globals.arcLightningLine.graphics.lineStyle(10, 0xFF7667, 1, false, LineScaleMode.VERTICAL,
						CapsStyle.NONE, JointStyle.MITER, 10);
					Globals.arcLightningLine.graphics.moveTo(this.x, this.y);
					Globals.arcLightningLine.graphics.lineTo(Globals.totems[k].x, Globals.totems[k].y);
					Globals.theStage.addChild(Globals.arcLightningLine);
				}
			}
		}
	}
}
