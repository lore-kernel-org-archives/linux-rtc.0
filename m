Return-Path: <rtc-linux+bncBAABBVOFZ7BQKGQEITSQKYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id p138si896219wme.1.2017.01.09.01.25.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2017 01:25:35 -0800 (PST)
Message-ID: <1483953931.11465.13.camel@collabora.co.uk>
Subject: [rtc-linux] Question about RTC validity mechanism
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: rtc-linux@googlegroups.com
Date: Mon, 09 Jan 2017 10:25:31 +0100
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

I use a Seiko S35390A RTC that knows if the RTC has restarted when POC
value is set to 1. (POC is bit 0 of register status1).
In the current driver, the value is just ignored and lost in
s35390a_probe by calling s35390a_reset.

I need this feature to check if the RTC time is valid or not at boot.
Is there a standard mechanism to store this information and check at
boot that the RTC is valid?

Thanks

Fabien

datasheet: http://datasheet.sii-ic.com/en/real_time_clock/S35390A_E.pdf

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
