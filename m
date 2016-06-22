Return-Path: <rtc-linux+bncBC2JZN6WSAHRBK7IVK5QKGQEMBTSZYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com. [2607:f8b0:400e:c00::22b])
        by gmr-mx.google.com with ESMTPS id un17si181341pab.0.2016.06.22.08.52.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2016 08:52:11 -0700 (PDT)
Received: by mail-pf0-x22b.google.com with SMTP id t190so18883581pfb.3
        for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:52:11 -0700 (PDT)
Date: Wed, 22 Jun 2016 08:52:07 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
	andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org,
	lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 4/5] mfd: qcom-rpm: Add support for pm8018 RPM Regulator
Message-ID: <20160622155207.GM1256@tuxbot>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-5-git-send-email-narmstrong@baylibre.com>
 <20160622052340.GI1256@tuxbot>
 <576A4D95.3080804@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <576A4D95.3080804@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed 22 Jun 01:34 PDT 2016, Neil Armstrong wrote:

> On 06/22/2016 07:23 AM, Bjorn Andersson wrote:
> > On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:
> > 
> > [..]
> >> diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
> > [..]
> >> +
> >> +static const struct qcom_rpm_data mdm9615_template = {
> >> +	.version = 3,
> >> +	.resource_table = mdm9615_rpm_resource_table,
> >> +	.n_resources = ARRAY_SIZE(mdm9615_rpm_resource_table),
> >> +};
> > 
> > Please see:
> > https://patchwork.kernel.org/patch/9177159/
> > 
> > You should set the new .sel_size to 4 here, please either rebase ontop
> > of Linus patch or send an update after both are merged.
> > 
> >> +
> >>  static const struct of_device_id qcom_rpm_of_match[] = {
> >>  	{ .compatible = "qcom,rpm-apq8064", .data = &apq8064_template },
> >>  	{ .compatible = "qcom,rpm-msm8660", .data = &msm8660_template },
> >>  	{ .compatible = "qcom,rpm-msm8960", .data = &msm8960_template },
> >>  	{ .compatible = "qcom,rpm-ipq8064", .data = &ipq806x_template },
> >> +	{ .compatible = "qcom,rpm-mdm9615", .data = &mdm9615_template },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(of, qcom_rpm_of_match);
> >> diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd/qcom-rpm.h
> >> index 13a9d4b..db85912 100644
> >> --- a/include/dt-bindings/mfd/qcom-rpm.h
> >> +++ b/include/dt-bindings/mfd/qcom-rpm.h
> >> @@ -148,6 +148,29 @@
> >>  #define QCOM_RPM_SMB208_S2a			138
> >>  #define QCOM_RPM_SMB208_S2b			139
> >>  
> >> +#define QCOM_RPM_PM8018_SMPS1			200
> > 
> > These numbers are a logical identifier and as such you shouldn't skip
> > 140-199.
> > 
> >> +#define QCOM_RPM_PM8018_SMPS2			201
> >> +#define QCOM_RPM_PM8018_SMPS3			202
> >> +#define QCOM_RPM_PM8018_SMPS4			203
> >> +#define QCOM_RPM_PM8018_SMPS5			204
> >> +#define QCOM_RPM_PM8018_LDO1			205
> >> +#define QCOM_RPM_PM8018_LDO2			206
> >> +#define QCOM_RPM_PM8018_LDO3			207
> >> +#define QCOM_RPM_PM8018_LDO4			208
> >> +#define QCOM_RPM_PM8018_LDO5			209
> >> +#define QCOM_RPM_PM8018_LDO6			210
> >> +#define QCOM_RPM_PM8018_LDO7			211
> >> +#define QCOM_RPM_PM8018_LDO8			212
> >> +#define QCOM_RPM_PM8018_LDO9			213
> >> +#define QCOM_RPM_PM8018_LDO10			214
> >> +#define QCOM_RPM_PM8018_LDO11			215
> >> +#define QCOM_RPM_PM8018_LDO12			216
> >> +#define QCOM_RPM_PM8018_LDO13			217
> >> +#define QCOM_RPM_PM8018_LDO14			218
> >> +#define QCOM_RPM_PM8018_LVS1			219
> >> +#define QCOM_RPM_NCP				220
> > 
> > We already have PM8921_NCP and PM8058_NCP, so better make this
> > QCOM_RPM_PM8018_NCP for consistency.
> > 
> >> +#define QCOM_RPM_VOLTAGE_CORNER			221
> >> +
> > 
> > Other then these details
> > Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Regards,
> > Bjorn
> > 
> Thanks,
> 
> I rebased on Linus two patches ("fix offset error for msm8660" and "parametrize also ack selector size")
> 
> I suppose I should also drop the QCOM_RPM_VOLTAGE_CORNER rpm entry also ?

The open question is how we expose the corner to client drivers, but
it's still part of the rpm protocol. So please leave it here.

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
