Return-Path: <rtc-linux+bncBDS7HNEFSALRB46TXGXAKGQEVAFHLBA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p7si127876wib.1.2015.08.14.15.21.38
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Aug 2015 15:21:38 -0700 (PDT)
Date: Sat, 15 Aug 2015 00:21:37 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [rtc-linux] [PATCH 00/11] rtc: clean up bin attribute read/write functions
Message-ID: <20150814222137.GO22269@piout.net>
References: <1437947316-5652-1-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437947316-5652-1-git-send-email-vz@mleia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27/07/2015 at 00:48:25 +0300, Vladimir Zapolskiy wrote :
> This change removes a number of redundant checks on bin attribute
> client's side, the same checks are done by sysfs_kf_bin_read() or
> sysfs_kf_bin_write() caller from fs/sysfs/file.c.
> 
> Note, drivers/rtc/rtc-ds1685.c may be updated in a similar way,
> however due to #ifndef magic involved this task is not done.
> 
> No functional change intended.
> 
> Vladimir Zapolskiy (11):
>   rtc: cmos: clean up cmos_nvram_read()/cmos_nvram_write()
>   rtc: ds1305: clean up ds1305_nvram_read()/ds1305_nvram_write()
>   rtc: ds1307: clean up ds1307_nvram_read()/ds1307_nvram_write()
>   rtc: ds1343: clean up ds1343_nvram_read()/ds1343_nvram_write()
>   rtc: ds1511: clean up ds1511_nvram_read()/ds1511_nvram_write()
>   rtc: ds1553: clean up ds1553_nvram_read()/ds1553_nvram_write()
>   rtc: ds1742: clean up ds1742_nvram_read()/ds1742_nvram_write()
>   rtc: m48t59: clean up m48t59_nvram_read()/m48t59_nvram_write()
>   rtc: rp5c01: clean up rp5c01_nvram_read()/rp5c01_nvram_write()
>   rtc: stk17ta8: clean up stk17ta8_nvram_read()/stk17ta8_nvram_write()
>   rtc: tx4939: clean up tx4939_rtc_nvram_read()/tx4939_rtc_nvram_write()
> 
>  drivers/rtc/rtc-cmos.c     | 13 -------------
>  drivers/rtc/rtc-ds1305.c   | 18 ------------------
>  drivers/rtc/rtc-ds1307.c   | 14 --------------
>  drivers/rtc/rtc-ds1343.c   | 12 ------------
>  drivers/rtc/rtc-ds1511.c   | 38 ++++++++------------------------------
>  drivers/rtc/rtc-ds1553.c   |  4 ++--
>  drivers/rtc/rtc-ds1742.c   |  4 ++--
>  drivers/rtc/rtc-m48t59.c   | 16 ++++++++--------
>  drivers/rtc/rtc-rp5c01.c   |  4 ++--
>  drivers/rtc/rtc-stk17ta8.c |  4 ++--
>  drivers/rtc/rtc-tx4939.c   |  6 ++----
>  11 files changed, 26 insertions(+), 107 deletions(-)
> 

All applied (v2 when available), thanks


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
