Return-Path: <rtc-linux+bncBDS7HNEFSALRBKWEUSVAKGQEIIEXJ4I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si152385wia.1.2015.05.05.13.03.53
        for <rtc-linux@googlegroups.com>;
        Tue, 05 May 2015 13:03:53 -0700 (PDT)
Date: Tue, 5 May 2015 22:03:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomasz Figa <tfiga@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
	srv_heupstream@mediatek.com, Samuel Ortiz <sameo@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH v3 3/3] MAINTAINERS: add Mediatek RTC driver
Message-ID: <20150505200352.GQ4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
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

On 28/04/2015 at 15:35:56 +0800, Eddie Huang wrote :
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e5bbc0..eb80610 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1223,6 +1223,13 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
>  S:	Maintained
>  F:	arch/arm/mach-orion5x/ts78xx-*
>  
> +ARM/Mediatek RTC DRIVER
> +M:	Eddie Huang <eddie.huang@mediatek.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/rtc/rtc-mt*

I feel like this is a bit broad. Unless you want to really maintain
rtc-mt* which I guess may not be only Mediatek in the future, I would
use the full filename here. You will probably remember to update it if
you add more, that may not be the case for other developers.


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
