Return-Path: <rtc-linux+bncBDS7HNEFSALRBFHJUG3AKGQEFZ3CAHA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si579218wmd.0.2016.02.20.06.13.39
        for <rtc-linux@googlegroups.com>;
        Sat, 20 Feb 2016 06:13:39 -0800 (PST)
Date: Sat, 20 Feb 2016 15:13:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: rtc-linux@googlegroups.com,
	Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: [rtc-linux] Re: [PATCH] rtc: rv8803: convert spin_lock to mutex_lock
Message-ID: <20160220141339.GG2222@piout.net>
References: <1454589920-32738-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454589920-32738-1-git-send-email-dirk.behme@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 04/02/2016 at 13:45:20 +0100, Dirk Behme wrote :
> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> 
> Fix a scheduling while atomic issue caused by rv8803_set_time()
> holding a spinlock during the call to i2c_smbus_read_byte_data().
> 
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> ---
>  drivers/rtc/rtc-rv8803.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 

This didn't apply cleanly but I fixed it up.
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
