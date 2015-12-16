Return-Path: <rtc-linux+bncBDS7HNEFSALRBDN7Y6ZQKGQEBLZ6GWY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b62si373952wmc.0.2015.12.16.14.02.52
        for <rtc-linux@googlegroups.com>;
        Wed, 16 Dec 2015 14:02:52 -0800 (PST)
Date: Wed, 16 Dec 2015 23:02:52 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, justin.waters@timesys.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: Add Epson RX8010SJ RTC driver
Message-ID: <20151216220252.GJ8574@piout.net>
References: <1449171681-23701-1-git-send-email-akshay.bhat@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449171681-23701-1-git-send-email-akshay.bhat@timesys.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/12/2015 at 14:41:21 -0500, Akshay Bhat wrote :
> This driver supports the following functions:
>  - reading and setting time
>  - alarms when connected to an IRQ
>  - reading and clearing the voltage low flags
> 
> Datasheet:
> http://www.epsondevice.com/docs/qd/en/DownloadServlet?id=ID000956
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
> Changes in v2:
> - Address comments from Alexandre Belloni
> - Update copyright info
> - Use i2c_smbus_read_byte_data/i2c_smbus_read_i2c_block_data directly
> - Use ffs for wday instead of bcd2bin
> - Fixes from checkpatch --strict
> - Limit date range to 2000 to 2100
> - Fix incorrect write to RX8010_WDAY
> - Do not clear VLF flag on power up
> 
>  drivers/rtc/Kconfig      |  10 +
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-rx8010.c | 523 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 534 insertions(+)
>  create mode 100644 drivers/rtc/rtc-rx8010.c
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
