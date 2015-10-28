Return-Path: <rtc-linux+bncBDS7HNEFSALRBBVUYKYQKGQEC7FK7OQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cm6si1005618wib.1.2015.10.28.02.48.54
        for <rtc-linux@googlegroups.com>;
        Wed, 28 Oct 2015 02:48:54 -0700 (PDT)
Date: Wed, 28 Oct 2015 10:48:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>,
	lee.jones@linaro.org, mturquette@baylibre.com,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support
 for S2MPS15 RTC
Message-ID: <20151028094853.GM22331@piout.net>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
 <56302514.4090407@samsung.com>
 <20151028015323.GZ28319@sirena.org.uk>
 <56303054.8060804@samsung.com>
 <56303DA3.5020306@samsung.com>
 <5630419F.1000300@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5630419F.1000300@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28/10/2015 at 12:31:43 +0900, Krzysztof Kozlowski wrote :
> The s2mps13 clock driver added new name and compatible... which was
> probably totally unneeded (I missed that during review). We don't have
> to make this as a rule...
> 
> Since we do not have any data about future workarounds and the
> differences then just follow Ockham's razor - use the same name and
> compatible.
> 

So you don't care about DT backward compatibility because when a
workaround will be needed for one of the IPs, then you will have to
update the old dtb to use it.

Unless you are sure that the IP is the same, doing

{ "s2mps15-rtc",	S2MPS14X },

is probably the best way to handle that. Note that I personally don't
care about the DT ABI, I'm just pointing out what may happen ;)

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
