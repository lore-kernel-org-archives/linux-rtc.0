Return-Path: <rtc-linux+bncBDAYD2P3QYGRBJPQWG6QKGQEPXUHHPQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id o85si520wme.0.2016.08.11.06.05.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 06:05:41 -0700 (PDT)
Received: by mail-wm0-x22d.google.com with SMTP id o80so14161274wme.1
        for <rtc-linux@googlegroups.com>; Thu, 11 Aug 2016 06:05:41 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 4/4] regulator: qcom_rpm-regulator: Add
 support for pm8018 rpm regulator
To: Stephen Boyd <sboyd@codeaurora.org>, andy.gross@linaro.org,
 david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1468936286-2710-1-git-send-email-narmstrong@baylibre.com>
 <1468936286-2710-5-git-send-email-narmstrong@baylibre.com>
 <6eb6d742-eca4-a442-cff1-0a26601b362d@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <66c73444-be00-5f89-8577-ce2312036ccc@baylibre.com>
Date: Thu, 11 Aug 2016 15:05:41 +0200
MIME-Version: 1.0
In-Reply-To: <6eb6d742-eca4-a442-cff1-0a26601b362d@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Stephen,
On 08/05/2016 12:04 AM, Stephen Boyd wrote:
> On 07/19/2016 06:51 AM, Neil Armstrong wrote:
>> In order to support eh Qualcomm MDM9615 SoC, add support for the
> 
> s/eh/the/
> 
>> PM8018 RPM regulator in the qcom_rpm-regulator driver.
>>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
>> index e254272..0734a5f 100644
>> --- a/drivers/regulator/qcom_rpm-regulator.c
>> +++ b/drivers/regulator/qcom_rpm-regulator.c
>> @@ -70,6 +70,40 @@ struct qcom_rpm_reg {
>>  	bool supports_force_mode_bypass;
>>  };
>>  
>> +static struct rpm_reg_parts rpm8018_ldo_parts = {
>> +	.request_len	= 2,
>> +	.uV		= { 0, 0x007FFFFF,  0},
>> +	.pd		= { 0, 0x00800000, 23},
>> +	.pc		= { 0, 0x0F000000, 24},
>> +	.pf		= { 0, 0xF0000000, 28},
>> +	.ip		= { 1, 0x000003FF,  0},
>> +	.ia		= { 1, 0x000FFC00, 10},
>> +	.fm		= { 1, 0x00700000, 20},
>> +};
>> +
>> +static struct rpm_reg_parts rpm8018_smps_parts = {
>> +	.request_len	= 2,
>> +	.uV		= {  0, 0x007FFFFF,  0},
>> +	.pd		= {  0, 0x00800000, 23},
>> +	.pc		= {  0, 0x0F000000, 24},
>> +	.pf		= {  0, 0xF0000000, 28},
>> +	.ip		= {  1, 0x000003FF,  0},
>> +	.ia		= {  1, 0x000FFC00, 10},
>> +	.fm		= {  1, 0x00700000, 20},
>> +	.pm		= {  1, 0x00800000, 23},
>> +	.freq		= {  1, 0x1F000000, 24},
>> +	.freq_clk_src	= {  1, 0x60000000, 29},
>> +};
>> +
>> +static struct rpm_reg_parts rpm8018_switch_parts = {
>> +	.request_len	= 1,
>> +	.enable_state	= {  0, 0x00000001,  0},
>> +	.pd		= {  0, 0x00000002,  1},
>> +	.pc		= {  0, 0x0000003C,  2},
>> +	.pf		= {  0, 0x000003C0,  6},
>> +	.hpm		= {  0, 0x00000C00, 10},
>> +};
>> +
> 
> These are all the same as the rpm8960 ones, so why don't we reuse those
> structures?

Indeed, I will reuse them.

> 
>>  static const struct rpm_reg_parts rpm8660_ldo_parts = {
>>  	.request_len    = 2,
>>  	.mV             = { 0, 0x00000FFF,  0 },
>> @@ -448,6 +482,44 @@ static struct regulator_ops switch_ops = {
>>  };
>>  
>>  /*
>> + * PM8018 regulators
>> + */
>> +static const struct qcom_rpm_reg pm8018_pldo = {
>> +	.desc.linear_ranges = pldo_ranges,
>> +	.desc.n_linear_ranges = ARRAY_SIZE(pldo_ranges),
>> +	.desc.n_voltages = 161,
>> +	.desc.ops = &uV_ops,
>> +	.parts = &rpm8018_ldo_parts,
>> +	.supports_force_mode_auto = false,
>> +	.supports_force_mode_bypass = false,
>> +};
>> +
>> +static const struct qcom_rpm_reg pm8018_nldo = {
>> +	.desc.linear_ranges = nldo_ranges,
>> +	.desc.n_linear_ranges = ARRAY_SIZE(nldo_ranges),
>> +	.desc.n_voltages = 64,
>> +	.desc.ops = &uV_ops,
>> +	.parts = &rpm8018_ldo_parts,
>> +	.supports_force_mode_auto = false,
>> +	.supports_force_mode_bypass = false,
>> +};
>> +
>> +static const struct qcom_rpm_reg pm8018_smps = {
>> +	.desc.linear_ranges = smps_ranges,
>> +	.desc.n_linear_ranges = ARRAY_SIZE(smps_ranges),
>> +	.desc.n_voltages = 154,
>> +	.desc.ops = &uV_ops,
>> +	.parts = &rpm8018_smps_parts,
>> +	.supports_force_mode_auto = false,
>> +	.supports_force_mode_bypass = false,
>> +};
>> +
>> +static const struct qcom_rpm_reg pm8018_switch = {
>> +	.desc.ops = &switch_ops,
>> +	.parts = &rpm8018_switch_parts,
>> +};
>> +
> 
> These are all the same as the pm8921 ones too? So just use those instead?

They look but the supports_force_mode_bypass is set to "true" for pm8921.
These pm8018 structures are still needed.

> 
> We should probably rethink this design and have these structures based
> on PMIC derivatives instead of SoCs because things are quite similar
> across many PMICs.
> 
This would help to support the huge pmic family !

Neil

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
