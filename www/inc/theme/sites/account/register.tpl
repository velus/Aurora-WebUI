{extends file="index.tpl"}
{block name="content"}
    <div id="content">
   
<!-- 
    <div id="ContentHeaderLeft"><h5><?php echo SYSNAME; ?></h5></div>
    <div id="ContentHeaderCenter"></div>
    <div id="ContentHeaderRight"><h5><?php echo $webui_register; ?></h5></div>
-->
	
    <div id="register">
        <form ACTION="index.php?page=register" METHOD="POST">
            <table>
		{if $errors}
                <tr>
			<td class="error" colspan="2" align="center" id="error_message">
				<ul>
				{foreach from=$errors item=error}
					<li>{$error}</li>
				{/foreach}
				</ul>
			</td>
		</tr>
		{/if}
		<tr>
			<td colspan="2">
			<fieldset>
				<legend>Account Details</legend>
				<table>
                <tr>
                    <td class="even" width="52%"><span id="accountfirst_label">First Name*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input minlength="3" id="register_input" require="true" nospecial="true" label="accountfirst_label" name="account_fname" type="text" size="25" maxlength="15"
value="{$values.account_fname|escape}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="accountlast_label">Last name*</span></td>
                    <td class="odd">
			<div class="roundedinput">
				{if $last_names}
					{html_options name=account_lname options=$last_names selected=$values.account_lname}
				{else}
					<input />
				{/if}
			</div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="wordpass_label">Password*</span></td>
                    <td class="even">
                        <div class="roundedinput">
				<input type="password" name="password" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="wordpass2_label">Confirm Password*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
				<input type="password" name="password_confirm" />
                        </div>
                    </td>
                </tr>

                <?php if ($REGIOCHECK == "0") { ?>

                <tr>
                    <td class="even"><span id="startregion_label">Start Region*</span></td>
                    <td class="even">
			{if $last_names}
                        <select name="account_startregion">
				{foreach from=$regions key=region_key item=region_value}
				<option name={$region_key}>{$region_value}</option>
				{/foreach}
			</select>
			{else}
			<input />
			{/if}
                    </td>
                </tr>
		</table>
		</fieldset>
		</td>
		</tr>

                <?php } if ($ADRESSCHECK == "1") { ?>
		<tr>
			<td colspan="2">
		<fieldset>
			<legend>Your Address</legend>

			<table>
                <tr>
                    <td class="odd" style="width:52%"><span id="firstname_label">First Name*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
				<input value="{$values.player_fname|escape}" name="player_fname" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="lastname_label">Last Name*</span></td>
                    <td class="even">
                        <div class="roundedinput">
				<input value="{$values.player_lname|escape}" name="player_lname" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="adress_label">Address*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
				<input value="{$values.player_address|escape}" name="player_address" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="zip_label">Zip Code*</span></td>
                    <td class="even">
                        <div class="roundedinput">
				<input value="{$values.player_zip|escape}" name="player_zip" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="city_label">City*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
				<input value="{$values.player_city}" name="player_city" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="country_label">Country*</span></td>
                    <td class="even">
			<div class="roundedinput">
				{html_options name=player_country options=$countries selected=$values.player_country}
			</div>
                    </td>
                </tr>
		</td>
		</tr>
		</table>
		</fieldset>
		</td>
		</tr>
		<?php } ?>

		{if $options.ForceAge}
                <tr>
                    <td class="odd"><span id="dob_label">Date Of Birth*</span></td>
                    <td class="odd">
			{html_select_date prefix="born_" start_year="1900" end_year="2009" field_order="YMD"}
                    </td>
                </tr>
		{/if}

                <tr>
                    <td class="odd"><span id="email_label">Email Address*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input compare="emaic" require="true" nospecial="true" label="email_label" id="register_input" name="email" type="text" size="40" maxlength="40" value="{$values.email|escape}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="emaic_label">Confirm Email Address*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="emaic_label" id="register_input" name="email_confirm" type="text" size="40" maxlength="40" value="{$values.email_confirm|escape}" >
                        </div>
                    </td>
                </tr>

                <?php displayDefaultAvatars(); ?>

		{if $terms_of_service}
                <tr>
                    <td class="even" colspan="2">
                        <div style="width:100%;height:300px;overflow:auto;">
                            {$terms_of_service}
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" valign="top" class="odd"><input label="agree_label" require="true" type="checkbox" name="terms_agree" id="agree" value="1" />
                        <label for="agree"><span id="agree_label">I agree to the terms of service</span></label>
                    </td>
                </tr>
                {/if}

                <tr>
                    <td class="even">
                        <div class="center">
                            <script type=\"text/javascript\">var RecaptchaOptions = { theme : '".$template_captcha_color."' };</script>
				**BROKEN BY WEBPIGEON -- NEEDS FIX**
                        </div>
                    </td>

                    <td class="even">
                        <div class="center">
                            <button id="register_bouton" type="submit">Create New Account</button>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
{/block}
