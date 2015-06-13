Return-Path: <rtc-linux+bncBDS7HNEFSALRBJWB6CVQKGQEPNPJAUA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si230023wiz.0.2015.06.13.05.23.02
        for <rtc-linux@googlegroups.com>;
        Sat, 13 Jun 2015 05:23:02 -0700 (PDT)
Date: Sat, 13 Jun 2015 14:23:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Paul Bolle <pebolle@tiscali.nl>
Subject: [rtc-linux] Re: [PATCH v3 1/3] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE
 for NTP synchronization
Message-ID: <20150613122301.GI3890@piout.net>
References: <1434078618-16373-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1434078618-16373-1-git-send-email-xlpang@126.com>
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

On 12/06/2015 at 11:10:16 +0800, Xunlei Pang wrote :
> +config RTC_SYSTOHC_DEVICE
> +	string "RTC used to synchronize NTP adjustment"
> +	depends on RTC_SYSTOHC
> +	default RTC_HCTOSYS_DEVICE

Actually, I forgot one case so I changed it to:
+       default RTC_HCTOSYS_DEVICE if RTC_HCTOSYS
+       default "rtc0"

I applied both series, thanks.

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
