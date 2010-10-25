package frontend {
	import flash.display.*;
	import flash.events.*;
	import flash.display.MovieClip;
	
	import flash.display.MovieClip;
	import flash.geom.*;
	import flash.events.*;
	import flash.utils.getTimer;
	import flash.media.Sound; 
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import frontend.Globals;
	
	public class Bullet extends MovieClip{
		/*
		*if weare ever going to need to 
		*know which totem the bullet came from
		*
		*/
		private var moveSpeedX:Number = 0;
		private var moveSpeedY:Number = 0;
		public var totemRef:MovieClip;
		private var creationType:String="";
		private var damage:Number=0;
		
	
		public function Bullet(dx:Number,dy:Number, type:String) {
			// constructor code
			moveSpeedX = dx;
			moveSpeedY = dy;
			creationType = type;
			Init();
		}
		
		//in case we need to separate this when spawning
		public function Init(){
			this.addEventListener(Event.ENTER_FRAME, moveBullet);
		}
		
		public function removeListeners(){
			this.removeEventListener(Event.ENTER_FRAME, moveBullet);
			
		}
		
		
		/*
		* moves the bullet
		* handles collision with enemies
		*  and destruction of the bullet
		*/
		
		
		private function moveBullet(event:Event){
				this.y += moveSpeedY;
				this.x += moveSpeedX;
			/*
			* behavior for bullet fire by player
			*/
			var arrayPosition = Globals.totemBullets.indexOf(this);
			if(creationType == "player"){
				this.y += moveSpeedY;
				this.x += moveSpeedX;
				
				if(this.y <= 0){//if the bullet has left the stage
					this.removeListeners();
					arrayPosition = Globals.totemBullets.indexOf(this);
					Globals.totemBullets.splice(arrayPosition,1);
					this.parent.removeChild(this);
				}
				//check for collision between bullets and enemies
				for(var i:int=0; i < Globals.enemies.length; i++){
					if(this.hitTestObject(Globals.enemies[i])){//if the bullet has collided with the an enemy
						if(Globals.theStage.contains(this) && Globals.theStage.contains(Globals.enemies[i])){
							//remove the bullet
							arrayPosition = Globals.totemBullets.indexOf(this);
							this.removeListeners();
							Globals.totemBullets.splice(arrayPosition,1);
							this.parent.removeChild(this);
							//enemy takes damage
							Globals.enemies[i].hitByPlayer(34);
						}
					}
				}
			}
			
			if(creationType == "pufferfish" ||creationType == "starfish" ||creationType == "angler" || creationType == "squid" || creationType == "isopod"){
				//set bullet graphic
				if(creationType == "pufferfish" ){
					this.gotoAndStop("pufferfish");
					damage = 5;
				}
				if(creationType == "starfish" ){
					this.gotoAndStop("starfish");
					damage = 5;
				}
				if(creationType == "angler" ){
					this.gotoAndStop("angler");
					damage = 5;
				}
				if(creationType == "squid" ){
					this.gotoAndStop("squid");
					damage = 5;
				}
				if(creationType == "isopod" ){
					this.gotoAndStop("isopod");
					damage = 0;
				}
				
				if(this.y <= 0){//if the bullet has left the stage
					this.removeListeners();
					arrayPosition = Globals.enemyBullets.indexOf(this);
					Globals.enemyBullets.splice(arrayPosition,1);
					this.parent.removeChild(this);
				}
				//check for collision between totems and enemies bullet
				for(var j:int=0; j < Globals.totems.length; j++){
					if(this.hitTestObject(Globals.totems[j])){//if the bullet has collided with the an enemy
						if(Globals.theStage.contains(this) && Globals.theStage.contains(Globals.totems[j])){
							//remove the bullet
							arrayPosition = Globals.enemyBullets.indexOf(this);
							this.removeListeners();
							Globals.enemyBullets.splice(arrayPosition,1);
							this.parent.removeChild(this);
							//enemy takes damage
							Globals.totems[i].hitByEnemy(damage);
						}
					}
				}
				//check for collision between bullets and enemies
				/*
				* if the bullet hits an ANGLER
				* then destroy the bullet and spawn 5 more from the angler
				*
				*/
				for(var k:int=0; k < Globals.enemies.length; k++){
					if(this.creationType != "player" && this.hitTestObject(Globals.enemies[k])){//if the bullet has collided with the an enemy
						if(Globals.theStage.contains(this) && Globals.enemies[k] is Angler  && Globals.theStage.contains(Globals.enemies[k])){
							//remove the bullet
							arrayPosition = Globals.totemBullets.indexOf(this);
							this.removeListeners();
							Globals.enemyBullets.splice(arrayPosition,1);
							this.parent.removeChild(this);
							/*
							*
							* NEEDS to know which type of bullet to respawn
							*
							*/
							 Globals.enemies[k].prismBullets();
						}
					}
				}
			}
			
			
			/*
			* behavior for bullet fire by isopod
			*/
			for(var l:int=0; l < Globals.totemBullets.length; l++){
				if(this.creationType == "isopod" && this.hitTestObject(Globals.totemBullets[l])){
					
					//remove the totem bullet
				    arrayPosition = l;
					Globals.totemBullets[l].removeListeners();
					Globals.totemBullets[l].parent.removeChild(Globals.totemBullets[l]);
					Globals.totemBullets.splice(arrayPosition,1);
					
					//remove the isopod bullet
					arrayPosition = Globals.enemyBullets.indexOf(this);
					this.removeListeners();
					Globals.enemyBullets.splice(arrayPosition,1);
					if(Globals.theStage.contains(this)){
						this.parent.removeChild(this);
					}
					
					
				}
			}
		}
	}
}
