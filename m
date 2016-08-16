Return-Path: <rtc-linux+bncBCMILY6JWQBBBSP5ZK6QKGQEGMCU6NI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id ph9si2884363pac.1.2016.08.16.00.20.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2016 00:20:41 -0700 (PDT)
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com [209.85.214.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 3C2C323187
	for <rtc-linux@googlegroups.com>; Tue, 16 Aug 2016 14:24:34 +0800 (CST)
Received: by mail-it0-f45.google.com with SMTP id e63so26336077ith.1
        for <rtc-linux@googlegroups.com>; Tue, 16 Aug 2016 00:20:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGb2v66OhH=C5CqB56jN=T4c8TDgyuC=F0689d7=GBhy_rEonA@mail.gmail.com>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
 <1467988422-17934-8-git-send-email-wens@csie.org> <20160711065042.GC4589@lukather>
 <CAGb2v66OhH=C5CqB56jN=T4c8TDgyuC=F0689d7=GBhy_rEonA@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 16 Aug 2016 15:20:17 +0800
Message-ID: <CAGb2v66kLO2RnAyzasuqDbJXYZhcH0pBKraE3MUEJzb6hsEoTg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v5 7/7] ARM: dts: sun9i: Switch to the AC100
 RTC clock outputs for osc32k
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jul 12, 2016 at 10:02 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Jul 11, 2016 at 2:50 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi,
>>
>> On Fri, Jul 08, 2016 at 10:33:42PM +0800, Chen-Yu Tsai wrote:
>>> The 32.768 kHz clock inside the A80 SoC is fed from an external source,
>>> typically the AC100 RTC module.
>>>
>>> Make the osc32k placeholder a fixed-factor clock so board dts files can
>>> specify its source.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>> Changes since v4: none
>>> Changes since v3: none
>>> Changes since v2: none
>>> Changes since v1: none
>>> ---
>>>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 5 +++++
>>>  arch/arm/boot/dts/sun9i-a80-optimus.dts     | 5 +++++
>>>  arch/arm/boot/dts/sun9i-a80.dtsi            | 9 +++------
>>>  3 files changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
>>> index cf2f4b72a841..04b014603659 100644
>>> --- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
>>> +++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
>>> @@ -103,6 +103,11 @@
>>>       allwinner,drive = <SUN4I_PINCTRL_40_MA>;
>>>  };
>>>
>>> +&osc32k {
>>> +     /* osc32k input is from AC100 */
>>> +     clocks = <&ac100_rtc 0>;
>>> +};
>>> +
>>
>> I'm guessing that an unresolved dependency when the driver has not
>> loaded yet, or is not even compiled ?
>>
>> How is it working then?
>
> I assume the clk framework will leave it unresolved and unusable.
> Also it seems that none of existing clks use it as a parent by
> default. I will need to check the remaining unimplemented ones
> though.

On the latest sunxi-next kernel, one clock is clocked from osc32k, which
becomes an orphaned clock:

   clock                         enable_cnt  prepare_cnt        rate
accuracy   phase
----------------------------------------------------------------------------------------
 osc24M                                   6            6    24000000
       0 0
    r_ir                                  1            1     8000000
       0 0
 r_1wire                                  0            0           0
       0 0

r_ir is clocked from osc32k by default, but the clk_set_rate call in the
IR driver seems to forces it to reparent to the working osc24M clock.

So I think we're good here. Can you merge the 3 remaining dts patches?

Thanks
ChenYu

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
