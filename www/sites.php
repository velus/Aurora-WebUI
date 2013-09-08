<?
/*
 * Copyright (c) 2007, 2008 Contributors, http://opensimulator.org/
 * See CONTRIBUTORS for a full list of copyright holders.
 *
 * See LICENSE for the full licensing terms of this file.
 *
*/

$DbLink = new DB;

$page = $_SESSION["page"];

$DbLink->query("SELECT type, include FROM ".C_SITES_TBL." where pagecase = '".cleanQuery($page)."'");

while(list($type,$include) = $DbLink->next_record())
{
	//FIXME this is not a good way of doing things but it's needed until there is a proper framework in place
	$page_name = basename($include, ".php");
	$path = "sites/$type/$page_name.php";
	if ( file_exists($path) ) {
		include("sites/$type/".$page_name.".php");
	}
	$smarty->display("sites/$type/".$page_name.".tpl");
	return;
}

include("./sites/404.php");
?>
