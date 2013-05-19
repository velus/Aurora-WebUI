<?php
$DbLink = new DB;
$DbLink->query("SELECT adress,region,allowRegistrations,verifyUsers,ForceAge FROM " . C_ADM_TBL . "");
$db_options = $DbLink->next_record();
$smarty->assign("options", $db_options);

if ( !isset($db_options["allowRegistrations"]) || !$db_options["allowRegistrations"] ) {
	$smarty->display("sites/account/register-disabled.tpl");
	die();
}

$defaults = array();
$defaults["ACCFIRST"] = "";
$defaults["ACCLAST"] = "";
$defaults["WORDPASS"] = "";
$defaults["WORDPASS_CONFIRM"] = "";
$defaults["FIRSTREGION"] = "";
$defaults["LASTREGION"] = "";
$defaults["NAMEF"] = "";
$defaults["NAMEL"] = "";
$defaults["ADDRESS"] = "";
$defaults["ZIP"] = "";
$defaults["CITY"] = "";
$defaults["COUNTRY"] = "";
$defaults["DOB"] = "";
$defaults["EMAIL"] = "";
$defaults["EMAIC"] = "";
$defaults["TOS_AGREE"] = false;

$values = array_merge($defaults, $_POST);

function validate_form($values) {
	$errors = array();

	foreach( $values as $field => $value ) {
		if ( empty($value) || $value ) {
			$errors[$field] = "$field is missing";
		}
	}

	return $errors;
}

$errors = array();
if ( isset($_POST) && !empty($_POST) ) {
	//the form was submitted
	$errors = validate_form($values);
}
$smarty->assign("errors", $errors);
$smarty->assign("values", $values);

//populate the last_names for the view
//TODO i need to detect if the dropdown is enabled
$DbLink->query("SELECT name FROM ". C_NAMES_TBL ." WHERE active=1 ORDER BY name ASC");
$lastNames = array();
while ( list($NAMEDB) = $DbLink->next_record() ) {
	$lastNames[] = $NAMEDB;
}
$smarty->assign("last_names", $lastNames);


//populate the regions for the view
//XXX this won't work - it needs the regions table from the real server app
//TODO i need to add the ability to detect if dropdown is enabled
//$DbLink->query("SELECT RegionName,RegionUUID FROM " . C_REGIONS_TBL . " ORDER BY RegionName ASC ");
$regions = array();
//while (list($RegionName, $RegionHandle) = $DbLink->next_record()) {
//	$regions[$RegionName] = $RegionHandle;
//}
$smarty->assign("regions", $regions);


//populate the countries for the view
$countries = array();
$DbLink->query("SELECT name FROM " . C_COUNTRY_TBL . " ORDER BY name ASC ");
while (list($COUNTRYDB) = $DbLink->next_record()) {
	$countries[] = $COUNTRYDB;
}
$smarty->assign("countries", $countries);

//Terms of Service
//TODO i need to import the terms of service
$terms_of_service = "I need to import this...";
$smarty->assign("terms_of_service", $terms_of_service);

// Get IP Adress
//XXX since we get HTTP_X_FORWARDED_FOR from the browser it's self, I could set my IP address to "bugs bunny" and the code would be none the wiser.
if (isset($_SERVER["HTTP_X_FORWARDED_FOR"])) {
    $userIP = $_SERVER["HTTP_X_FORWARDED_FOR"];
} elseif ($_SERVER["REMOTE_ADDR"]) {
    $userIP = $_SERVER["REMOTE_ADDR"];
} else {
    $userIP = "This user has no ip";
}

return;

//XXX below this point, there be dragons. (okay, this code just needs to be refactored out of existance, but dragons is more punchy.)

