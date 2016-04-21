Return-Path: <rtc-linux+bncBDS7HNEFSALRBNWQ4W4AKGQEULWBJQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u137si9295wmd.1.2016.04.21.16.54.30
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 16:54:30 -0700 (PDT)
Date: Fri, 22 Apr 2016 01:54:29 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Cc: lee.jones@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	a.zummo@towertech.it, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/3] misc: eeprom: add Cypress FM33256B FRAM driver
Message-ID: <20160421235429.GA6086@piout.net>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-3-git-send-email-jlp@gomspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461150471-23163-3-git-send-email-jlp@gomspace.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 20/04/2016 at 13:07:50 +0200, Jeppe Ledet-Pedersen wrote :
> Signed-off-by: Jeppe Ledet-Pedersen <jlp@gomspace.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/misc/eeprom/Kconfig         |  12 ++++
>  drivers/misc/eeprom/Makefile        |   1 +
>  drivers/misc/eeprom/fm33256b-fram.c | 110 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 124 insertions(+)
>  create mode 100644 drivers/misc/eeprom/fm33256b-fram.c
> 

There is now an nvmem framework that will allow you to easily have both
an in-kernel and a userspace interface.

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
