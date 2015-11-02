Return-Path: <rtc-linux+bncBDS7HNEFSALRBNPR3SYQKGQEYTS3NGY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g9si478228wmd.2.2015.11.02.02.19.32
        for <rtc-linux@googlegroups.com>;
        Mon, 02 Nov 2015 02:19:32 -0800 (PST)
Date: Mon, 2 Nov 2015 11:19:31 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>, broonie@kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5 4/4] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
Message-ID: <20151102101931.GK22331@piout.net>
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
 <1446186334-16510-5-git-send-email-alim.akhtar@samsung.com>
 <20151101174048.GD22331@piout.net>
 <5636A44D.4090908@samsung.com>
 <20151102004722.GI22331@piout.net>
 <20151102090359.GR4058@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151102090359.GR4058@x1>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/11/2015 at 09:03:59 +0000, Lee Jones wrote :
> > > I think you cannot apply it directly because it depends on headers from
> > > patch 2/4. It won't build.
> > > 
> > 
> > Yeah, this depends on the mfd tree. I don't thin Lee applied patch 2/4
> > yet so I'm taking that one for 4.5.
> 
> I don't mind if you take it, but if you do so you need to take the
> Regulator patch as well AND provide Mark and I a pull-request from an
> immutable branch please. 
> 

Actually, I was thinking that you would take 2/4 through your tree and I
would either base myself on that or delay the patch for 4.5. You could
also take the rtc patch if you plan to apply 2/4, feel free to add my
acked-by.

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
