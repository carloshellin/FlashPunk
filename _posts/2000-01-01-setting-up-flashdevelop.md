---
layout: tutorial
title: Setting Up FlashDevelop
category: getting-started
---

In this tutorial, we'll go through installing and configuring FlashDevelop. FlashDevelop is a free, open source code editor for Windows designed specifically for Flash ActionScript, and is my personal code editor of choice while developing games.

## Contents

<ul class="nav nav-pills nav-stacked">
	<li><a href="#install-flashdevelop">1. Install FlashDevelop</a></li>
	<li><a href="#hello-world">2. "Hello World" Test</a></li>
	<li><a href="#download-flex">3. Download Flex SDK</a></li>
	<li><a href="#download-debug">4. Download Debug Player</a></li>
	<li><a href="#configure-flashdevelop">5. Configure FlashDevelop</a></li>
	
</ul>

<h2 id="install-flashdevelop">Step 1: Install FlashDevelop</h2>


First order of business is to get FlashDevelop installed and running on your PC, so let’s do that. Go to the [FlashDevelop website][1] and download the latest version. Unless you’re picky, just use the default installation preferences and follow through with the setup. When that’s done, move on to the next step.

> <img src="/uploads/default/4/958e2ce212ad9b0a.png" width="304" height="100">
> 
> *Click this button on the [main page][2] to download the latest version.*

FlashDevelop should automatically download the Flex SDK (necessary for compiling Flash content) and the ActiveX Debug Flash Player (necessary for debugging applications). If it doesn't, please see the extra steps at the bottom of this tutorial.

<h2 id="hello-world">Step 2: “Hello World" test</h2>

Now we’ll check and see if everything’s running properly by making a very simple program. All this program will do is run a blank Flash game and output the text “Hello World!” to the debugger-log so we know the debug player is working correctly. Start a new project by going to:

***Project -> New Project***

A window will appear. Choose AS3 Project from the list of installed templates, and name your project “Hello World”. Choose the Location you want the project to be created (there is a checkbox at the bottom; if you want a folder to be created for the project, check this). You can leave the Package field blank.

> <img src="/uploads/default/7/73ec6e07490fa252.png" width="690" height="473">
> 
> *Set up your new project like this, but choose your own Location on your hard drive.*


When you’re all set, click OK and your project will be created. You will now see a Project dialogue to the right, with three different folders in it. Expand the src (source) folder, and open up the following file inside:

***Main.as***

This will open up in a new tab in FlashDevelop. Main.as is an ActionScript file for the Main class. Main is the first object to be created when your game runs, so it’s where everything starts. It is the only class we are going to use in our Hello World program, so let’s have a look at its code:

{% highlight actionscript %}
package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite
	{
		public function Main():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
	}
}
{% endhighlight %}

We don’t need all that to run our program, so trim it down to just this:

{% highlight actionscript %}
package
{
	import flash.display.Sprite;

	public class Main extends Sprite
	{
		public function Main():void
		{

		}
	}
}
{% endhighlight %}

Now we’ll call a special top-level ActionScript function called trace() which is used for reading information into the debugger. We’ll tell our program to trace the text “Hello World!”, like so:

{% highlight actionscript %}
package
{
	import flash.display.Sprite;

	public class Main extends Sprite
	{
		public function Main():void
		{
			trace("Hello World!");
		}
	}
}
{% endhighlight %}

Save the movie (Ctrl-S) and go to ***Project -> Test Project*** (or just press F5 of Control + Enter) to run your program. This will compile and run your Flash game (SWF) in the default Debug Flash Player (for me, this opens the SWF file in a Firefox tab). You’ll just see a blank page, because your program doesn’t show anything, but if you go back to FlashDevelop, at the bottom is an Output dialogue, and if everything worked it should show the text “Hello World!” inside.

> <img src="/uploads/default/8/95bef924c969e0dc.png" width="304" height="199">
> 
> *Your Output tab should look like this.*

If you don’t see the “Hello World!” text, it means that the debugger isn’t capturing your traces. In that case, you probably have the wrong (or outdated) debugger player installed, so try installing a different one and seeing if it works. You can also try going into:
***Project -> Properties***

And in the Test Movie drop-down box, try changing the display type.

<p class="alert alert-warning">If compilation fails completely, it's likely that something went wrong in the installation process, so you'll have to install the required components manually.</p>


<h2 id="download-flex">Step 3: Download the Flex SDK</h2>

First we need to download the Flex 4 SDK. This is the free codebase provided by Adobe that allows you to develop Flash games; so in order for FlashDevelop to build Flash SWF files, we need to download Flex and tell FlashDevelop where to find it. Go to [this page][3] and download it.

Once you’ve done that, locate your ZIP file and unzip all the Flex files into a location you can remember (for example, I used **C:\Flex**), so we can point FlashDevelop to this location later.

<h2 id="download-debug">Step 4: Download the Debug Player</h2>

Now, we have to install the debugger version of Flash Player. This is a special version of Flash Player which has some extra features for developers that you’ll want to be using in FlashDevelop. So go to [this page][4] and scroll down to here:

***Adobe Flash Player 10 Debugger Versions (aka debug players or content debuggers)***

Below this header are a selection of downloads of the Flash Player debugger. We’re going to be using the standalone Flash Player, which is this one:

***Download the Windows Flash Player 10 Projector content debugger (EXE, 5.18 MB)***

So download that EXE file and put it in the same folder you placed your Flex SDK (eg.**C:\Flex\flashplayer_10_sa_debug.exe**).

<h2 id="configure-flashdevelop">Step 5: Configure FlashDevelop</h2>

Next we’re going to point FlashDevelop to the Flex SDK and the debug player. Start it up and in the filemenu go to:

***Tools -> Program Settings***

This will open up a window with a bunch of tabs on the left side and program options for each on the right. On the left side, select the **AS3 Context tab** and scroll the window down to the field that says **Flex SDK Location**. Set this location to where you unzipped the Flex SDK files in the previous step. Then select the **FlashViewer tab** on the left side, and set the **External Player Path** to the location of your Debug Flash Player downloaded in the previous step.

> <img src="/uploads/default/11/be409331337641c0.png" width="600" height="326">
> 
> *Set the location of your Flex SDK files.*
> 
> <img src="/uploads/default/12/3ce62d63e0bb4af8.png" width="600" height="430">
> 
> *Set the location of your debug Flash Player.*

Once you're finished, try running the Hello World test again. If it still doesn't work, leave a comment here and we'll see if we can get you sorted out. :heart: 

*Original tutorial by Chevy Ray Johnston.*

  [1]: http://www.flashdevelop.org/
  [2]: http://www.flashdevelop.org/
  [3]: http://www.adobe.com/devnet/flex/flex-sdk-download.html
  [4]: http://www.adobe.com/support/flashplayer/downloads.html