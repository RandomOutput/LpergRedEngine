package  frontend{
	import flash.display.*;
	import flash.events.*;
	import flash.display.MovieClip;
	
	import flash.display.MovieClip;
	import flash.geom.*;
	import flash.events.*;
	import frontend.Globals;
	import plemmonsutils.MathUtils;
	import flash.geom.Point;
	
	public class Enemy extends MovieClip{
		public var stageRef;
		public var moveSpeedY:Number = Math.random()*10 + 10;
		public var moveSpeedX:Number = Math.random()*20 -10;
		private var health:Number = 100;
		private var enemyType:String = "";
		
	
	
		public function Enemy() {
			// constructor code
			//these can probably get pushed into an update loop
			this.addEventListener(Event.ENTER_FRAME, updateEnemy);
		}
		
		//in case we need to separate this when spawning
		public function Init(){
		}
		
		public function removeListeners(){
			this.removeEventListener(Event.ENTER_FRAME, updateEnemy);
			
		}
		
		private function updateEnemy(event:Event){
			//has the enemy left the play area
			exitedScreen();
			
		}
		
		/*
		* check to see if a enemy exited the screen
		* if so, remove it from the array;
		*
		*/
		private function exitedScreen(){
			if(this.y >= Globals.screenSizeY || this.y <=0 || this.x >= Globals.screenSizeX || this.x <=0 ){//if the enemy has left the stage
				this.removeListeners();
				var arayPosition = Globals.enemies.indexOf(this);
				Globals.enemies.splice(arayPosition,1);
				//trace("removing the object");
				this.parent.removeChild(this);
			}
		}
		
		/*
		* applies damage from the bullet
		*checks to see if the enemy is killed
		*
		*TO DO:
		* apply modifiers to damage based on bullet type
		* apply modifiers to damage based on enemy type
		* needs to pass to Daniel health, how much health taken, by what kind of fire
		*
		*/
		public function hitByPlayer(damageTaken:Number){
			health -= damageTaken;
			//space for defensive and offensive modifiers
			//trace("health " + health);
			killedByPlayer();
		}
		/*
		* check to see if the enemy's health is gone
		* if its dead, remove it and its listeners
		* will probably set off all kinds of feedback stuff
		*/
		private function killedByPlayer(){
			if(health <= 0){
				if(Globals.theStage.contains(this)){
					//trace("killed");
					this.removeListeners();
					var arayPosition = Globals.enemies.indexOf(this);
					Globals.enemies.splice(arayPosition,1);
					//trace("removing the object");
					this.parent.removeChild(this);
					if(this.enemyType == "electriceel"){
						//remove any specific listeners
					}else if(this.enemyType == "pufferfish"){
						//remove any specific listeners
					}else if(this.enemyType == "angler"){
						//remove any specific listeners
					}
					else if(this.enemyType == "squid"){
						//remove any specific listeners
					}
					else if(this.enemyType == "isopod"){
						//remove any specific listeners
					}
				}
			}
		}
		
		/*
		*calculate the distance between two points
		*/
		public function distance(obj1, obj2){
			var dist,xDist,yDist:Number;
			xDist = obj1.x-obj2.x;
			yDist = obj1.y-obj2.y;
			dist = Math.sqrt(xDist*xDist + yDist*yDist);
			//trace(dist);
			return dist;
		}
		
		//allows the subclass to get the heatlh from here
		public function getHealth(){
			return health;
		}
		
		public function setHealth(newHealth){
			health = newHealth;
		}
		//allows the subclass to set the enemy type
		public function setEnemyType(enemyString:String){
			enemyType = enemyString;
		}
		
		//allows other classes to get the type
		public function getEnemyType(){
			return enemyType;
		}
	}
}
