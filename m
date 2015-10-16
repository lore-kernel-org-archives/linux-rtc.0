Return-Path: <rtc-linux+bncBDS7HNEFSALRBTU2Q2YQKGQENY5HYUA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hs5si184671wib.1.2015.10.16.16.50.37
        for <rtc-linux@googlegroups.com>;
        Fri, 16 Oct 2015 16:50:37 -0700 (PDT)
Date: Sat, 17 Oct 2015 01:50:37 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: Pass the IRQF_ONESHOT flag
Message-ID: <20151016235037.GT3421@piout.net>
References: <1439518416-13044-1-git-send-email-festevam@gmail.com>
 <55D0624A.2020109@samsung.com>
 <55D06B25.3000401@samsung.com>
 <CAJKOXPdhKTy8tvwz3FOtrQLiW=qBM86em_prGLnOr5nc_q3qFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAJKOXPdhKTy8tvwz3FOtrQLiW=qBM86em_prGLnOr5nc_q3qFQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 16/08/2015 at 19:54:33 +0900, Krzysztof Kozlowski wrote :
> Overall the patch is not needed, description is misleading (small
> difference between "works" and "will fail") and cocci script generates
> false positive (at least for max77686, max77802 and rtc-s5m).
> 
> From another point of view, have you tested the patch on these devices?
> This introduces small functional change - the irq becomes oneshot...
> 

I had a good look and they are actually all false positive apart from
isl1208 (they are all MFDs). Fabio, do you mind reworking?


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
