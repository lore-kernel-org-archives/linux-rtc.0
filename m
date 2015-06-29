Return-Path: <rtc-linux+bncBDS7HNEFSALRBNM6YSWAKGQEAFZDZNA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si362588wib.1.2015.06.29.02.26.12
        for <rtc-linux@googlegroups.com>;
        Mon, 29 Jun 2015 02:26:12 -0700 (PDT)
Date: Mon, 29 Jun 2015 11:26:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: a.zummo@towertech.it, shawn.guo@linaro.org, kernel@pengutronix.de,
	linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 6/6] apf27: dt: add support of internal rtc
Message-ID: <20150629092610.GY485@piout.net>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
 <1434820360-21935-7-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1434820360-21935-7-git-send-email-tremyfr@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 20/06/2015 at 19:12:40 +0200, Philippe Reynes wrote :
> Enable the internal mxc rtc driver on apf27.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27-apf27.dts |    4 ++++
>  arch/arm/boot/dts/imx27.dtsi      |   10 ++++++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 

I'm not the one taking the patch but I usually separate the addition in
the dtsi from the use in the dts in different patches. But it is up to
Shawn to share his preference.

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
