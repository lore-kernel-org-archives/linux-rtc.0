Return-Path: <rtc-linux+bncBCV6LFM5RQJRBY6WY2VQKGQE5IG5ICQ@googlegroups.com>
MIME-Version: 1.0
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id wh3si772102pbc.0.2015.06.05.07.00.03
        for <rtc-linux@googlegroups.com>;
        Fri, 05 Jun 2015 07:00:03 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v3 1/2] iio: fix drivers that consider 0 as a
 valid IRQ in client->irq
Date: Fri,  5 Jun 2015 16:59:42 +0300
Message-Id: <1433512783-8183-2-git-send-email-octavian.purdila@intel.com>
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
---
 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/accel/mma9553.c      | 2 +-
 drivers/iio/imu/kmx61.c          | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 4e70f51..55751d9 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -1663,7 +1663,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = bmc150_accel_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(
 						&client->dev, client->irq,
 						bmc150_accel_irq_handler,
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 0d9bd35..aa93cbd 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1243,7 +1243,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = kxcjk1013_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kxcjk1013_data_rdy_trig_poll,
 						kxcjk1013_event_handler,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 9d649c4..df043b3 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1143,7 +1143,7 @@ static int mma9553_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = mma9553_gpio_probe(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						mma9553_irq_handler,
 						mma9553_event_handler,
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 462a010..82cdf50 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1363,7 +1363,7 @@ static int kmx61_probe(struct i2c_client *client,
 	if (client->irq < 0)
 		client->irq = kmx61_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kmx61_data_rdy_trig_poll,
 						kmx61_event_handler,
@@ -1445,10 +1445,10 @@ err_iio_unregister_mag:
 err_iio_unregister_acc:
 	iio_device_unregister(data->acc_indio_dev);
 err_buffer_cleanup_mag:
-	if (client->irq >= 0)
+	if (client->irq > 0)
 		iio_triggered_buffer_cleanup(data->mag_indio_dev);
 err_buffer_cleanup_acc:
-	if (client->irq >= 0)
+	if (client->irq > 0)
 		iio_triggered_buffer_cleanup(data->acc_indio_dev);
 err_trigger_unregister_motion:
 	iio_trigger_unregister(data->motion_trig);
@@ -1472,7 +1472,7 @@ static int kmx61_remove(struct i2c_client *client)
 	iio_device_unregister(data->acc_indio_dev);
 	iio_device_unregister(data->mag_indio_dev);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		iio_triggered_buffer_cleanup(data->acc_indio_dev);
 		iio_triggered_buffer_cleanup(data->mag_indio_dev);
 		iio_trigger_unregister(data->acc_dready_trig);
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
