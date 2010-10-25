package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import backend.totemInputController;
	
	public class Prototype1 extends Sprite
	{
		/**
		 * here are my totems.  
		 * They are just basic MovieClips that 
		 * I made.  No code attatched.
		**/
		private var totem0:totem = new totem();
		private var totem1:totem = new totem();
		private var totem2:totem = new totem();
		private var totem3:totem = new totem();
		
		
		/**
		 * Your going to need to create a 
		 * new totemInputController object.
		 * This object will be where you get
		 * all of your information from about
		 * the 4 totems the system can track.
		**/
		private var totemStream:totemInputController = new totemInputController();
		
		
		
		public function Prototype1()
		{
			/**
			 * So that TUIO can see the stage, you'll need to add
			 * the totemInputController to the stage.  Not the most
			 * elegant solution but it gets the job done.  After this
			 * you don't really have to worry about the stage child
			 * and can treat the controller like an abstract object.
			**/
			stage.addChild(totemStream);
			
			
			/**
			 * Just adding my totems to the stage
			**/
			stage.addChild(totem0);
			stage.addChild(totem1);
			stage.addChild(totem2);
			stage.addChild(totem3);
			
			/**
			 * This is my loop that will update my totems every frame
			**/
			this.addEventListener(Event.ENTER_FRAME, updateTotems);
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
			
			totem0.x = updatedData[0].getLoc().x;
			totem0.y = updatedData[0].getLoc().y;
			
			totem1.x = updatedData[1].getLoc().x;
			totem1.y = updatedData[1].getLoc().y;
			
			totem2.x = updatedData[2].getLoc().x;
			totem2.y = updatedData[2].getLoc().y;
			
			totem3.x = updatedData[3].getLoc().x;
			totem3.y = updatedData[3].getLoc().y;
		}
	}
}