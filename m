Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUOLXG6QKGQE5ZFTLNI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i193si224495wmg.1.2016.08.12.17.12.01
        for <rtc-linux@googlegroups.com>;
        Fri, 12 Aug 2016 17:12:01 -0700 (PDT)
Date: Sat, 13 Aug 2016 02:12:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: fix a cast removing the const attribute
Message-ID: <20160813001201.GD5245@piout.net>
References: <1471005974-16973-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1471005974-16973-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/08/2016 at 14:46:14 +0200, LABBE Corentin wrote :
> The char pointer buf_ptr is assigned an address from a const char
> pointer buf (parameter of wakealarm_store).
> The data pointer by buf_ptr is never modified.
> So casting it to a (char *) is useless.
> 
> This patch remove this cast, and transform buf_ptr to a const char pointer.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
