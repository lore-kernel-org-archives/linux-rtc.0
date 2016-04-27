Return-Path: <rtc-linux+bncBAABBZV3QG4QKGQERFCNPZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.visioncatalog.com. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id v130si365792wmv.1.2016.04.26.23.36.21
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Apr 2016 23:36:21 -0700 (PDT)
Subject: [rtc-linux] Re: Applied "regulator: rk808: remove linear range
 definitions with a single range" to the regulator tree
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>
References: <E1aukkg-0007km-6s@debutante> <2754883.PYP7KbpM33@diego>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, a.zummo@towertech.it, pawel.moll@arm.com, rtc-linux@googlegroups.com, ijc+devicetree@hellion.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, alexandre.belloni@free-electrons.com, dianders@chromium.org, galak@codeaurora.org, zyw@rock-chips.com, lee.jones@linaro.org, linux-clk@vger.kernel.org
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <57205DC2.7070506@phytec.de>
Date: Wed, 27 Apr 2016 08:35:46 +0200
MIME-Version: 1.0
In-Reply-To: <2754883.PYP7KbpM33@diego>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 26.04.2016 21:33, Heiko St=C3=BCbner wrote:
> Am Montag, 25. April 2016, 18:56:54 schrieb Mark Brown:
>> The patch
>>
>>    regulator: rk808: remove linear range definitions with a single range
>>
>> has been applied to the regulator tree at
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
> with this patch applied, 4.6.0-rc5-next-20160426 fails to boot on=20
> rk3288-veyron devices with the bug below. Reverting this one patch
> results in the system booting again:
>
This is because I missed to add the correct ops for LDO_REG3 in this patch.

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
