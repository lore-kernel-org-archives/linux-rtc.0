Return-Path: <rtc-linux+bncBDS7HNEFSALRBSMKZ23AKGQE6L2UCFI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h126si342948wme.0.2016.02.28.15.39.53
        for <rtc-linux@googlegroups.com>;
        Sun, 28 Feb 2016 15:39:53 -0800 (PST)
Date: Mon, 29 Feb 2016 00:39:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Group Kconfig entries by vendor
Message-ID: <20160228233943.GA3190@piout.net>
References: <1446621226-28429-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1446621226-28429-1-git-send-email-soren.brinkmann@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/11/2015 at 23:13:46 -0800, Soren Brinkmann wrote :
> The RTC entries are mostly grouped by vendor. Move the few outliers in
> place.
> Also, change the one occurrence of 'nxp' to 'NXP' to make all NXP
> entries consistent.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/rtc/Kconfig | 90 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
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
