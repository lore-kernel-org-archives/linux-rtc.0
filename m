Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBMPM7TAQKGQEC2KO6DY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l19si1130342wmg.0.2016.11.30.12.27.28
        for <rtc-linux@googlegroups.com>;
        Wed, 30 Nov 2016 12:27:28 -0800 (PST)
Date: Wed, 30 Nov 2016 21:27:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: [rtc-linux] Re: [PATCH v2 0/2] rtc: rtc-twl: cleanup
Message-ID: <20161130202728.zoldekjlc5qrcpgt@piout.net>
References: <20161123085557.5656-1-Nicolae_Rosia@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161123085557.5656-1-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/11/2016 at 10:55:55 +0200, Nicolae Rosia wrote :
> This is a cleanup and preparation of rtc-twl to reduce the usage of
> twl-core exported functions.
> The next patch series will further reduce the usage of exported functions
> but first it requires some changes in mfd/twl-core.c
> 
> v2:
> - dropped patch "rtc: rtc-twl: use irq_of_parse_and_map helper"
> - fixed style problems
> - retained old logic of checking TWL class by introducing an enum
> - dropped of_match_ptr since we depend on OF
> 
> v1 was Tested-by: Tony Lindgren <tony@atomide.com>
> I did not add it in new version of patches because of the changes.
> If you consider that the changes are not big, you could add Tony's Tested-by.
> 
> Nicolae Rosia (2):
>   rtc: rtc-twl: kill static variables
>   rtc: rtc-twl: make driver DT only
> 
>  drivers/rtc/Kconfig   |   1 +
>  drivers/rtc/rtc-twl.c | 202 ++++++++++++++++++++++++++++++--------------------
>  2 files changed, 122 insertions(+), 81 deletions(-)
> 

Both applied, thanks

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
