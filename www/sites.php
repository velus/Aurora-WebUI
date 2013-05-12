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
	$smarty->display("sites/$type/".basename($include, ".php").".tpl");
	return;
}

include("./sites/404.php");
?>
