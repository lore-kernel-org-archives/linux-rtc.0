Return-Path: <rtc-linux+bncBDS7HNEFSALRBFF4WCWQKGQEPZRNISY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c3si279789wiz.2.2015.07.19.15.00.51
        for <rtc-linux@googlegroups.com>;
        Sun, 19 Jul 2015 15:00:51 -0700 (PDT)
Date: Mon, 20 Jul 2015 00:00:48 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rnd4@dave-tech.it
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Andrea Scian <andrea.scian@dave.eu>
Subject: Re: [rtc-linux] [PATCH] driver: rtc: use rtc_valid_tm() error code
 when reading date/time
Message-ID: <20150719220048.GA15539@piout.net>
References: <557EF5DD.9070300@dave-tech.it>
 <1434447319-23007-1-git-send-email-rnd4@dave-tech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1434447319-23007-1-git-send-email-rnd4@dave-tech.it>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 16/06/2015 at 11:35:19 +0200, rnd4@dave-tech.it wrote :
> From: Andrea Scian <andrea.scian@dave.eu>
> 
> There's a wrong commend in some RTC driver that say it's better to ignore
> rtc_valid_tm() when reading RTC timestamp. However this is wrong and is
> better to return to the userspace the an error if timestamp is not valid.
> 
> Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
> ---
>  drivers/rtc/rtc-isl12022.c |    7 +------
>  drivers/rtc/rtc-pcf2123.c  |    8 +-------
>  drivers/rtc/rtc-pcf2127.c  |    8 +-------
>  drivers/rtc/rtc-pcf8563.c  |    8 +-------
>  4 files changed, 4 insertions(+), 27 deletions(-)
> 

Applied, after dropping the pcf8563 part as it was part of another
patch.


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
