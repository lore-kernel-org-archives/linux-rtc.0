Return-Path: <rtc-linux+bncBDS7HNEFSALRBR7GXGWQKGQEO37JGEY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si564318wib.2.2015.07.21.09.28.54
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jul 2015 09:28:54 -0700 (PDT)
Date: Tue, 21 Jul 2015 18:28:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: a.zummo@towertech.it, joshc@ni.com, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v3 0/2] RTC support for NXP LPC18xx family
Message-ID: <20150721162850.GE2853@piout.net>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436635730-15617-1-git-send-email-manabian@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 11/07/2015 at 19:28:48 +0200, Joachim Eastwood wrote :
> This patch set adds support for the RTC found on many NXP devices
> including LPC178x/18xx/408x/43xx. The RTC provides calendar and
> clock functionality together with alarm interrupt support.
> 
> The driver is a rework of an old driver by Kevin Wells. It has been
> modified to support modern resource allocation, device tree and
> generally cleaned up. Driver was originally written to support the
> LPC24xx platform but since this platform isn't upstream support has
> been removed. The LPC24xx name is still kept to preserve the origin
> of this hardware block.
> 
> Been a while since the last version, but this version should address
> all comments from Josh and Alexandre on v2. There has also been some
> rework from my side. Please have a look.
> 
> changes since v2:
>  - rework hw init
>  - update Kconfig text
>  - remove unused registers defines
>  - misc clean ups
>  - rebase on 4.2-rc1
> 
> changes since v1:
>  - s/lpc2k/lpc24xx for better consistency
>  - fix Kconfig entry
>  - drop support for old versions for the ip block
> 
> Patch set is based on Linux v4.2-rc1.
> 
> Joachim Eastwood (2):
>   rtc: add rtc-lpc24xx driver
>   doc: dt: add documentation for nxp,lpc1788-rtc
> 

Applied both after adding a proper commit log to the second patch,
reordering to avoid a checkpatch warning and fixing the typo in kevin's
mail address.


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
