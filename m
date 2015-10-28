Return-Path: <rtc-linux+bncBDS7HNEFSALRBBFCYOYQKGQEHVYYBHA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g18si117616wmd.1.2015.10.28.06.43.32
        for <rtc-linux@googlegroups.com>;
        Wed, 28 Oct 2015 06:43:32 -0700 (PDT)
Date: Wed, 28 Oct 2015 14:43:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: k.kozlowski.k@gmail.com, Alim Akhtar <alim.akhtar@samsung.com>,
	Mark Brown <broonie@kernel.org>, lee.jones@linaro.org,
	mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support
 for S2MPS15 RTC
Message-ID: <20151028134300.GN22331@piout.net>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
 <56302514.4090407@samsung.com>
 <20151028015323.GZ28319@sirena.org.uk>
 <56303054.8060804@samsung.com>
 <56303DA3.5020306@samsung.com>
 <5630419F.1000300@samsung.com>
 <20151028094853.GM22331@piout.net>
 <5630CE44.7070204@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5630CE44.7070204@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28/10/2015 at 22:31:48 +0900, Krzysztof Kozlowski wrote :
> > So you don't care about DT backward compatibility because when a
> > workaround will be needed for one of the IPs, then you will have to
> > update the old dtb to use it.
> 
> Nope, DTB does not contain the name for RTC driver (s2mps15-rtc). It
> will be exactly the same.
> 

Sure, I see it now. So no change is needed in the rtc driver until you
need to use that particular bit that is different.

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
