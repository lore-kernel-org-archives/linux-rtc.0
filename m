Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXPBWO6QKGQEEQF6RMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w64si89597wmf.3.2016.08.11.14.40.45
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Aug 2016 14:40:45 -0700 (PDT)
Date: Thu, 11 Aug 2016 23:40:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: grimaldi.ivan@gmail.com, rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1390: Fix the SPI chip select number
Message-ID: <20160811214031.GM8132@piout.net>
References: <1470196102-23713-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1470196102-23713-1-git-send-email-festevam@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/08/2016 at 00:48:22 -0300, Fabio Estevam wrote :
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The number after the '@' symbol should be the SPI chip select
> number associated with the ds1390 and it should match the 'reg'
> field.
> 
> So change it the address to zero, to make it consistent.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/dallas,ds1390.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
