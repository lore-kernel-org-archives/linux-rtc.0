Return-Path: <rtc-linux+bncBD2OLRXW4ABBBZUP3C2QKGQE62ELJEA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si2806138pac.1.2016.02.06.06.49.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2016 06:49:10 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V4 1/6] regmap: irq: add apis to unmap the mapped irq
Date: Sat, 6 Feb 2016 20:07:22 +0530
Message-ID: <1454769447-785-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Before removing irq domains, it is require to unmap all
mapped interrupt from that domain. Currently there is API
to map the interrupt on chip as regmap_irq_get_virq() for
creating mapping. Add equivalent API to dispose the mapped
irq in irq domains.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@osg.samsung.com>

---
This is new in the series which was identified when testing V3
series that it is require to unmap virq before deleting irq chip
domain. Adding this APIs in regmap irq framework.

 drivers/base/regmap/regmap-irq.c | 14 ++++++++++++++
 include/linux/regmap.h           |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 9b0d202..9b36fc8 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -707,6 +707,20 @@ int regmap_irq_get_virq(struct regmap_irq_chip_data *data, int irq)
 EXPORT_SYMBOL_GPL(regmap_irq_get_virq);
 
 /**
+ * regmap_irq_put_virq(): Unmap mapped interrupt of a chip in irq-domain.
+ *
+ * This routine is used to dispose the created mapping from irq domain
+ * which must be call before removing irq domain.
+ *
+ * @irq: virtual irq number which was mapped with irq domains.
+ */
+void regmap_irq_put_virq(int virq)
+{
+	irq_dispose_mapping(virq);
+}
+EXPORT_SYMBOL_GPL(regmap_irq_put_virq);
+
+/**
  * regmap_irq_get_domain(): Retrieve the irq_domain for the chip
  *
  * Useful for drivers to request their own IRQs and for integration
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 27aaac9..546eab5 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -870,6 +870,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *data);
 int regmap_irq_chip_get_base(struct regmap_irq_chip_data *data);
 int regmap_irq_get_virq(struct regmap_irq_chip_data *data, int irq);
+void regmap_irq_put_virq(int virq);
 struct irq_domain *regmap_irq_get_domain(struct regmap_irq_chip_data *data);
 
 #else
-- 
2.1.4

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
