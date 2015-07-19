Return-Path: <rtc-linux+bncBDS7HNEFSALRBNV5WCWQKGQEH2VH5CA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si292098wiz.0.2015.07.19.15.03.34
        for <rtc-linux@googlegroups.com>;
        Sun, 19 Jul 2015 15:03:34 -0700 (PDT)
Date: Mon, 20 Jul 2015 00:03:33 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rnd4@dave-tech.it
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Andrea Scian <andrea.scian@dave.eu>
Subject: Re: [rtc-linux] [PATCH v2] driver: rtc: pcf2127: use OFS flag to
 detect unreliable date and warn the user
Message-ID: <20150719220333.GB15539@piout.net>
References: <557EF5DD.9070300@dave-tech.it>
 <1434447587-23992-1-git-send-email-rnd4@dave-tech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1434447587-23992-1-git-send-email-rnd4@dave-tech.it>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 16/06/2015 at 11:39:47 +0200, rnd4@dave-tech.it wrote :
> From: Andrea Scian <andrea.scian@dave.eu>
> 
> Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
> ---
> 
> Changes since v1:
> * use BIT() to select the right bitfield instead of hardcode value
> * return -EINVAL if OFS is detected
> * cache OSF into driver structure to warn the user even later
> 
>  drivers/rtc/rtc-pcf2127.c |   26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 

Applied, after adding back the commit message. Thanks!


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
