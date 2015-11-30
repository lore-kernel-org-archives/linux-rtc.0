Return-Path: <rtc-linux+bncBDS7HNEFSALRBT536KZAKGQEETJ3CJA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q80si915283wmg.0.2015.11.30.11.04.47
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 11:04:47 -0800 (PST)
Date: Mon, 30 Nov 2015 20:04:46 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: a.zummo@towertech.it, linux-arm-kernel@lists.infradead.org,
	maxime.ripard@free-electrons.com, wens@csie.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: sunxi: constify the data_year_param structure
Message-ID: <20151130190446.GL22136@piout.net>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
 <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 19/11/2015 at 11:50:09 +0100, LABBE Corentin wrote :
> The data_year_param struct is never modified, so lets constify it.
> This permit to remove cast since of_device_id is const also.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sunxi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
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
