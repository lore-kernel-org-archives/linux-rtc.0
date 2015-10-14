Return-Path: <rtc-linux+bncBCXY5EGBQUIBBVFP66YAKGQEAU4Q6LI@googlegroups.com>
Received: from mail-out.m-online.net (mail-out.m-online.net. [2001:a60:0:28:0:1:25:1])
        by gmr-mx.google.com with ESMTPS id bh7si829058wib.1.2015.10.13.21.19.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 21:19:32 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: pcf8563: disable CLKOUT
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1444712938-22865-1-git-send-email-hs@denx.de>
 <20151013201703.GA3421@piout.net>
Cc: linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 devicetree@vger.kernel.org
Reply-To: rtc-linux@googlegroups.com
From: Heiko Schocher <hs@denx.de>
Message-ID: <561DD7D1.5040102@denx.de>
Date: Wed, 14 Oct 2015 06:19:29 +0200
MIME-Version: 1.0
In-Reply-To: <20151013201703.GA3421@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

Am 13.10.2015 um 22:17 schrieb Alexandre Belloni:
> Hi,
>
> On 13/10/2015 at 07:08:58 +0200, Heiko Schocher wrote :
>> Disable the CLKOUT of the RTC after power-up.
>> After power-up/reset of the RTC, CLKOUT is enabled by default,
>> with CLKOUT enabled the RTC chip has 2-3 times higher power
>> consumption. If you do not need CLKOUT, you can disable the
>> CLKOUT with setting "disable-clkout" property.
>>
>
> I think you can simply unconditionally disable clkout. My preferred way
> of doing what you suggest is probably to register a clock in the CCF. If
> the clock is not used, it will be automatically disabled.
> It will also provide a generic way of setting the clkout frequency (some
> RTC are able to output 32kHZ, 1kHz and 1Hz).

Does disabling it ot break some boards?

I take a look into CCF, good idea.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

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
