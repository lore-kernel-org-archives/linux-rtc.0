Return-Path: <rtc-linux+bncBCV6LFM5RQJRB2GWY2VQKGQEZ6R6AII@googlegroups.com>
MIME-Version: 1.0
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id wh3si772102pbc.0.2015.06.05.07.00.08
        for <rtc-linux@googlegroups.com>;
        Fri, 05 Jun 2015 07:00:08 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v3 2/2] rtc: fix drivers that consider 0 as a
 valid IRQ in client->irq
Date: Fri,  5 Jun 2015 16:59:43 +0300
Message-Id: <1433512783-8183-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
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

[1] http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1374.c | 4 ++--
 drivers/rtc/rtc-ds3232.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 167783f..592458c 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -689,7 +689,7 @@ static int ds1374_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (client->irq >= 0 && device_may_wakeup(&client->dev))
+	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
 	return 0;
 }
@@ -698,7 +698,7 @@ static int ds1374_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (client->irq >= 0 && device_may_wakeup(&client->dev))
+	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
 	return 0;
 }
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7e48e53..f280dd1 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -443,7 +443,7 @@ static int ds3232_remove(struct i2c_client *client)
 {
 	struct ds3232 *ds3232 = i2c_get_clientdata(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		mutex_lock(&ds3232->mutex);
 		ds3232->exiting = 1;
 		mutex_unlock(&ds3232->mutex);
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
