Return-Path: <rtc-linux+bncBDS7HNEFSALRBKF46KZAKGQES336TAI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 204si879827wmx.1.2015.11.30.11.06.15
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 11:06:15 -0800 (PST)
Date: Mon, 30 Nov 2015 20:06:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Joshua Kinard <kumba@gentoo.org>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc: use %ph for short hex dumps
Message-ID: <20151130190615.GN22136@piout.net>
References: <1448373085-6353-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448373085-6353-1-git-send-email-linux@rasmusvillemoes.dk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24/11/2015 at 14:51:23 +0100, Rasmus Villemoes wrote :
> This makes the generated code slightly smaller.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-ds1305.c |  8 ++------
>  drivers/rtc/rtc-ds1307.c | 17 ++++-------------
>  drivers/rtc/rtc-ds1685.c | 12 +++++-------
>  3 files changed, 11 insertions(+), 26 deletions(-)
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
