Return-Path: <rtc-linux+bncBDS7HNEFSALRBFM5YOVQKGQEYLSWZMY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bc3si16214wib.2.2015.06.04.15.17.57
        for <rtc-linux@googlegroups.com>;
        Thu, 04 Jun 2015 15:17:57 -0700 (PDT)
Date: Fri, 5 Jun 2015 00:17:56 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
	a.zummo@towertech.it, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, fabio.estevam@freescale.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: mxc: add a second clock
Message-ID: <20150604221756.GD713@piout.net>
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
 <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
 <20150528115731.GN2185@piout.net>
 <5570BE33.9080103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5570BE33.9080103@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/06/2015 at 23:08:03 +0200, Philippe Reynes wrote :
> >You are getting the rate but don't you need to clk_prepare_enable()?
> 
> This IP needs the clock reference rate for his configuration,
> so I think that I only need the rate.
> 

I think we need to check whether we are guaranteed to get a result from
get_rate even if the clock is not enabled.


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
