/*Doc class for game
********FEATURES

sapwns new levels

These need to get pushed into the level class
	spawns enemies
	spawns totems
	spawns bullets
	
Spawns the game menu, if there is one
dev cheats should likely go here
defines screen resolution



*/
package frontend {
	import backend.totemInputController;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.Event;
	import flash.geom.*;
	import plemmonsutils.MathUtils;
	
	import frontend.Globals;
	
	import frontend.*;
	
	public class GameDocClass extends Sprite{
		
		private var isIREnabled:Boolean=true;//change to true to enable IR
		
		//non - IR contorls
		private var moveRight = false;
		private var moveDown = false;
		private var moveUp = false;
		private var moveLeft = false;
		private var moveSpeed:Number =20;
		
		Globals.arcLightningLine = new Shape();//is the global electric arc graphic
		
		//screen size management
		private var spacer:Number = 50;
		
		private var squidSpawnDelay:Number=0;//time delayfor spawning enemies
		private var anglerSpawnDelay:Number=0;//time delayfor spawning enemies
		private var starfishSpawnDelay:Number=0;//time delayfor spawning enemies
		private var pufferSpawnDelay:Number=0;//time delayfor spawning enemies
		
		private var bulletSpawnDelay:Number=0;//time delay for spawning bullets
		private var enemyBulletSpawnDelay:Number=0;//time delay for spawning bullets
		
		//you can change this later if you want daniel. I dont care
		//private var theStage:MovieClip = (stage.getChildAt(0) as MovieClip); //slight workaround to get an accurate reference to the stage.
			
			
		/**
		 * new totemInputController object.
		 * This object will be where you get
		 * all of your information about
		 * the 4 totems the system can track.
		**/
		private var totemStream:totemInputController = new totemInputController();
		
		public function GameDocClass() {
			/**
			 * So that TUIO can see the stage, you'll need to add
			 * the totemInputController to the stage.  Not the most
			 * elegant solution but it gets the job done.  After this
			 * you don't really have to worry about the stage child
			 * and can treat the controller like an abstract object.
			**/
			stage.addChild(totemStream);
			/**
			 * This determines the control method for totems
			**/
			if(isIREnabled){
				trace("update totems");
				this.addEventListener(Event.ENTER_FRAME, updateTotems);
			}else{
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHander);
			}
			
			trace("init");
			
			Globals.totemBullets = new Array();
			Globals.enemyBullets = new Array();
			Globals.enemies = new Array();
			Globals.theStage = this.stage;
			Globals.totems = new Array();
			Globals.totemDebris = new Array();
			Globals.gameDocClass = this;
			
			/*
			* PLEASE only alter the size of the screen in code here.
			* everything else that uses the screen size will 
			* grab the size from here
			*/
			Globals.screenSizeX = 1280;
			Globals.screenSizeY = 800;
			
			spawnTotems();
			spawnTotems();
			spawnTotems();
			spawnTotems();
			testLevel();
			stage.addEventListener(Event.ENTER_FRAME, spawnEnemy);
			this.addEventListener(Event.ENTER_FRAME, fireOneBullet);
		}
		
		/*
		*creates the totems and places them on stage
		*/
		private function spawnTotems(){
			//trace("GameDocClass spawnTotemAndEnemy");
			Globals.totems.push(new Totem(450 + spacer,300 + spacer));
			stage.addChild(Globals.totems[Globals.totems.length-1]);
			//Globals.totems[Globals.totems.length-1].Init();
			spacer+=50;
		}
		
		private function spawnEnemy(event:Event){
			starfishSpawnDelay++;
			squidSpawnDelay++;
			anglerSpawnDelay++;
			pufferSpawnDelay++;
			
			//trace("Globals.enemies " + Globals.enemies);
			if(Globals.enemies.length <= 1){
				var newEnemyNumber:Number = Math.floor(Math.random()* 4);
				if(newEnemyNumber == 1){
					//add a isopod
					Globals.enemies.push(new Isopod( Math.random()* 1180, (Math.random()* 50) + 50));
					stage.addChild(Globals.enemies[Globals.enemies.length-1]);
					Globals.enemies[Globals.enemies.length-1].Init();
				}
				if(newEnemyNumber == 2){
					//add a puffer
					Globals.enemies.push(new Pufferfish(50 + Math.random()* 1180, Math.random()* 50));
					stage.addChild(Globals.enemies[Globals.enemies.length-1]);
					Globals.enemies[Globals.enemies.length-1].Init();
				}
				if(newEnemyNumber == 3){
					//add a squid
					Globals.enemies.push(new Squid( Math.random()* 1180, (Math.random()* 50) + 50));
					stage.addChild(Globals.enemies[Globals.enemies.length-1]);
					Globals.enemies[Globals.enemies.length-1].Init();
				}
				if(newEnemyNumber == 4){
					//add a angler
					Globals.enemies.push(new Angler( Math.random()* 1180, (Math.random()* 50) + 50));
					stage.addChild(Globals.enemies[Globals.enemies.length-1]);
					Globals.enemies[Globals.enemies.length-1].Init();
				}
			}
		}
		
		private function testLevel(){
			//add a angler
			Globals.enemies.push(new Isopod( Math.random()* 1180, (Math.random()* 50) + 50));
			stage.addChild(Globals.enemies[Globals.enemies.length-1]);
			Globals.enemies[Globals.enemies.length-1].Init();
			
			//add a puffer
			Globals.enemies.push(new Pufferfish(50 + Math.random()* 1180, Math.random()* 50));
			stage.addChild(Globals.enemies[Globals.enemies.length-1]);
			Globals.enemies[Globals.enemies.length-1].Init();
		}
		
		private function updateNonIRMovement(){
			for each(var totem:Totem in Globals.totems){
				if(moveLeft == true){
					totem.x -= moveSpeed;
				}
				if(moveUp == true){
					totem.y -= moveSpeed;
				}
				if(moveRight == true){
					totem.x += moveSpeed;
				}
				if(moveDown == true){
					totem.y += moveSpeed;
				}
			}
		}
		
		private function updateHealthInformation(){
			
		}
		
		//called from totem to spawn a bullet
		//probably needs to get pushed back down into totem
		public function fireOneBullet(event:Event){//eventually dx and dy need to get added in here
		for each(var enemy:Enemy in Globals.enemies){
			if(enemy is Squid){
				(enemy as Squid).updateEnemy();
			}
			if(enemy is Pufferfish){
				(enemy as Pufferfish).updateEnemy();
			}
			if(enemy is Isopod){
				(enemy as Isopod).updateEnemy();
			}
		}
			updateNonIRMovement();
			updateHealthInformation();
			var factor:Number = 20;
			
			//fireEnemyBullet(shot1X + thePoint.x, shot1Y + thePoint.y, shot1X/ 10, shot1Y /10);
			//trace("GameDocClass fireOneBullet");
			bulletSpawnDelay++;
			if(bulletSpawnDelay >= 12){
				bulletSpawnDelay = 0;
				for(var i:Number=0; i < Globals.totems.length; i++) {
					//bullet speed on x and y
					var shot1X = (MathUtils.degreesToSlope( Globals.totems[i].rotation -90).x * (factor * 10));//+90 is down
					var shot1Y = (MathUtils.degreesToSlope( Globals.totems[i].rotation -90).y * (factor * 10));
					var newBullet = new Bullet(shot1X/ 10, shot1Y/ 10, "player");
					Globals.totemBullets.push(newBullet);
					newBullet.totemRef=Globals.totems[i];
					newBullet.x = Globals.totems[i].x;
					newBullet.y = Globals.totems[i].y;
					stage.addChild(newBullet);
				}
			}
		}
		
		//needs x,y,dx,dy
		//called from enemy to spawn a bullet
		public function fireEnemyBullet(bulletX, bulletY, bulletDx, bulletDy, enemyFiredBy){//eventually dx and dy need to get added in here
			//trace("GameDocClass fireEnemyBullet");
			var fireType:String = enemyFiredBy;
			var newBullet = new Bullet(bulletDx, bulletDy, fireType);
			Globals.enemyBullets.push(newBullet);
			newBullet.x = bulletX;
			newBullet.y =bulletY;
			stage.addChild(newBullet);
		}
		
		/*
		*move the totems via keyboard
		*/
		private function keyDownHandler(event:KeyboardEvent){
			//trace("Totem keyDownHandler");
			if(event.keyCode == 32){
				//trace("spacebar");
			}
			if(event.keyCode == 37){
				//trace("left");
				moveLeft = true;
			}
			if(event.keyCode == 38){
				//trace("up");
				moveUp = true;
			}
			if(event.keyCode == 39){
				//trace("right");
				moveRight = true;
			}
			if(event.keyCode == 40){
				//trace("down");
				moveDown = true;
			}
		}
		
		private function keyUpHander(event:KeyboardEvent){
			if(event.keyCode == 37){
				event.keyCode = 0;
				moveLeft = false;
			}
			if(event.keyCode == 38){
				event.keyCode = 0;
				moveUp = false;
			}
			if(event.keyCode == 39){
				event.keyCode = 0;
				moveRight = false;
			}
			if(event.keyCode == 40){
				event.keyCode = 0;
				moveDown = false;
			}
		}
		
		private function updateTotems(e:Event) {
			/**
			 * Here we're actually pulling the totem data 
			 * into our array.  You'll have to do this each
			 * time you want to get new updated data from the 
			 * controller.  Each totem is always referenced in
			 * the same array index.  Totem0 will always be 
			 * in the 0 index of the returned array.  The array is
			 * populated with the lpergTotem datatype.
			**/
			
			var updatedData:Array = totemStream.totemData();
			
			/**
			 * The rest of the code is just setting the new 
			 * location of the totems.  If you need to get the 
			 * deltaX or deltaY of a totem, this information is
			 * already calculated in the back-end.  See the documentation
			 * for the lpergTotem datatype for more information.
			**/
			
			Globals.totems[0].x = updatedData[0].getLoc().x;
			Globals.totems[0].y = updatedData[0].getLoc().y;
			
			Globals.totems[1].x = updatedData[1].getLoc().x;
			Globals.totems[1].y = updatedData[1].getLoc().y;
			
			Globals.totems[2].x = updatedData[2].getLoc().x;
			Globals.totems[2].y = updatedData[2].getLoc().y;
			
			Globals.totems[3].x = updatedData[3].getLoc().x;
			Globals.totems[3].y = updatedData[3].getLoc().y;
			trace(Globals.totems[3].y = updatedData[3].getLoc().y);
			
		}
	}
}
