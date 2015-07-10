Return-Path: <rtc-linux+bncBDKZNNNLXAHBBPGR7WWAKGQEPZ3UT2Q@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id tq2si813482pbc.0.2015.07.09.23.39.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 23:39:56 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NR900D37EIGED40@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 10 Jul 2015 07:39:52 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH] Drop owner assignment from i2c_driver (and
 platform left-overs)
Date: Fri, 10 Jul 2015 15:39:49 +0900
Message-id: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  rtc: Drop owner assignment from i2c_driver
  rtc: Drop owner assignment from platform_driver

 drivers/rtc/rtc-ab-b5ze-s3.c | 1 -
 drivers/rtc/rtc-bq32k.c      | 1 -
 drivers/rtc/rtc-ds1307.c     | 1 -
 drivers/rtc/rtc-ds1374.c     | 1 -
 drivers/rtc/rtc-ds3232.c     | 1 -
 drivers/rtc/rtc-fm3130.c     | 1 -
 drivers/rtc/rtc-hym8563.c    | 1 -
 drivers/rtc/rtc-isl12057.c   | 1 -
 drivers/rtc/rtc-opal.c       | 1 -
 drivers/rtc/rtc-pcf2127.c    | 1 -
 drivers/rtc/rtc-pcf85063.c   | 1 -
 drivers/rtc/rtc-pcf8523.c    | 1 -
 drivers/rtc/rtc-pcf8563.c    | 1 -
 drivers/rtc/rtc-pcf8583.c    | 1 -
 drivers/rtc/rtc-rx8025.c     | 1 -
 drivers/rtc/rtc-rx8581.c     | 1 -
 16 files changed, 16 deletions(-)

-- 
1.9.1

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
