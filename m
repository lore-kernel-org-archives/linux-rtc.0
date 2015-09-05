Return-Path: <rtc-linux+bncBDS7HNEFSALRBZNBVOXQKGQERIQNIUQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x20si209088wia.0.2015.09.05.04.24.20
        for <rtc-linux@googlegroups.com>;
        Sat, 05 Sep 2015 04:24:20 -0700 (PDT)
Date: Sat, 5 Sep 2015 13:24:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: k.kozlowski@samsung.com, ryabinin.a.a@gmail.com,
	rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [rtc-linux] [PATCH v2] rtc: ab8500: Add a sentinel to ab85xx_rtc_ids[]
Message-ID: <20150905112419.GH29358@piout.net>
References: <1441367885-10077-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1441367885-10077-1-git-send-email-festevam@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/09/2015 at 08:58:05 -0300, Fabio Estevam wrote :
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add a sentinel to ab85xx_rtc_ids[] in order to fix the following error:
> 
> drivers/rtc/rtc-ab8500: struct platform_device_id is 24 bytes.  The last of 2 is:
> 0x61 0x62 0x38 0x35 0x34 0x30 0x2d 0x72 0x74 0x63 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x8c 
> FATAL: drivers/rtc/rtc-ab8500: struct platform_device_id is not terminated with a NULL entry!
> 
> Reported-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
> Changes since v1:
> - Add also a Reported-by tag from Andrey Ryabinin and also Reviewed-by from
> Krzysztof Kozlowski.
> 
>  drivers/rtc/rtc-ab8500.c | 1 +
>  1 file changed, 1 insertion(+)
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
