<?php
/*
 * Copyright (c) 2007 - 2011 Contributors, http://opensimulator.org/, http://aurora-sim.org/
 * See CONTRIBUTORS for a full list of copyright holders.
 *
 * See LICENSE for the full licensing terms of this file.
 *
 */

// Page Load Time 
$time = microtime(); 
$time = explode(" ", $time); 
$time = $time[1] + $time[0]; 
$start = $time;  

//Use gzip if it is supported
if (substr_count($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip'))
    ob_start("ob_gzhandler");
else
ob_start();
session_start();

//start up smarty
include('inc/smarty/Smarty.class.php');
$smarty = new Smarty;
$smarty->template_dir = 'inc/theme';
$smarty->compile_dir = 'inc/theme_c';
$smarty->config_dir = 'inc/config';

// display it
//$smarty->display('index.tpl');

include("settings/config.php");
include("settings/databaseinfo.php");
include("settings/json.php");
include("settings/mysql.php");
include("check.php");
include("languages/translator.php");
include("templates/templates.php");


if (isset($_GET['page'])) {
    $_SESSION['page'] = $_GET['page'];
} else {
    $_SESSION['page'] = 'home';
}

//LOGIN AUTHENTIFICATION
if (isset($_POST['Submit']) && $_POST['Submit'] == $webui_login) {

    $found = array();
    $found[0] = json_encode(array('Method' => 'Login', 'WebPassword' => md5(WEBUI_PASSWORD),
                                 'Name' => cleanQuery($_POST[logname]),
                                 'Password' => cleanQuery($_POST[logpassword])));
    $do_post_request = do_post_request($found);
    $recieved = json_decode($do_post_request);
    $UUIDC = $recieved->{'UUID'};

    if ($recieved->{'Verified'} == "true") {
        $_SESSION[USERID] = $UUIDC;
        $_SESSION[NAME] = $_POST[logname];
        $_SESSION[FIRSTNAME] = $recieved->{'FirstName'};
        $_SESSION[LASTNAME] = $recieved->{'LastName'};

        $found[0] = json_encode(array('Method' => 'SetWebLoginKey', 'WebPassword' => md5(WEBUI_PASSWORD),
                                 'PrincipalID' => $UUIDC));
        $do_post_request = do_post_request($found);
        $recieved = json_decode($do_post_request);
        $WEBLOGINKEY = $recieved->{'WebLoginKey'};
        $_SESSION[WEBLOGINKEY] = $WEBLOGINKEY;
    } else {
        echo "<script language='javascript'>
		<!--
		alert(\"Sorry, no Account matched\");
		// -->
		</script>";
    }
}

if (isset($_POST['Submit']) && $_POST['Submit'] == $webui_admin_login) {

    $found = array();
    $found[0] = json_encode(array('Method' => 'AdminLogin', 'WebPassword' => md5(WEBUI_PASSWORD),
                                 'Name' => $_POST[logname],
                                 'Password' => $_POST[logpassword]));
    $do_post_request = do_post_request($found);
    $recieved = json_decode($do_post_request);
    $UUIDC = $recieved->{'UUID'};
    if ($recieved->{'Verified'} == "true") {
        //Set both the admin and user ids
        $_SESSION[ADMINID] = $UUIDC;
        $_SESSION[USERID] = $UUIDC;
        $_SESSION[NAME] = $_POST[logname];
    } else {
        echo "<script language='javascript'>
		<!--
		alert(\"Sorry, no Admin Account matched\");
		// -->
		</script>";
    }
  } // LOGIN END

  include ("sites.php");
?>
