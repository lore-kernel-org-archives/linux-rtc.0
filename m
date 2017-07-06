Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBEUT7DFAKGQEO6USJVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f15si6147989wmg.2.2017.07.06.02.57.38
        for <rtc-linux@googlegroups.com>;
        Thu, 06 Jul 2017 02:57:38 -0700 (PDT)
Date: Thu, 6 Jul 2017 11:57:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH 1/2] rtc: ds1307: add ds1308 variant
Message-ID: <20170706095728.kukyereb7c726fyg@piout.net>
References: <20170608103655.20043-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170608103655.20043-1-sean.nyekjaer@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/06/2017 at 12:36:54 +0200, Sean Nyekjaer wrote:
> The ds1308 variant is very similar to the already supported ds1338
> variant, it have more debug registers and a square wave clock output.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
>  drivers/rtc/rtc-ds1307.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
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
