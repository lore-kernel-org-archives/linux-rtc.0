Return-Path: <rtc-linux+bncBDS7HNEFSALRBNF46KZAKGQEYRGRXXI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q80si915714wmg.0.2015.11.30.11.06.27
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 11:06:27 -0800 (PST)
Date: Mon, 30 Nov 2015 20:06:27 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/2] drivers/rtc/rtc-ds1685.c: don't try to
 micromanage sysfs output size
Message-ID: <20151130190627.GO22136@piout.net>
References: <1448373085-6353-1-git-send-email-linux@rasmusvillemoes.dk>
 <1448373085-6353-2-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448373085-6353-2-git-send-email-linux@rasmusvillemoes.dk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24/11/2015 at 14:51:24 +0100, Rasmus Villemoes wrote :
> ...and don't do it wrong.
> 
> "not ok or N/A" has length 13. Add the trailing newline, and the
> snprintf return value will be 14. However, we lied to snprintf and
> told it that only 13 bytes were available. Hence snprintf has only
> written "not ok or N/" and a trailing '\0' to the buffer. Next we
> continue lying, this time to the upper sysfs layer, claiming that we
> wrote 14 meaningful bytes to the buffer. That'll make the upper layer
> copy "not ok or N/" plus two nul bytes to user space (one nul byte
> from snprintf, the other since sysfs takes care to clear the buffer
> before giving it to the ->show method).
> 
> In the other cases, the claimed buffer size is closer to sufficient,
> but we'll still get a nul byte instead of a newline written to user
> space.  There's absolutely no reason to try to predict the output
> size, and there's plenty of room in the buffer, so just use sprintf.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-ds1685.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
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
