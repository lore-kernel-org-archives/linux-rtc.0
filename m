Return-Path: <rtc-linux+bncBCQJP74GSUDRBQWWV7DAKGQEKOOD7WA@googlegroups.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com. [2607:f8b0:4001:c0b::243])
        by gmr-mx.google.com with ESMTPS id a17si548024itd.1.2017.03.17.06.57.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 06:57:22 -0700 (PDT)
Received: by mail-it0-x243.google.com with SMTP id g138so4100389itb.0
        for <rtc-linux@googlegroups.com>; Fri, 17 Mar 2017 06:57:22 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <SG2PR06MB116586A6CF6082C2CF0341AD8A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-4-chris.brandt@renesas.com> <CAMuHMdXAvMoLu5azcBfX5pH_KYApcYSipBktpbfLybvnCG+bwg@mail.gmail.com>
 <SG2PR06MB1165ECF439A79E31978ACF228A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdWm=4My_H-i-fNpXY9knSLpN+-zNarC5Xdq08kgvauM_w@mail.gmail.com> <SG2PR06MB116586A6CF6082C2CF0341AD8A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Mar 2017 14:57:21 +0100
Message-ID: <CAMuHMdX776kW12d4Sr7s_f4om5rwLTpF=gCTWZdN49ANLi-Q=Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/5] ARM: dts: r7s72100: add rtc clock to
 device tree
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Chris,

On Fri, Mar 17, 2017 at 2:48 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Friday, March 17, 2017, Geert Uytterhoeven wrote:
>> So in the absence of an "rtc0" clock in the device node (you don't have
>> "clock-names" properties in the rtc devvice node yet), it will fall back
>> to clk_get_sys(), and will find the global "rtc0" clock. Unless you call
>> it "rtc"...
>>
>> Most drivers using a single clock just pass NULL instead of a name, so it
>> will match the first clock found.
>>
>> I think the simplest solution is to check if your device is instantiated
>> from DT (pdev->dev.of_node != NULL), and pass NULL (or "fck", when you add
>> multiple clocks to the DT bindings) to devm_clk_get() if that's the case.
>
> OK, so leave current SuperH code the way it is, but add the case for
> (pdev->dev.of_node != NULL) and do things the 'new way' so I can have
> an RTC clock name of "rtc".

Indeed.

> Question: Is your idea to add all the clocks (X1, X3, EXTAL), but put the
> first one as the peripheral clock (the one that runs the register interface 'p0')?

Which one is the peripheral clock doesn't matter if you use clock-names.
The convention is to use "fck" for the functional clock of the device.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
