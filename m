Return-Path: <rtc-linux+bncBDS7HNEFSALRBE5Z46VQKGQEZKDQZGA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h1si104768wiw.1.2015.06.11.12.08.02
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Jun 2015 12:08:02 -0700 (PDT)
Date: Thu, 11 Jun 2015 21:08:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Paul Bolle <pebolle@tiscali.nl>
Subject: [rtc-linux] Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE
 for NTP synchronization
Message-ID: <20150611190801.GO5222@piout.net>
References: <1433236477-1724-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433236477-1724-1-git-send-email-xlpang@126.com>
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

On 02/06/2015 at 17:14:34 +0800, Xunlei Pang wrote :
> +config RTC_SYSTOHC
> +	bool "Set the RTC time based on NTP synchronization"
> +	default y
> +	help
> +	  If you say yes here, the system time (wall clock) will be stored
> +	  in the RTC specified by RTC_HCTOSYS_DEVICE approximately every 11
> +	  minutes if userspace reports synchronized NTP status.
> +
> +config RTC_SYSTOHC_DEVICE
> +	string "RTC used to synchronize NTP adjustment"
> +	depends on RTC_SYSTOHC
> +	default "rtc0"

To make that working nicely with current configurations, I would use:
default RTC_HCTOSYS_DEVICE


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
