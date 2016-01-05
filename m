Return-Path: <rtc-linux+bncBDS7HNEFSALRBXUJV22AKGQE2DQIC3Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w129si49300wme.1.2016.01.05.00.54.53
        for <rtc-linux@googlegroups.com>;
        Tue, 05 Jan 2016 00:54:53 -0800 (PST)
Date: Tue, 5 Jan 2016 09:54:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Huang, Tao" <huangtao@rock-chips.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	zhangqing <zhangqing@rock-chips.com>, heiko@sntech.de,
	lee.jones@linaro.org, zyw@rock-chips.com,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND PATCH] rtc: rk808: rename rtc-rk808.c to rtc-rk8xx.c
Message-ID: <20160105085135.GG32724@piout.net>
References: <1451571295-4193-1-git-send-email-zhangqing@rock-chips.com>
 <20160104094546.GB32724@piout.net>
 <20160104145938.6c053b5a@linux.lan.towertech.it>
 <568B7F6A.3000607@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <568B7F6A.3000607@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 05/01/2016 at 16:31:38 +0800, Huang, Tao wrote :
> You and Alexandre are right. The rename is just make the driver more
> readable, i.e. let people know this driver suit for more PMIC no just
> rk808. In fact, I don't care the name is rk808 or rk8xx.
> 

For this purpose, you can add the name of the supported PMICs in the
Kconfig.

> The key change of this patch is try to dis-coupling rk808 driver and RTC
> driver. Because of register offset and function is vary between
> different PMIC, we believe it is hard to write one PMIC driver to suit
> all PMIC. So we hope RTC driver can share between all PMIC from rockchip.
> 
> Please review this code:
> 
> -static int rk808_rtc_probe(struct platform_device *pdev)
> +static int rk8xx_rtc_probe(struct platform_device *pdev)
>  {
> -	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> 	...
> +	struct i2c_client *client = to_i2c_client(pdev->dev.parent);
> 
> 	...
> 
> -	rk808_rtc->rk808 = rk808;
> +	rk8xx_rtc->regmap = devm_regmap_init_i2c(client,
> +					     &rk8xx_rtc_regmap_config);
> 	...
> +	rk8xx_rtc->i2c = client;
> 
> Old driver have struct rk808 pointer, which defined on
> include/linux/mfd/rk808.h
> If we write new PMIC driver, for example rk818, define a new struct
> rk818. How can we get this pointer from RTC driver?
> 
> So another way to solve this problem is introduce common struct share
> between all PMIC driver. For example rk8xx.
> 

That is probably the best solution. If you want to reuse drivers between
pmic, then have a common structure that you can pass to those drivers.

I believe the regmap_init_i2c should stay in the MFD driver.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
