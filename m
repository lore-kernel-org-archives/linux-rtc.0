Return-Path: <rtc-linux+bncBDJ4N37Q6EERB2W5TKYAKGQEISTOTSY@googlegroups.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id zg1si962640pbb.2.2015.09.26.07.42.49
        for <rtc-linux@googlegroups.com>;
        Sat, 26 Sep 2015 07:42:49 -0700 (PDT)
Date: Sat, 26 Sep 2015 22:42:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: kbuild-all@01.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] drivers/rtc/rtc-rv8803.c:494:3-8: No need to set .owner
 here. The core will do it.
Message-ID: <201509262245.qTOvBbXQ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1443275679-21459-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

FYI, build test results on v4.3-rc2 (pls ignore if it's inappropriate base for your patch).


coccinelle warnings: (new ones prefixed by >>)

>> drivers/rtc/rtc-rv8803.c:494:3-8: No need to set .owner here. The core will do it.
--
>> drivers/rtc/rtc-rv8803.c:350:2-5: WARNING: end returns can be simpified if negative or 0 value

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

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
