Return-Path: <rtc-linux+bncBAABBTWH3W4AKGQEBSIHMZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from emea01-am1-obe.outbound.protection.outlook.com (mail-am1on0116.outbound.protection.outlook.com. [157.56.112.116])
        by gmr-mx.google.com with ESMTPS id d22si4214501pfd.0.2016.04.20.04.11.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 04:11:09 -0700 (PDT)
From: Jeppe Ledet-Pedersen <jlp@gomspace.com>
To: <lee.jones@linaro.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [rtc-linux] [PATCH 0/3] Cypress FM33256B processor companion support
Date: Wed, 20 Apr 2016 13:07:48 +0200
Message-ID: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

This series adds support for the Cypress Semiconductor FM33256B processor
companion. The device contains a 256 kbit FRAM, an RTC, a supply voltage
monitor, and a watchdog timer. Only the FRAM and RTC are supported by these
patches.

The device is implemented as an MFD device. The FRAM interface is currently
implemented as an SPI regmap, wrapped by a binary sysfs file. If another
interface would be a better choice, please let me know.

Thanks,

-Jeppe

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
