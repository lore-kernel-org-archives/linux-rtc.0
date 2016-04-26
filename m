Return-Path: <rtc-linux+bncBAABBGNV7W4AKGQE275LQDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from emea01-db3-obe.outbound.protection.outlook.com (mail-db3on0137.outbound.protection.outlook.com. [157.55.234.137])
        by gmr-mx.google.com with ESMTPS id n204si105107ywd.1.2016.04.26.05.10.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 05:10:00 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 2/3] misc: eeprom: add Cypress FM33256B FRAM driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-3-git-send-email-jlp@gomspace.com>
 <20160421235429.GA6086@piout.net>
CC: <lee.jones@linaro.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<a.zummo@towertech.it>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <rtc-linux@googlegroups.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Message-ID: <571F5A45.2050405@gomspace.com>
Date: Tue, 26 Apr 2016 14:08:37 +0200
MIME-Version: 1.0
In-Reply-To: <20160421235429.GA6086@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/04/16 01:54, Alexandre Belloni wrote:
> Hi,

Hi Alexandre,

> On 20/04/2016 at 13:07:50 +0200, Jeppe Ledet-Pedersen wrote :
>> Signed-off-by: Jeppe Ledet-Pedersen <jlp@gomspace.com>
>> ---
>>  MAINTAINERS                         |   1 +
>>  drivers/misc/eeprom/Kconfig         |  12 ++++
>>  drivers/misc/eeprom/Makefile        |   1 +
>>  drivers/misc/eeprom/fm33256b-fram.c | 110 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 124 insertions(+)
>>  create mode 100644 drivers/misc/eeprom/fm33256b-fram.c
>>
> 
> There is now an nvmem framework that will allow you to easily have both
> an in-kernel and a userspace interface.

Thanks, I'll take a look at nvmem. It does look like a much better fit.

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
