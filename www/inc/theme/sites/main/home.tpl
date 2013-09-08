{extends file="index.tpl"}
{block name="content"}
<div id="content">
{if #display_date# == "yes"}
<div id="ContentHeaderLeft"><h5>{#sys_name#}</h5></div>

<div id="ContentHeaderCenter">
    <div id="date">
	{$smarty.now|date_format:'it is %d-%m-%Y at %H:%m'}
    </div>
</div>

<div id="ContentHeaderRight"><h5>Home</h5></div>
{/if}

<div class="clear"></div>

<div class="steps">
	<div id="step1">
		<h3>Step 1</h3> 
		<p><a href="index.php?page=register">Create your FREE Account</a> right here on our pages.</p>
	</div>
  

	<div id="step2">
		<h3>Step 2</h3>
		<p><a href="index.php?page=downloads">Download the viewer</a>. We recommend <b>'.$FirestormVersion.'</b>.</p>
	</div>
  
	<div id="step3">
		<h3>Step 3</h3>
		<p><a href="index.php?page=addgrid">Add our grid</a> to your favorite viewer. Don\'t forget it!</p>
	</div>
</div>

<?php if($showSpecialReportHomePage) { ?>
    <div id="annonce10"><p><?php include("sites/modules/specialinfo.php"); ?></p></div>
<?php } ?>

<div id="annonce7"><h3>Welcome to {#sys_name#}</h3>
		<p>This is our New Virtual World where you can have fun, meet people, chat, play, explore, create and share your dreams.</p>
		<p>Everything is possible in our brand new 3D World.</p>
		<p>Our World is created by its residents, you can build everything you can imagine here.</p>
		<p><a href="index.php?page=register">Create a free account today</a> build a virtual you and play in our world.</p>
		<p>Join us now, and make a difference!</p></div>
<div id="annonce10"><p>Please keep in mind that the Aurora platform is still in alpha release and so may not always perform as expected.</p></div>

<div class="infos">
	<div id="info1">
	    <h3>Info Box 1</h3> 
	    <p>Infobox 1 data...</p>
	</div>
	  
	<div id="info2">
	    <h3>Info Box 2</h3>
	    <p>Infobox 2 data...</p>
	</div>

	<div id="info3">
	    <h3>Info Box 3</h3>
	    <p>Infobox 3 data...</p>
	</div>
</div>

</div>
{/block}
