Return-Path: <rtc-linux+bncBAABBQ6W4W5AKGQEDFQPAUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.visioncatalog.com. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id f69si291281wmf.3.2016.06.09.06.12.35
        for <rtc-linux@googlegroups.com>;
        Thu, 09 Jun 2016 06:12:35 -0700 (PDT)
Subject: [rtc-linux] Re: [RESEND PATCH v5 1/5] mfd: RK808: Add RK818 support
To: Lee Jones <lee.jones@linaro.org>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <20160608141735.GE14888@dell> <5759277D.7090101@phytec.de>
 <20160609111201.GA1388@dell>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <57596B1C.2010101@phytec.de>
Date: Thu, 9 Jun 2016 15:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <20160609111201.GA1388@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 09.06.2016 13:12, Lee Jones wrote:
> On Thu, 09 Jun 2016, Wadim Egorov wrote:
>> On 08.06.2016 16:17, Lee Jones wrote:
>>> On Thu, 02 Jun 2016, Wadim Egorov wrote:
>>>
>>>> The RK818 chip is a power management IC for multimedia and handheld
>>> "Power Management IC (PMIC)"
>>>
>>>> devices. It contains the following components:
>>>>
>>>> - Regulators
>>>> - RTC
>>>> - Clkout
>>> Clocking
>>>
>>>> - battery support
>>> Battery support
>>>
>>>> Both chips RK808 and RK818 are using a similar register map.
>>> "Both RK808 ad RK818 chips"
>>>
>>>> So we can reuse the RTC and Clkout functionality.
>>> Swap '.' for ','.
>>>
>>>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>>>> ---
>>>>  drivers/mfd/Kconfig       |   4 +-
>>>>  drivers/mfd/rk808.c       | 231 ++++++++++++++++++++++++++++++++++++++--------
>>>>  include/linux/mfd/rk808.h | 162 ++++++++++++++++++++++++++++++--
>>>>  3 files changed, 350 insertions(+), 47 deletions(-)
> [...]
>
>>>> -struct rk808_reg_data {
>>>> -	int addr;
>>>> -	int mask;
>>>> -	int value;
>>>> -};
>>> Why are you moving this to the header?
>> It is now part of the rk808 struct.
> Why?
>
For me it seemed reasonable. My idea was to have only one chip variant
check.

I can move the rk808_reg_data struct back to the c file, check for the
chip variant within the probe function and initialize the proper
reg_data variable.
This would also apply to the mfd_cell variables.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
