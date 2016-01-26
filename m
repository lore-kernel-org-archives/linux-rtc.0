Return-Path: <rtc-linux+bncBD2OLRXW4ABBBSGAT22QKGQEJTIPCQA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si235703pac.1.2016.01.26.08.35.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 08:35:19 -0800 (PST)
Message-ID: <56A79DB4.6090000@nvidia.com>
Date: Tue, 26 Jan 2016 21:54:20 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <broonie@kernel.org>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, <vreddytalla@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V4 1/5] DT: mfd: add device-tree binding doc
 fro PMIC max77620/max20024
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com> <1453198783-28383-2-git-send-email-ldewangan@nvidia.com> <20160125115610.GC3368@x1> <56A63A85.6060609@nvidia.com> <20160126145854.GC3368@x1>
In-Reply-To: <20160126145854.GC3368@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On Tuesday 26 January 2016 08:28 PM, Lee Jones wrote:
> On Mon, 25 Jan 2016, Laxman Dewangan wrote:
>
>> Hmm. I describe the boolean and tristate only. Do I need to define
>> type for integer,string also?
> I wouldn't describe any of them.  It's normally pretty obvious which
> properties are boolean by the lack of required cell description.
>

Rob suggested to use the type also for Boolean and tristate. I think it 
is good to have for all places that what type of values are valid.


>>>> +The property for fps child nodes as:
>>>> +Required properties:
>>>> +	-reg: FPS number like 0, 1, 2 for FPS0, FPS1 and FPS2 respectively.
>>> I'm surprised Rob Acked this.  We don't usually do device numbers in DT.
>> What is best way to make the child node for FPS and differentiate FPS0,1, 2?
>> What is your suggestion here?
> There are lots of ways you can solve this and so many examples of
> others doing so.  I suggest you have a look at some DTS files and
> figure it out.  One possible solution is to use different compatible
> strings.
Here, I think I can go similar to regulators where child node name 
identifies the regulators.

     fps-config {
         fps0 {
             maxim,fps-time-period-us = <1280>;
             maxim,fps-enable-input = <FPS_EN_SRC_EN0>;
         };

         fps1 {
             maxim,fps-time-period-us = <2560>;
             maxim,fps-enable-input = <FPS_EN_SRC_EN1>;
         };

         fps2 {
             maxim,fps-time-period-us = <640>;
             maxim,fps-enable-input = <FPS_EN_SRC_SW>;
         };
     };

So node name gives the FPS name.

>>> +Pinmux and GPIO:
>>> +===============
>>> I think this whole section needs moving to ../pinctrl and needs to be
>>> reviewed by Linus W.
>> Is this mean I need to create DT binding doc for the each subsystem
>> differently?
>> Actually during AS3722, I had different understanding to have single file.
> Yes, that way you have each of the the subsystem experts review your
> documentation.  You can then link to them from this document.
OK, I will add different dt binding doc in respective driver and squash 
that with respected submodule drivers.

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
