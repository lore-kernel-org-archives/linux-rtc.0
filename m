Return-Path: <rtc-linux+bncBDS7HNEFSALRBZHAVS3QKGQEKC6V7JQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f75si1117896wme.3.2016.03.17.15.32.04
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Mar 2016 15:32:04 -0700 (PDT)
Date: Thu, 17 Mar 2016 23:31:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
Message-ID: <20160317223153.GI2831@piout.net>
References: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
 <20160218143853.GF9654@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160218143853.GF9654@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Rob,

On 18/02/2016 at 08:38:53 -0600, Rob Herring wrote :
> On Mon, Feb 15, 2016 at 11:11:06AM -0300, Javier Martinez Canillas wrote:
> > The S3C binding doc says that the RTC and RTC source clocks are required
> > but the S3C driver supports different HW IP and only the s3c6410 needs a
> > source clock.
> > 
> > Fix the binding explaining that the source clock is only needed for the
> > s3c6410-rtc compatible controller.
> > 
> > Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > ---
> > Hello,
> > 
> > This patch depends on a previous one that was picked by Rob Herring so
> > this one has to go through his tree again and not through the RTC tree
> > to avoid conflicts.
> 
> Ugg, sent pull request today. It should be in Linus' tree now.
> 
> This can go thru rtc tree if you prefer. Otherwise, I'll queue it up for 
> 4.6.
> 

Do you plan to send that one to Linus for 4.6? Else, I still have a few
patches to send before the end of the merge window.

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
