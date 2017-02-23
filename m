Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZF4XTCQKGQEHICD33Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p185si202244wme.1.2017.02.23.09.39.48
        for <rtc-linux@googlegroups.com>;
        Thu, 23 Feb 2017 09:39:48 -0800 (PST)
Date: Thu, 23 Feb 2017 18:39:42 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: pcf2127: bulk read only date and time registers.
Message-ID: <20170223173942.kysd2hq3r2zjs77n@piout.net>
References: <20170223140124.57639-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170223140124.57639-1-sean.nyekjaer@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/02/2017 at 15:01:24 +0100, Sean Nyekjaer wrote:
> Read control registers one by one and bulk read time registers.
> This fixes when the clock is read, the watchdog counter register is zeroed.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> Changes since v1:
> - fixed indentation
> - use of more defines
> 
>  drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
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
