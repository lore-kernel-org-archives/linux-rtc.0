Return-Path: <rtc-linux+bncBCV6LFM5RQJRBMNSY2VQKGQEUGAD7SQ@googlegroups.com>
MIME-Version: 1.0
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id x3si775551pdh.2.2015.06.05.05.42.25
        for <rtc-linux@googlegroups.com>;
        Fri, 05 Jun 2015 05:42:25 -0700 (PDT)
From: Octavian Purdila <octavian.purdila@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [rtc-linux] [PATCH v2 0/2] fix drivers that consider 0 as a valid IRQ
 in client->irq
Date: Fri,  5 Jun 2015 15:41:56 +0300
Message-Id: <1433508118-3938-1-git-send-email-octavian.purdila@intel.com>
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

Since patch "i2c / ACPI: Use 0 to indicate that device does not have
interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
change all driver's checks accordingly.

The same issue occurs when the device is instantiated via device tree
with no IRQ, or from the i2c sysfs interface, even before the patch
above.

[1] https://lkml.org/lkml/2015/5/6/279

Changes since v1:

* remove the commit id as the referenced patch is not yet merged

* rephrased the subject line to be more descriptive

Octavian Purdila (2):
  iio: fix drivers that consider 0 as a valid IRQ in client->irq
  rtc: fix drivers that consider 0 as a valid IRQ in client->irq

 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/accel/mma9553.c      | 2 +-
 drivers/iio/imu/kmx61.c          | 8 ++++----
 drivers/rtc/rtc-ds1374.c         | 4 ++--
 drivers/rtc/rtc-ds3232.c         | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

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
