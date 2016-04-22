Return-Path: <rtc-linux+bncBAABB4OR464AKGQESXXBUYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.x-arc.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id d92si77122wma.2.2016.04.22.02.03.45
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Apr 2016 02:03:45 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 3/7] regulator: rk808: Migrate to regulator
 core's simplified DT parsing code
To: Mark Brown <broonie@kernel.org>
References: <1461244361-45686-1-git-send-email-w.egorov@phytec.de>
 <1461244361-45686-4-git-send-email-w.egorov@phytec.de>
 <20160421160120.GT3217@sirena.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <5719E8CD.1070304@phytec.de>
Date: Fri, 22 Apr 2016 11:03:09 +0200
MIME-Version: 1.0
In-Reply-To: <20160421160120.GT3217@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 21.04.2016 18:01, Mark Brown wrote:
> On Thu, Apr 21, 2016 at 03:12:37PM +0200, Wadim Egorov wrote:
>
>> +static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
>> +{
>> +	unsigned int reg;
>> +	int sel = regulator_map_voltage_linear(rdev, uv, uv);
>> +
>> +	if (sel < 0)
>> +		return -EINVAL;
>> +
>> +	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
>> +
>> +	return regmap_update_bits(rdev->regmap, reg,
>> +				  rdev->desc->vsel_mask,
>> +				  sel);
>> +}
> This is fine but is adding a new feature and not part of the refactoring
> that the changelog talked about so should be in a separate commit.

This is not really a new feature.
rk808_set_suspend_voltage() was using regulator_map_voltage_linear_range().
I have just renamed the function to rk808_set_suspend_voltage_range()
and added an ops struct for ranges.
Yes, I have also added rk808_set_suspend_voltage(), but this is just a split
for the two types of ops that the driver needs now.
This was needed, because the driver used only linear ranges.
IMO it should be a part of the refactoring.

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
