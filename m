Return-Path: <rtc-linux+bncBD2OLRXW4ABBBEWW5C2QKGQEYRQZGNY@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id tn7si5241069pac.1.2016.02.09.10.08.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 10:08:18 -0800 (PST)
Message-ID: <56BA2859.2040605@nvidia.com>
Date: Tue, 9 Feb 2016 23:26:41 +0530
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
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com> <1454171931-27752-2-git-send-email-ldewangan@nvidia.com> <20160209154215.GF24522@x1>
In-Reply-To: <20160209154215.GF24522@x1>
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


On Tuesday 09 February 2016 09:12 PM, Lee Jones wrote:
> On Sat, 30 Jan 2016, Laxman Dewangan wrote:
>
> +	Normal mode also called as active mode on which all step-down
> +		regulators, all linear regulators, GPIOs, and the 32kHz
> +		oscillator are in normal active mode.
> +	sleep mode: Regulators/GPIOs/clock can go on OFF state based on
> "can go on OFF state"?

Regulator/GPIO has two states, enable and disable. If sleep mode is 
configured for these resource and external signal triggers to sleep then 
this get disabled.
>> +	Different modes of regulators/clock/GPIOs are controlled by the their
>> +FPS configurations. There is different configuration registers for each of
>> +these resources. Typical configurations per resource are:
>> +	FPS source: 	Attach the resource to required FPS source. When
>> +			resources are attached to one of FPS source then
>> +			resournce can be enable/disable when related FPS
> Have you used spell check?  I suggest you do.

My bad, I did but mixed with technical ignorance. Will try best.

>
>> +			source gets the control signal for ON and OFF.
>> +	Power on slot: 	Slot number on which resource is ON once FPS source
>> +			get ON signal.
> Can you find another way of explaining this please?

Hmm..
Does it look fine:
There is 8 slots for each FPS on which resource can get enabled. This 
property provides the slot number on which resource gets enabled after 
FPS sequence started.


>
>
> +
> +-maxim,enable-sleep: 		    Boolean, enable sleep state of PMIC
> We already have bindings for sleeping.  Please use a generic one.

Which property? Saw sleep property with vendor prefix.

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
