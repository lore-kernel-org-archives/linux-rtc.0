Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXXXYPCAKGQEBFUXINI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si1520878wma.3.2017.01.31.13.04.29
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Jan 2017 13:04:29 -0800 (PST)
Date: Tue, 31 Jan 2017 22:04:29 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: sre@kernel.org, shawnguo@kernel.org, Frank.Li@freescale.com,
	fabio.estevam@nxp.com, a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: snvs: add a missing write sync
Message-ID: <20170131210429.zoh75tcr4ymvsw6o@piout.net>
References: <1485683839-8843-1-git-send-email-guy.shapiro@mobi-wize.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1485683839-8843-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/01/2017 at 11:57:19 +0200, Guy Shapiro wrote:
> The clear of the LPTA_EN flag should be synced before writing to the
> alarm register. Omitting this synchronization creates a race when
> trying to change existing alarm.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> ---
>  drivers/rtc/rtc-snvs.c | 1 +
>  1 file changed, 1 insertion(+)
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
