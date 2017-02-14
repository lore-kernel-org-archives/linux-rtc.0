Return-Path: <rtc-linux+bncBC2IF264UIPRBD4DR3CQKGQE3TVV7RQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id f7si229955wmg.3.2017.02.14.14.15.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 14:15:42 -0800 (PST)
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [rtc-linux] [PATCH v3 1/4] mfd: cros_ec: Add helper for event notifier.
Date: Tue, 14 Feb 2017 23:15:26 +0100
Message-Id: <20170214221529.6434-1-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Gwendal Grignou <gwendal@chromium.org>

Add cros_ec_get_event() entry point to retrieve event within functions
called by the notifier.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes since v2:
 - none
Changes since v1:
 - Acked by Lee Jones

 drivers/platform/chrome/cros_ec_proto.c | 20 ++++++++++++++++++++
 include/linux/mfd/cros_ec.h             | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ed5dee7..7428c2b 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -494,3 +494,23 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev)
 		return get_keyboard_state_event(ec_dev);
 }
 EXPORT_SYMBOL(cros_ec_get_next_event);
+
+u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
+{
+	u32 host_event;
+
+	BUG_ON(!ec_dev->mkbp_event_supported);
+
+	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
+		return 0;
+
+	if (ec_dev->event_size != sizeof(host_event)) {
+		dev_warn(ec_dev->dev, "Invalid host event size\n");
+		return 0;
+	}
+
+	host_event = get_unaligned_le32(&ec_dev->event_data.data.host_event);
+
+	return host_event;
+}
+EXPORT_SYMBOL(cros_ec_get_host_event);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index b3d04de..be2c4eb 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -299,6 +299,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev);
  */
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
 
+/**
+ * cros_ec_get_host_event - Return a mask of event set by the EC.
+ *
+ * When MKBP is supported, when the EC raises an interrupt,
+ * We collect the events raised and call the functions in the ec notifier.
+ *
+ * This function is a helper to know which events are raised.
+ */
+u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
+
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 extern struct attribute_group cros_ec_lightbar_attr_group;
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
