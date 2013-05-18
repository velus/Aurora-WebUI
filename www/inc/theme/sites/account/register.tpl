{extends file="index.tpl"}
{block name="content"}
    <div id="content">
    
    <div id="ContentHeaderLeft"><h5><?php echo SYSNAME; ?></h5></div>
    <div id="ContentHeaderCenter"></div>
    <div id="ContentHeaderRight"><h5><?php echo $webui_register; ?></h5></div>
	
    <div id="register">
        <form ACTION="index.php?page=register" METHOD="POST" onsubmit="if (!validate(this)) return false;">
            <table>
                <tr><td class="error" colspan="2" align="center" id="error_message"><?php echo $_SESSION[ERROR]; ?><?php echo $_GET[ERROR]; ?></td></tr>
                <tr>
                    <td class="even" width="52%"><span id="accountfirst_label">First Name*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input minlength="3" id="register_input" require="true" nospecial="true" label="accountfirst_label" name="accountfirst" type="text" size="25" maxlength="15" value="<?php echo $_SESSION[ACCFIRST]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="accountlast_label">Last name*</span></td>
                    <td class="odd">
			{if $last_names}
                        <select>
				{foreach from=$last_names item=last_name}
				<option>{$last_name}</option>
				{/foreach}
			</select>
			{else}
			<input />
			{/if}
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="wordpass_label">Password*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input minlength="6" compare="wordpass2" require="true" nospecial="true" label="wordpass_label" id="register_input" name="wordpass" type="password" size="25" maxlength="15">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="wordpass2_label">Confirm Password*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input minlength="6" require="true" nospecial="true" label="wordpass2_label" id="register_input" name="wordpass2" type="password" size="25" maxlength="15">
                        </div>
                    </td>
                </tr>

                <?php if ($REGIOCHECK == "0") { ?>

                <tr>
                    <td class="even"><span id="startregion_label">Start Region*</span></td>
                    <td class="even">
			{if $last_names}
                        <select>
				{foreach from=$regions key=region_key item=region_value}
				<option name={$region_key}>{$region_value}</option>
				{/foreach}
			</select>
			{else}
			<input />
			{/if}
                    </td>
                </tr>

                <?php } if ($ADRESSCHECK == "1") { ?>
                <tr>
                    <td class="odd"><span id="firstname_label"><?php echo $webui_first_name; ?>*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="firstname_label" id="register_input" name="firstname" type="text" size="25" maxlength="15" value="<?php echo $_SESSION[NAMEF]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="lastname_label"><?php echo $webui_last_name; ?>*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="lastname_label" id="register_input" name="lastname" type="text" size="25" maxlength="15" value="<?php echo $_SESSION[NAMEL]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="adress_label"><?php echo $webui_address; ?>*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="adress_label" id="register_input" name="adress" type="text" size="50" maxlength="50" value="<?php echo $_SESSION[ADRESS]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="zip_label"><?php echo $webui_zip_code; ?>*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="zip_label" id="register_input" name="zip" type="text" size="25" maxlength="15" value="<?php echo $_SESSION[ZIP]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="city_label"><?php echo $webui_city; ?>*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="city_label" id="register_input" name="city" type="text" size="25" maxlength="15" value="<?php echo $_SESSION[CITY]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="country_label"><?php echo $webui_country; ?>*</span></td>
                    <td class="even">
			**BROKEN BY WEBPIGEON -- NEEDS FIX**
                        <?php echo displayCountry(); ?>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="dob_label"><?php echo $webui_date_of_birth; ?>*</span></td>
                    <td class="odd">
			**BROKEN BY WEBPIGEON -- NEEDS FIX**
                        <?php echo displayDOB(); ?>
                    </td>
                </tr>

                <?php } else if ($FORCEAGE == "1"){ ?>

                <tr>
                    <td class="odd"><span id="dob_label"><?php echo $webui_date_of_birth; ?>*</span></td>
                    <td class="odd">
			**BROKEN BY WEBPIGEON - NEEDS FIX**
                        <?php echo displayDOB(); ?>
                    </td>
                </tr>

                <?php } ?>

                <tr>
                    <td class="odd"><span id="email_label"><?php echo $webui_email; ?>*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input compare="emaic" require="true" nospecial="true" label="email_label" id="register_input" name="email" type="text" size="40" maxlength="40" value="<?php echo $_SESSION[EMAIL]; ?>">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="emaic_label"><?php echo $webui_confirm; ?> <?php echo $webui_email; ?>*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="emaic_label" id="register_input" name="emaic" type="text" size="40" maxlength="40" value="<?php echo $_SESSION[EMAIC]; ?>" >
                        </div>
                    </td>
                </tr>

                <?php displayDefaultAvatars(); ?>

                <?php if( file_exists( $_SERVER{'DOCUMENT_ROOT'} . "/TOS.php"))  { ?>

                <tr>
                    <td class="even" colspan="2">
                        <div style="width:100%;height:300px;overflow:auto;">
                            **TOS GOES HERE**
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" valign="top" class="odd"><input label="agree_label" require="true" type="checkbox" name="Agree_with_TOS" id="agree" value="1" />
                        <label for="agree"><span id="agree_label"><?php echo $site_terms_of_service_agree; ?></span></label>
                    </td>
                </tr>

                <?php } ?>

                <tr>
                    <td class="even">
                        <div class="center">
                            <script type=\"text/javascript\">var RecaptchaOptions = { theme : '".$template_captcha_color."' };</script>
				**BROKEN BY WEBPIGEON -- NEEDS FIX**
                        </div>
                    </td>

                    <td class="even">
                        <div class="center">
                            <input type="hidden" name="action" value="check">
                            <button id="register_bouton" name="submit" type="submit">Create New Account</button>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
{/block}
