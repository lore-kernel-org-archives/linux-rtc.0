Return-Path: <rtc-linux+bncBD2OLRXW4ABBBB6G6G2QKGQESBKNYOQ@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ui7si1037716pab.0.2016.02.11.02.31.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 02:31:35 -0800 (PST)
Message-ID: <56BC6048.7080500@nvidia.com>
Date: Thu, 11 Feb 2016 15:49:52 +0530
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
Subject: [rtc-linux] Re: [PATCH V7 1/8] mfd: add device-tree binding doc for
 PMIC max77620/max20024
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com> <1454171931-27752-2-git-send-email-ldewangan@nvidia.com> <20160209154215.GF24522@x1> <56BA2859.2040605@nvidia.com> <20160210132333.GG24522@x1> <56BB3FB9.7050102@nvidia.com> <20160211092604.GG3782@x1>
In-Reply-To: <20160211092604.GG3782@x1>
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


On Thursday 11 February 2016 02:56 PM, Lee Jones wrote:
> On Wed, 10 Feb 2016, Laxman Dewangan wrote:
>
>>
>> sleep: <0/1>
>>              0: sleep mode disable,
>>              1: sleep mode enable.
> Ideally yes.  This is obviously going to be used again.
>
> However;
>   - My fear is that it will get confused with the 'sleep' property in
>     Documentation/devicetree/booting-without-of.txt.
>   - Secondly, you would need to get Rob to Ack it.
>

Another thought, becasue this is just for enable/disable, why not we add 
property as "enable-sleep" of boolean type instead of u32 value type?

It is easy to describe the behavior with enable-sleep and 
enable-low-power-mode.

-enable-sleep:                  Boolean, when FPS event cleared
                                         (set to LOW), resources get 
disabled
                                         at the sequencing event 
corresponding
                                         to its FPS configuration register.

-enable-low-power-mode: Boolean, when FPS event cleared
                                         (set to LOW), resources sets into
                                         low power mode at the 
sequencing event
                                         corresponding to its FPS 
configuration
                                         register.

Both property can not be together.


Other approach is to club together
maxim,device-state-on-disabled-event : u32, describe the PMIC state
                                                             when FPS 
event cleared (set to LOW)
                                                             whether it 
should go to sleep state or
low-power state.
                                                                 1 = 
Device state is set to sleep
                                                                 2 = 
Device state is set to low power mode.
Absence of this property or other value will not change device state 
when FPS event
         cleared.


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
