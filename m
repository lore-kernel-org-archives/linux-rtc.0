Return-Path: <rtc-linux+bncBD2OLRXW4ABBBO54462QKGQECKYU7EY@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id tn7si5069147pac.1.2016.02.09.04.40.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 04:40:26 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V6 1/6] regmap: irq: dispose all virtual irq
 before removing domain
Date: Tue, 9 Feb 2016 17:58:22 +0530
Message-ID: <1455020907-4564-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
References: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
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

It is require to dispose all virtual irq of hwirq on chip
created on given irq domain before removing this irq domain.
Hence dispose all mapped irqs before deleting the irq domains
in regmap_del_irq_chip();

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
This is new in series. Earlier patch for adding APIs to dispose
virq via regmap is abandon and this patch took place.
The dispose of virw is added in regmap_del_irq_chip().

 drivers/base/regmap/regmap-irq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 9b0d202..7e1e9e8 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -655,13 +655,34 @@ EXPORT_SYMBOL_GPL(regmap_add_irq_chip);
  *
  * @irq: Primary IRQ for the device
  * @d:   regmap_irq_chip_data allocated by regmap_add_irq_chip()
+ *
+ * This function also dispose all mapped irq on chip.
  */
 void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 {
+	unsigned int virq;
+	int hwirq;
+
 	if (!d)
 		return;
 
 	free_irq(irq, d);
+
+	/* Dispose all virtual irq from irq domain before removing it */
+	for (hwirq = 0; hwirq < d->chip->num_irqs; hwirq++) {
+		/* Ignore hwirq if holes in the IRQ list */
+		if (!d->chip->irqs[hwirq].mask)
+			continue;
+
+		/*
+		 * Find the virtual irq of hwirq on chip and if it is
+		 * there then dispose it
+		 */
+		virq = irq_find_mapping(d->domain, hwirq);
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+
 	irq_domain_remove(d->domain);
 	kfree(d->type_buf);
 	kfree(d->type_buf_def);
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
