Return-Path: <rtc-linux+bncBD3I5H5WUEBBBDXM63CQKGQE3X3EOGQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (mail-by2nam01on0065.outbound.protection.outlook.com. [104.47.34.65])
        by gmr-mx.google.com with ESMTPS id r66si195853pfb.7.2017.03.06.11.18.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 11:18:37 -0800 (PST)
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>
CC: <rtc-linux@googlegroups.com>, <Jagadish.Hadimani@amd.com>,
	<linux-kernel@vger.kernel.org>
From: "Shah, Nehal-bakulchandra" <Nehal-Bakulchandra.shah@amd.com>
Subject: [rtc-linux] Kernel without RTC
Message-ID: <221f9318-749f-03b8-aac8-85e9f9bec318@amd.com>
Date: Tue, 7 Mar 2017 00:48:18 +0530
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

Currently we are having hardware which does not have RTC. It is single processor system. However it does have TSC timer.

Now, how to use scheduler with only TSC as current kernel scheduler leverage the RTC for scheduling? I had seen one old patch

http://marc.info/?l=linux-kernel&m=112013203625990&w=2 

But i guess this patch was later on not taken, It will be great if you can some pointers to move forward?


Thanks 
Nehal

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
