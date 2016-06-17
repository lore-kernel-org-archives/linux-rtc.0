Return-Path: <rtc-linux+bncBC2JZN6WSAHRBJGWSC5QKGQEPUOLHOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com. [2607:f8b0:400e:c03::234])
        by gmr-mx.google.com with ESMTPS id 62si5378195pfx.1.2016.06.17.09.53.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2016 09:53:55 -0700 (PDT)
Received: by mail-pa0-x234.google.com with SMTP id bz2so30110821pad.1
        for <rtc-linux@googlegroups.com>; Fri, 17 Jun 2016 09:53:55 -0700 (PDT)
Date: Fri, 17 Jun 2016 09:53:52 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 5/5] regulator: qcom_rpm-regulator: Add
 support for pm8018 rpm regulator
Message-ID: <20160617165352.GA1256@tuxbot>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> In order to support eh Qualcomm MDM9615 SoC, add support for the
> PM8018 RPM regulator in the qcom_rpm-regulator driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
[..]
> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
[..]
> +/**
> + * enum rpm_vreg_voltage_corner - possible voltage corner values
> + *
> + * These should be used in regulator_set_voltage and rpm_vreg_set_voltage calls
> + * for corner type regulators as if they had units of uV.
> + */
> +enum rpm_vreg_voltage_corner {
> +	RPM_VREG_CORNER_NONE = 1,
> +	RPM_VREG_CORNER_LOW,
> +	RPM_VREG_CORNER_NOMINAL,
> +	RPM_VREG_CORNER_HIGH,
> +};
> +
> +static struct regulator_linear_range corner_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(RPM_VREG_CORNER_NONE, 0,
> +				RPM_VREG_CORNER_HIGH, 1),
> +};
> +
>  static int rpm_reg_write(struct qcom_rpm_reg *vreg,
[..]
> +
> +static const struct qcom_rpm_reg pm8018_corner = {
> +	.desc.linear_ranges = corner_ranges,
> +	.desc.n_linear_ranges = ARRAY_SIZE(corner_ranges),
> +	.desc.n_voltages = 4,
> +	.desc.ops = &uV_ops,
> +	.parts = &rpm8018_corner_parts,
> +};
> +
[..]
> +static const struct rpm_regulator_data rpm_pm8018_regulators[] = {
[..]
> +	{ "dig_corner", QCOM_RPM_VOLTAGE_CORNER, &pm8018_corner,
> +						      "vdd_dig_corner" },
> +
> +	{ }
> +};

We have discussed the corners for a long time and I think we've
concluded that they should be exposed as something like an OPP. What we
have agreed on is that they should not be exposed as a regulator with
voltages 1-4uV.

So please drop the corner for now.

Regards,
Bjorn

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
