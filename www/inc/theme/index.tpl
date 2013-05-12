{config_load file='megamenu.conf'}
{config_load file='site.conf'}
<html lang="en" class="no-js">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="templates/no_js.css" type="text/css" />
  <link rel="stylesheet" href="{#template_css#}" type="text/css" />

  <link rel="shortcut icon" href="<?php echo $favicon_image?>" />
  <title>Welcome to {#sys_name#}</title>
  <script src="javascripts/modernizr-1.7.min.js" type="text/javascript"></script>
  <script src="javascripts/global.js" type="text/javascript"></script>
    
  <script src="javascripts/jquery/jquery.min.js" type="text/javascript"></script>
  <script src="javascripts/jquery/slidepanel.js" type="text/javascript"></script>
    
  <script src="javascripts/jquery/jquery.Scroller-1.0.min.js" type="text/javascript"></script> 
  <script src="javascripts/jquery/divscroller.js" type="text/javascript"></script>

  <script type="text/javascript" src="javascripts/calendar-2.2.js"></script>


<?php if($displayLogoEffect) { ?>
<script type="text/javascript">
//<![CDATA[ 
var Header = {
	// Let's write in JSON to make it more modular
	addFade : function(selector){
		$("<span class=\"fake-hover\"></span>").css("display", "none").prependTo($(selector)); 
		// Safari dislikes hide() for some reason
		$(selector+" a").bind("mouseenter",function(){
			$(selector+" .fake-hover").fadeIn("slow");
		});
		$(selector+" a").bind("mouseleave",function(){
			$(selector+" .fake-hover").fadeOut("slow");
		});
	}
};
$(function() { Header.addFade("#headerimages"); } );
//]]>
<?php } ?>
</script>


<?php if($displayRoundedCorner)  { ?>
<script type="text/javascript" src="{#sys_url#}javascripts/jquery/jquery.corner.js?v2.11"></script>
<script type="text/javascript">
// http://jquery.malsup.com/corner/
// Add more class here ...
$('#annonce1, #annonce2, #annonce3, #annonce4, #annonce5, #annonce6, #annonce7, #annonce10').corner();
$('#info1, #info2, #info3, #info4, #info5, #info6, #info7, #info10').corner();
$('#aide1, #aide2, #aide3, #aide4, #aide5, #aide6, #aide7, #aide10').corner();
$('#step1, #step2, #step3, #step4, #step5, #step6, #step7, #step10').corner();
$('#gridstatus1, #gridstatus2, #gridstatus3, #gridstatus4, #gridstatus5').corner();
$('#ContentHeaderLeft, #ContentHeaderCenter, #ContentHeaderRight').corner("5px");
$('.news_time, .news_title, .news_content, #news_online').corner();
	
$(function(){
$('#dynCorner').click(function() {
$('#dynamic').corner();
});

$('#dynUncorner').click(function() {
$('#dynamic').uncorner();
});

$("#translator, #welcomeText").corner("5px");
$('#container,#header,#content').corner(); // (add to curvycorner)
$('#region_map').corner();
$('#login, #register, #forget_pass').corner("5px");
$('.menu').corner();
$('#chat').corner();
$('button, .roundedinput, .forgot_pass_bouton, .adminsettings_bouton').corner("10px");
$('#roundedcoord').corner("10px");
$('#info_loginscreen_button').corner("10px");
});
/* Downlaod Page */
$('#download1, #download2, #download3, #download1 a, #download2 a, #download3 a').corner();

/* AddGrid Page */
$('#addgrid01, #addgrid02, #addgrid03, #addgrid04, #addgrid05, #addgrid06, #addgrid07, #addgrid08, #addgrid09, #addgrid10, #addgrid h3 a').corner();

/* StarDust Currency Pages */
$('#island1, #island2, #island3, #island4, #island5').corner();
$('#island_picture1,#island_picture2,#island_picture3,#island_picture4,#island_picture5').corner();
$('#island_info_part1, #island_info_part2, #island_info_part3, #island_info_part4, #island_info_part5').corner();
// $('#CurrencyHistory').corner();
</script>
<?php } ?>

{if #display_font_sizer# == "yes" }
<script src="javascripts/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="javascripts/jquery/jquery.fontscale.js" type="text/javascript"></script>
<script type="text/javascript">
  $(document).ready(function(){
	$("#up").fontscale("p, h3","up", { unit:"px",increment:1 } );
	$("#down").fontscale("p, h3","down", { unit:"px",increment:1 } );
	$("#reset").fontscale("p, h3","reset");
});
</script>
{/if}

</head>
    
<body  class="webui">

<!-- I don't think we'll be needing this right now...
<div class="absolute">
  <?php if($displayTopPanelSlider) { include("sites/modules/slidepanel.php"); } ?>
</div>
-->

<div id="topcontainer">

<!-- the 1990s called, they want their web design back :/ -->
{if #display_scroller# == "yes" }
  <div class="horizontal_scroller" id="scrollercontrol">
    <div class="scrollingtext">
      {#scroller_msg#}
    </div>
  </div>
{/if}

{if #display_welcome_msg# == "yes"}
  <div id="welcomeText">
	{if isset($smarty.session.name) }
		Welcome Back {$smarty.session.name}.
		{if #allow_web_login# == "yes"}
			<a href=\"secondlife:///app/login?first_name=$_SESSION[FIRSTNAME]&last_name=$_SESSION[LASTNAME]&location=last&grid=$gridNickName&web_login_key=$_SESSION[WEBLOGINKEY]\">$webui_login</a>
		{/if}
	{else}
		Welcome to {#sys_name#}, visitor
	{/if}
  </div>
{/if}

<div id="container">
    <div id="header">
        <div id="headerimages">
            <a href="{#sys_url#}index.php?page=home"><h1>{#sys_name#}</h1></a>
        </div>
        <!-- <div id="gridstatus"><?php //php include("sites/gridstatus.php"); ?></div> -->
             <div id="home_content_right"><script type="text/javascript" src="{#sys_url#}javascripts/jquery/jquery.cycle.all.2.74.js"></script>
<script type="text/javascript" src="{#sys_url#}javascripts/jquery/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="{#sys_url#}javascripts/jquery/jquery.easing.compatibility.js"></script>
<!--  initialize the slideshow when the DOM is ready -->
<script type="text/javascript">

$(document).ready(function() {
    $('.slideshow')
    .before('<div id="nav">') 
    .cycle({
    fx:      '<?= $SlideShowStyle ?>', 
    timeout: '<?= $SlideShowTimeout ?>', 
    speed:   '<?= $SlideShowSpeed ?>',
    easing:  '<?= $SlideShowEaseing  ?>',
    delay:   '<?= $SlideShowDelay ?>',
    sync:    '<?= $SlideShowSync ?>',
    // next:    '<?= $SlideShowNext ?>',
    // prev:    '<?= $SlideShowPrev ?>',
    pause:   '<?= $SlideShowPause ?>',
    random:  '<?= $SlideShowRandom ?>',
    pager:   '<?= $SlideShowPager ?>'
    /* before:  onBefore, */ 
    /* after:    onAfter */
    /* speedIn:  2500, */
    /* speedOut: 500, */
	});

});
</script>


<?php if($displaySlideShow) { ?>
  <div class="slideshow">
    <img src="{#sys_url#}images/gallery/image1thumbnail.jpg" title="<? echo $webui_slideshow_comment01; ?>" alt="" />
  	<img src="{#sys_url#}images/gallery/image2thumbnail.jpg" title="<? echo $webui_slideshow_comment02; ?>" alt="" />
	 <img src="{#sys_url#}images/gallery/image3thumbnail.jpg" title="<? echo $webui_slideshow_comment03; ?>" alt="" />
  	<img src="{#sys_url#}images/gallery/image4thumbnail.jpg" title="<? echo $webui_slideshow_comment04; ?>" alt="" />
  	<img src="{#sys_url#}images/gallery/image5thumbnail.jpg" title="<? echo $webui_slideshow_comment05; ?>" alt="" />
  </div>
<?php } ?></div>
		<div id="home_content_right"><?php include("sites/modules/slideeffect.php"); ?></div>
		
		
    </div><!-- fin de #header -->

<div id="menubar">
	<div id="menu">
		<ul class="menu">
			<li><a href="#">Home</a></li>
		</ul>
	</div>
</div>

    <div id="MainContainer">
        <div id="sites">
		{block "content"}
			<h1>Your site content goes here</h1>
			<p>You need to override the content block for this page.</p>
		{/block}
	</div>
    </div><!-- fin de #mainContent -->
</div><!-- fin de #container -->

{if #display_w3c# == "yes" or #display_rss# == "yes"}
<div id="footer">
    <div id="validator">
  {if #display_w3c# == "yes"}
    <a href="http://validator.w3.org/check?uri=referer">
      <img src="{#image_path#}valid-xhtml10.png" alt="Valid XHTML 1.0 Transitional" height="31" width="88" /></a>
  {/if}
  
  {if #display_rss# == "yes"}
    <a href="http://jigsaw.w3.org/css-validator/check/referer">
      <img src="{#image_path#}valid-css.png" alt="Valid CSS!" /></a>
  {/if}
</div>
</div>
{/if}
<!-- fin de #footer -->
<!--
<div class="pageloadtime">
<?php
// Page Load Time 
$time = microtime(); 
$time = explode(" ", $time); 
$time = $time[1] + $time[0]; 
$finish = $time; 
$totaltime = ($finish - $start);
<p>Copyright 2011 © the Aurora-Sim project</p>
<p>All Rights Reserved</p>
if($displayPageLoadTime) { printf ("$this_page_took %f $seconds_to_load.", $totaltime); }
?>
</div>
-->

</div>
<span id="problem">You do not have your Javascript enabled, and this site requires it.</span>
</body>
</html>
