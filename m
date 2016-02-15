Return-Path: <rtc-linux+bncBDS7HNEFSALRB55KQ63AKGQEL57FHMQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 141si692205wmy.2.2016.02.15.05.41.11
        for <rtc-linux@googlegroups.com>;
        Mon, 15 Feb 2016 05:41:11 -0800 (PST)
Date: Mon, 15 Feb 2016 14:41:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	k.kozlowski.k@gmail.com, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [rtc-linux] [PATCH] rtc: s3c: Document required clocks in the DT binding
Message-ID: <20160215134110.GA15219@piout.net>
References: <1455038632-14545-1-git-send-email-javier@osg.samsung.com>
 <56C01FDD.9050204@samsung.com>
 <56C1C95E.7030002@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56C1C95E.7030002@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/02/2016 at 09:49:34 -0300, Javier Martinez Canillas wrote :
> >No, not entirely. The samsung,s3c6410-rtc needs rtc and rtc_src clocks
> >but rest of compatible devices need only rtc clock.
> >
> 
> Right, sorry for missing that. I noticed that this patch has already
> been picked by Rob Herring (I thought it would be picked by Alexandre
> though) so I will post a follow up patch explaining that rtc_src is
> only for the s3c6410-rtc compatible.
> 

Yeah, I was going to take it, thanks for pointing out the Rob already
has it in his tree.


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
