Return-Path: <rtc-linux+bncBDS7HNEFSALRBFOJROYQKGQEON6WSZI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w4si412563wiz.0.2015.10.17.17.15.17
        for <rtc-linux@googlegroups.com>;
        Sat, 17 Oct 2015 17:15:17 -0700 (PDT)
Date: Sun, 18 Oct 2015 02:15:16 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: at91rm9200: clear RTC alarm status
 flag prior to suspending
Message-ID: <20151018001516.GX3421@piout.net>
References: <1444639163-14255-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444639163-14255-1-git-send-email-wenyou.yang@atmel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12/10/2015 at 16:39:23 +0800, Wenyou Yang wrote :
> As said in the SAMA5D2 datasheet, "Prior to instructing the device
> to enter ULP mode 1, ... and the internal sources of wake-up must
> be cleared."
> 
> This patch is to clear the RTC alarm status flag prior to suspending
> to avoid the erroneous wake-up activity, as it is often used as
> the wake-up source for the ULP mode 1.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2:
>  - Add more detail commit log.
> 
>  drivers/rtc/rtc-at91rm9200.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

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