if($ALLOWREGISTRATION == '1')
{

if ($_POST[action] == "") {
    $_SESSION[PASSWD] = "";
    $_SESSION[EMAIC] = "";

function displayDefaultAvatars()
{
	$found = array();
	$found[0] = json_encode(array('Method' => 'GetAvatarArchives', 'WebPassword' => md5(WEBUI_PASSWORD)));
	$do_post_requested = do_post_request($found);
	$recieved = json_decode($do_post_requested);

	if (isset($recieved->{'names'}, $recieved->{'snapshot'}) && count($recieved->{'names'}) > 0)
	{
		$names = $recieved->{'names'};
		$snapshot = $recieved->{'snapshot'};
		$count = count($names);
		echo "<tr><td colspan=\"2\" valign=\"top\">";
		for ($i = 0; $i < $count; $i++)
		{
			echo "<div class=\"avatar_archive_screenshot\"><label for=\"$names[$i]\" >$names[$i]</label>";
			echo "<input type=\"radio\" id=\"$names[$i]\" name=\"AvatarArchive\" value=\"$names[$i]\"";
			if (($_SESSION["AVATARARCHIVE"] == $names[$i]) || (($i == 0) && ($_SESSION["AVATARARCHIVE"] == "")))
			{
				echo "checked />";
			}
			echo "<label for=\"$names[$i]\" ><br><img src=\"".WEBUI_TEXTURE_SERVICE."/index.php?method=GridTexture&uuid=".$snapshot[$i]."\" /></div>";
		}
		echo "</td></tr>";
	}
}

} else if ($_POST[action] == "check") 
{
	return;
	$_SESSION[ACCFIRST] = $_POST[accountfirst];
	$_SESSION[ACCFIRSL] = strtolower($_POST[accountfirst]);
	$_SESSION[ACCLAST] = $_POST[accountlast];
	$_SESSION[AVATARARCHIVE] = $_POST[AvatarArchive];

	if ($ADRESSCHECK == "1") {
		$_SESSION[NAMEF] = $_POST[firstname];
		$_SESSION[NAMEL] = $_POST[lastname];
		$_SESSION[ADRESS] = $_POST[adress];
		$_SESSION[ZIP] = $_POST[zip];
		$_SESSION[CITY] = $_POST[city];
		$_SESSION[COUNTRY] = $_POST[country];
	} else {
		$_SESSION[NAMEF] = "none";
		$_SESSION[NAMEL] = "none";
		$_SESSION[ADRESS] = "none";
		$_SESSION[ZIP] = "00000";
		$_SESSION[CITY] = "none";
		$_SESSION[COUNTRY] = "none";
	}

	if ($REGIOCHECK == "0") {
		$_SESSION[REGIONID] = $_POST[startregion];
	} else {
		$DbLink->query("SELECT startregion FROM " . C_ADM_TBL . "");
		list($adminregion) = $DbLink->next_record();
		$_SESSION[REGIONID] = $adminregion;
	}
	
	$_SESSION[EMAIL] = $_POST[email];
	$_SESSION[EMAIC] = $_POST[emaic];
	$_SESSION[PASSWD] = $_POST[wordpass];
	$_SESSION[PASSWD2] = $_POST[wordpass2];

	$tag = $_POST[tag];
	$monat = $_POST[monat];
	$jahr = $_POST[jahr];

	$tag2 = date("d", time());
	$monat2 = date("m", time());
	$jahr2 = date("Y", time());

	$jahr2 = $jahr2 - 18;
	$agecheck1 = $tag + $monat + $jahr;
	$agecheck2 = $tag2 + $monat2 + $jahr2;
	
	if ($FORCEAGE == "1")
	{
		if ($agecheck1 > $agecheck2)
		{
			session_unset();
			session_destroy();
			$_SESSION = array();
			//header("Location: Index.php?page=register&ERROR=Sorry, you must be 18 to sign up.");
			exit();
		}
	}
	
	require_once('recaptchalib.php');
	$privatekey = "6Lf_MQQAAAAAAB2vCZraiD2lGDKCkWfULvhG4szK";
	$resp = recaptcha_check_answer($privatekey,
					$_SERVER["REMOTE_ADDR"],
					$_POST["recaptcha_challenge_field"],
					$_POST["recaptcha_response_field"]);

	if (!$resp->is_valid) {
		$_SESSION[ERROR] = "The reCAPTCHA wasn't entered correctly. Please try it again.";
		echo "<script language='javascript'>
		   <!--
		   window.location.href='index.php?page=register';
		   -->
		   </script>";
	} else if (($_SESSION[PASSWD] != $_SESSION[PASSWD2]) or ($_SESSION[PASSWD] == '') or ($_SESSION[PASSWD2] == '') or ($_SESSION[EMAIC] == '') or ($_SESSION[EMAIL] == '') or ($_SESSION[CITY] == '') or ($_SESSION[ZIP] == '') or ($_SESSION[ADRESS] == '') or ($_SESSION[NAMEL] == '') or ($_SESSION[NAMEF] == '') or ($_SESSION[ACCFIRST] == '') or ($_SESSION[ACCLAST] == '')) {

		if ($_SESSION[EMAIC] == '') {
			$_SESSION[ERROR] = "Please confirm your email";
		}

		if ($_SESSION[PASSWD] != $_SESSION[PASSWD2]) {
			$_SESSION[ERROR] = "Passwords do not match.";
		}

		if ($_SESSION[PASSWD] == '') {
			$_SESSION[ERROR] = "Please enter your Password";
		}

		if ($_SESSION[PASSWD2] == '') {
			$_SESSION[ERROR] = "Please enter your Password Confirm";
		}

		if ($_SESSION[EMAIL] == '') {
			$_SESSION[ERROR] = "Please enter your Email address";
		}

		if ($_SESSION[CITY] == '') {
			$_SESSION[ERROR] = "Please enter your City";
		}

		if ($_SESSION[ZIP] == '') {
			$_SESSION[ERROR] = "Please enter your ZIP";
		}

		if ($_SESSION[ADRESS] == '') {
			$_SESSION[ERROR] = "Please enter your address";
		}

		if ($_SESSION[NAMEL] == '') {
			$_SESSION[ERROR] = "Please enter your real last name";
		}

		if ($_SESSION[NAMEF] == '') {
			$_SESSION[ERROR] = "Please enter your real first name";
		}

		if ($_SESSION[ACCFIRST] == "") {
			$_SESSION[ERROR] = "Please enter a first name for your account";
		}

		if ($_SESSION[ACCLAST] == "") {
			$_SESSION[ERROR] = "Please enter a last name for your account";
		}

		echo "<script language='javascript'>
		  <!--
				window.location.href='index.php?page=register';
				// -->
				</script>";
	} 
	else if ($_SESSION[EMAIL] != $_SESSION[EMAIC]) {
		$_SESSION[ERROR] = "Email confirmation not correct";
		echo "<script language='javascript'>

		 <!--
				 window.location.href='index.php?page=register';
			   // -->
			   </script>";
	} else {
		$passneu = $_SESSION[PASSWD];
		$passwordHash = md5(md5($passneu) . ":");

		$found = array();
		$found[0] = json_encode(array('Method' => 'CheckIfUserExists', 'WebPassword' => md5(WEBUI_PASSWORD), 'Name' => cleanQuery($_SESSION[ACCFIRST].' '.$_SESSION[ACCLAST])));
		$do_post_requested = do_post_request($found);
		$recieved = json_decode($do_post_requested);

		// echo '<pre>';
		// var_dump($recieved);
		// var_dump($do_post_requested);
		// echo '</pre>';

		if ($recieved->{'Verified'} != false) {
			$_SESSION[ERROR] = "User already exists in Database";
			echo "<script language='javascript'>
				<!--
				window.location.href='index.php?page=register';
				-->
				</script>";
		} else {

			// CODE generator
			function code_gen($cod="") {
				$cod_l = 10;
				$zeichen = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9";
				$array_b = explode(",", $zeichen);

				for ($i = 0; $i < $cod_l; $i++) {
					srand((double) microtime() * 1000000);
					$z = rand(0, 35);
					$cod .= "" . $array_b[$z] . "";
				}
				return $cod;
			}

			$code = code_gen();
			
			$userLevel = -1;
			if($VERIFYUSERS == 0)
				$userLevel = 0;

			$found = array();
			$found[0] = json_encode(array('Method' => 'CreateAccount', 'WebPassword' => md5(WEBUI_PASSWORD),
						'Name' => cleanQuery($_SESSION[ACCFIRST].' '.$_SESSION[ACCLAST]),
						'Email' => cleanQuery($_SESSION[EMAIL]),
						'HomeRegion' => cleanQuery($_SESSION[REGIONID]),
						'PasswordHash' => cleanQuery($passneu),
						'PasswordSalt' => cleanQuery($passwordSalt),
						'AvatarArchive' => cleanQuery($_SESSION[AVATARARCHIVE]),
						'UserLevel' => cleanQuery($userLevel),
						'RLName' => cleanQuery($_SESSION[NAMEF] . ' ' . $_SESSION[NAMEL]),
						'RLAdress' => cleanQuery($_SESSION[ADRESS]),
						'RLCity' => cleanQuery($_SESSION[CITY]),
						'RLZip' => cleanQuery($_SESSION[ZIP]),
						'RLCountry' => cleanQuery($_SESSION[COUNTRY]),
						'RLDOB' => cleanQuery($tag . "/" . $monat . "/" . $jahr),
						'RLIP' => cleanQuery($userIP)
						));
						
						
			$do_post_requested = do_post_request($found);
			$recieved = json_decode($do_post_requested);

			
			// echo '<pre>';
			// var_dump($recieved);
			// var_dump($do_post_requested);
			// echo '</pre>';

			if ($recieved->{'Verified'} == "true") {
				$DbLink = new DB;
				//-----------------------------------MAIL--------------------------------------
				$date_arr = getdate();
				$date = "$date_arr[mday].$date_arr[mon].$date_arr[year]";
				$sendto = $_SESSION[EMAIL];
				$subject = "Account Activation from " . SYSNAME;
				$body .= "Your account was successfully created at " . SYSNAME . ".\n";
				$body .= "Your first name: $_SESSION[ACCFIRST]\n";
				$body .= "Your last name:  $_SESSION[ACCLAST]\n";
				$body .= "Your password:  $_SESSION[PASSWD]\n\n";
				$body .= "In order to login, you need to confirm your email by clicking this link within $deletetime hours:";
				$body .= "\n";
				$body .= "" . SYSURL . "/index.php?page=activate&code=$code";
				$body .= "\n\n\n";
				$body .= "Thank you for using " . SYSNAME . "";
				$header = "From: " . SYSMAIL . "\r\n";
				$mail_status = mail($sendto, $subject, $body, $header);

				//-----------------------------MAIL END --------------------------------------
				// insert code
				$UUIDC = $recieved->{'UUID'};
				$DbLink->query("INSERT INTO " . C_CODES_TBL . " (code,UUID,info,email,time)VALUES('$code','$UUIDC','confirm','".cleanQuery($_SESSION[EMAIL])."'," . time() . ")");
				// insert code end
?>


<div id="content">
    <div id="ContentHeaderLeft"><h5><?php echo SYSNAME; ?></h5></div>
    <div id="ContentHeaderCenter"><p class="register"><b><?php echo $webui_successfully; ?></b></p></div>
    <div id="ContentHeaderRight"><h5><?php echo $webui_register; ?></h5></div>
	
    <div class="clear"></div>

    <div id="message"><p><?php echo $webui_successfully_info; ?></p></div>

    <div id="register">
        <p><?php echo SYSNAME; ?> <?php echo $webui_avatar_first_name; ?>: <b><?php echo $_SESSION[ACCFIRST]; ?></b></p>
        <p><?php echo SYSNAME; ?> <?php echo $webui_avatar_last_name; ?>:  <b><?php echo $_SESSION[ACCLAST]; ?></b></p>
        <p><?php echo SYSNAME; ?> <?php echo $webui_email; ?>: <?php echo $_SESSION[EMAIL]; ?></b></p>
    </div>
</div>

<?php
    session_unset();
	session_destroy();
}

else
{
    echo "<script language='javascript'>
	    <!--
		    window.alert('Unknown error. Please try again later.');
		    window.location.href='index.php?page=register';
		-->
		</script>";
        }
      }
    }
  }
}

else { ?>

<div id="content">
    <div id="ContentHeaderLeft"><h5><?php echo SYSNAME; ?></h5></div>
    <div id="ContentHeaderCenter"></div>
    <div id="ContentHeaderRight"><h5><?php echo $webui_register; ?></h5></div>
    <div class="clear"></div>
    <div id="alert"><p><?php echo $webui_registrations_disabled; ?></p></div>
</div>

<?php } ?>
