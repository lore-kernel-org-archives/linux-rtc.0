Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBDEOU66QKGQEN3HUG3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r197si103420wmf.2.2016.08.09.05.05.32
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Aug 2016 05:05:32 -0700 (PDT)
Date: Tue, 9 Aug 2016 14:05:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: pcf2123: Add missing error code
 assignment before test
Message-ID: <20160809120531.GY8132@piout.net>
References: <1470743907-11498-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1470743907-11498-1-git-send-email-christophe.jaillet@wanadoo.fr>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/08/2016 at 13:58:27 +0200, Christophe JAILLET wrote :
> It is likely that checking the result of 'pcf2123_write_reg' is expected
> here.
> Also fix a small style issue. The '{' at the beginning of the function
> is misplaced.
> 
> Fixes: 809b453b76e15 ("rtc: pcf2123: clean up writes to the rtc chip")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/rtc/rtc-pcf2123.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
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
