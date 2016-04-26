Return-Path: <rtc-linux+bncBAABBKFZ7W4AKGQEUGYSGLY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0128.outbound.protection.outlook.com. [104.47.2.128])
        by gmr-mx.google.com with ESMTPS id n204si107110ywd.1.2016.04.26.05.18.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 05:18:48 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: add Cypress FM33256B RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-4-git-send-email-jlp@gomspace.com>
 <20160421234400.GG29844@piout.net>
CC: <lee.jones@linaro.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<a.zummo@towertech.it>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <rtc-linux@googlegroups.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Message-ID: <571F5C56.9080209@gomspace.com>
Date: Tue, 26 Apr 2016 14:17:26 +0200
MIME-Version: 1.0
In-Reply-To: <20160421234400.GG29844@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/04/16 01:44, Alexandre Belloni wrote:
> Hi,

Hi Alexandre,

> Looks mostly good, a few comments below

Thanks for the review. I'll add your fixes and send a v2 patch.

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
