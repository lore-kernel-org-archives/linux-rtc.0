Return-Path: <rtc-linux+bncBDS7HNEFSALRBB4ETW3QKGQEAQYFH2I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f75si582055wme.3.2016.03.14.15.58.15
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 15:58:15 -0700 (PDT)
Date: Mon, 14 Mar 2016 23:58:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: Don't print an error on probe deferral
Message-ID: <20160314225811.GG28277@piout.net>
References: <1457987157-1177-1-git-send-email-javier@osg.samsung.com>
 <1457987453.11972.133.camel@perches.com>
 <56E72818.8050407@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56E72818.8050407@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/03/2016 at 18:07:36 -0300, Javier Martinez Canillas wrote :
> Hello Joe,
> 
> On 03/14/2016 05:30 PM, Joe Perches wrote:
> > On Mon, 2016-03-14 at 17:25 -0300, Javier Martinez Canillas wrote:
> >> The clock and source clock looked up by the driver may not be available
> >> just because the clock controller driver was not probed yet so printing
> >> an error in this case is not correct and only adds confusion to users.
> >>
> >> However, knowing that a driver's probe was deferred may be useful so it
> >> can be printed as debug information.
> > 
> > Hello again Javier:
> >> +			dev_dbg(&pdev->dev, "probe deferred due missing rtc clk\n");
> > 
> > Again, intelligible English would not use "due"
> > but would use "due to" or "because of".
> > 
> 
> Ok, I'll post another version then. I hope the third time's the charm...
> 
> Alexandre, do you have any other comments before I re-spin this patch?
> 

No further comments :)


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
