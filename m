Return-Path: <rtc-linux+bncBDS7HNEFSALRBOF442ZQKGQEF7UR5JI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 204si739780wmx.1.2015.12.22.11.02.15
        for <rtc-linux@googlegroups.com>;
        Tue, 22 Dec 2015 11:02:15 -0800 (PST)
Date: Tue, 22 Dec 2015 20:02:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/1] rtc: Replace simple_strtoul by kstrtoul
Message-ID: <20151222190215.GE8623@piout.net>
References: <1450357864-7852-1-git-send-email-clabbe.montjoie@gmail.com>
 <1450357864-7852-2-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1450357864-7852-2-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 17/12/2015 at 14:11:04 +0100, LABBE Corentin wrote :
> The simple_strtoul function is obsolete.
> This patch replace it by kstrtoul.
> 
> Since kstrtoul is more strict, it permits to filter some invalid input that
> simple_strtoul accept. For example:
> echo '1022xxx' > /sys/devices/pnp0/00:03/rtc/rtc0/max_user_freq
> cat /sys/devices/pnp0/00:03/rtc/rtc0/max_user_freq
> 1022
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sysfs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
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
