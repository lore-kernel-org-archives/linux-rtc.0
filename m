Return-Path: <rtc-linux+bncBDS7HNEFSALRBCFC4O4AKGQE6XMT6HA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t18si391310wmt.0.2016.04.21.06.09.28
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 06:09:28 -0700 (PDT)
Date: Thu, 21 Apr 2016 15:09:11 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH v2] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
Message-ID: <20160421130911.GX29844@piout.net>
References: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
 <20160328221915.GC2346@piout.net>
 <5718CBA9.30801@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5718CBA9.30801@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/04/2016 at 08:46:33 -0400, Javier Martinez Canillas wrote :
> Hello Alexandre,
> 
> On 03/28/2016 06:19 PM, Alexandre Belloni wrote:
> > On 15/02/2016 at 11:11:06 -0300, Javier Martinez Canillas wrote :
> >> The S3C binding doc says that the RTC and RTC source clocks are required
> >> but the S3C driver supports different HW IP and only the s3c6410 needs a
> >> source clock.
> >>
> >> Fix the binding explaining that the source clock is only needed for the
> >> s3c6410-rtc compatible controller.
> >>
> >> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>
> >> ---
> >> Hello,
> >>
> >> This patch depends on a previous one that was picked by Rob Herring so
> >> this one has to go through his tree again and not through the RTC tree
> >> to avoid conflicts.
> >>
> > 
> > Well, I'm queuing that one in rtc-fixes for 4.6
> > 
> 
> Are you still planning to push this fix for v4.6? I don't see the patch in
> neither v4.6-rc4 nor linux-next.
> 

Well, I was expecting to get more fixes but didn't so I still didn't
send the PR to Linus. I'll do that this week.

thanks for the reminder!

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
