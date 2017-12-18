Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37316 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935427AbdLRWYs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Dec 2017 17:24:48 -0500
Date: Mon, 18 Dec 2017 23:24:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: akinobu.mita@gmail.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc-r7301: Fix a possible sleep-in-atomic bug in
 rtc7301_read_time
Message-ID: <20171218222436.GI15162@piout.net>
References: <1513173350-18385-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513173350-18385-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13/12/2017 at 21:55:50 +0800, Jia-Ju Bai wrote:
> The driver may sleep under a spinlock.
> The function call path is:
> rtc7301_read_time (acquire the spinlock)
>   rtc7301_wait_while_busy 
>     usleep_range --> may sleep
> 
> To fix it, usleep_range is replaced with udelay.
> 
> This bug is found by my static analysis tool(DSAC) and checked by my code review.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/rtc/rtc-r7301.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
