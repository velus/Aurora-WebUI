{extends file="index.tpl"}
{block name="content"}
    <div id="content">
   
<!-- 
    <div id="ContentHeaderLeft"><h5><?php echo SYSNAME; ?></h5></div>
    <div id="ContentHeaderCenter"></div>
    <div id="ContentHeaderRight"><h5><?php echo $webui_register; ?></h5></div>
-->
	
    <div id="register">
        <form ACTION="index.php?page=register" METHOD="POST" onsubmit="if (!validate(this)) return false;">
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
                    <td class="even" width="52%"><span id="accountfirst_label">First Name*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input minlength="3" id="register_input" require="true" nospecial="true" label="accountfirst_label" name="accountfirst" type="text" size="25" maxlength="15"
value="{$values.ACCFIRST|escape}">
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
                    <td class="odd"><span id="firstname_label">First Name*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="firstname_label" id="register_input" name="firstname" type="text" size="25" maxlength="15" value="{$values.NAMEF|escape}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="lastname_label">Last Name*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="lastname_label" id="register_input" name="lastname" type="text" size="25" maxlength="15" value="{$values.NAMEL|escape}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="adress_label">Address*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="adress_label" id="register_input" name="adress" type="text" size="50" maxlength="50" value="{$values.ADDRESS}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="zip_label">Zip Code*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="zip_label" id="register_input" name="zip" type="text" size="25" maxlength="15" value="{$values.ZIP}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="odd"><span id="city_label">City*</span></td>
                    <td class="odd">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="city_label" id="register_input" name="city" type="text" size="25" maxlength="15" value="{$values.CITY}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="country_label">Country*</span></td>
                    <td class="even">
			{if $countries}
				<select>
					{foreach from=$countries item=country}
						<option>{$country}</option>
					{/foreach}
				</select>
			{/if}
                        <?php echo displayCountry(); ?>
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
                            <input compare="emaic" require="true" nospecial="true" label="email_label" id="register_input" name="email" type="text" size="40" maxlength="40" value="{$values.EMAIL}">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="even"><span id="emaic_label">Confirm Email Address*</span></td>
                    <td class="even">
                        <div class="roundedinput">
                            <input require="true" nospecial="true" label="emaic_label" id="register_input" name="emaic" type="text" size="40" maxlength="40" value="{$values.EMAIC}" >
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
                    <td colspan="2" valign="top" class="odd"><input label="agree_label" require="true" type="checkbox" name="Agree_with_TOS" id="agree" value="1" />
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
